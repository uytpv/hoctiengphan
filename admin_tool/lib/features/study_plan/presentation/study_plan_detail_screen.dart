import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_tool/features/study_plan/data/study_plan_repository.dart';
import 'package:admin_tool/features/study_plan/domain/study_plan.dart';
import 'package:admin_tool/features/activity/domain/activity.dart';
import 'package:admin_tool/features/activity/data/activity_repository.dart';

final planWeeksProvider = StreamProvider.family<List<StudyPlanWeek>, String>((
  ref,
  planId,
) {
  return ref.watch(studyPlanRepositoryProvider).getWeeksForPlan(planId);
});

class StudyPlanDetailScreen extends ConsumerWidget {
  final String planId;

  const StudyPlanDetailScreen({super.key, required this.planId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeksAsync = ref.watch(planWeeksProvider(planId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi Tiết Lộ Trình'),
        actions: [
          ElevatedButton.icon(
            onPressed: () => _handleAddWeek(context, ref),
            icon: const Icon(Icons.add),
            label: const Text('Thêm Tuần'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: weeksAsync.when(
        data: (weeks) {
          if (weeks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Không có dữ liệu tuần học.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => _handleAddWeek(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('Thêm Tuần'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: weeks.length,
            itemBuilder: (context, index) {
              final week = weeks[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    child: Text(
                      '${week.weekNumber}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          week.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, size: 16),
                        onPressed: () => _editWeekTitle(context, ref, week),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    '${week.days.length} ngày • ${week.days.fold(0, (sum, day) => sum + day.activityIds.length)} hoạt động',
                  ),
                  children: week.days.asMap().entries.map((entry) {
                    final dayIndex = entry.key;
                    final day = entry.value;
                    return ListTile(
                      dense: true,
                      leading: const Icon(Icons.calendar_today, size: 16),
                      title: Text(day.dayName),
                      subtitle: _ActivitiesSummary(
                        activityIds: day.activityIds,
                      ),
                      trailing: const Icon(Icons.add_circle_outline, size: 16),
                      onTap: () =>
                          _manageDayActivities(context, ref, week, dayIndex),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Future<void> _editWeekTitle(
    BuildContext context,
    WidgetRef ref,
    StudyPlanWeek week,
  ) async {
    final controller = TextEditingController(text: week.title);
    final newTitle = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Đổi tên tuần học'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Nhập tên tuần mới'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Lưu'),
          ),
        ],
      ),
    );

    if (newTitle != null && newTitle.isNotEmpty) {
      final updatedWeek = week.copyWith(title: newTitle);
      ref.read(studyPlanRepositoryProvider).updateWeek(updatedWeek);
    }
  }

  Future<void> _manageDayActivities(
    BuildContext context,
    WidgetRef ref,
    StudyPlanWeek week,
    int dayIndex,
  ) async {
    await showDialog(
      context: context,
      builder: (context) =>
          StudyDayActivityManagementDialog(week: week, dayIndex: dayIndex),
    );
  }

  Future<void> _handleAddWeek(BuildContext context, WidgetRef ref) async {
    final weeksAsync = ref.read(planWeeksProvider(planId));
    final weeks = weeksAsync.value ?? [];

    final nextWeekNum = weeks.isEmpty
        ? 1
        : (weeks.map((w) => w.weekNumber).reduce((a, b) => a > b ? a : b) + 1);

    final titleController = TextEditingController(text: 'Tuần $nextWeekNum, ');

    final newTitle = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thêm tuần học mới'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: 'Tên tuần học',
            hintText: 'VD: Tuần 1, giới thiệu khóa học',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.trim().isEmpty) {
                return;
              }
              Navigator.pop(context, titleController.text.trim());
            },
            child: const Text('Thêm'),
          ),
        ],
      ),
    );

    if (newTitle != null && newTitle.isNotEmpty) {
      final newWeek = StudyPlanWeek(
        id: const Uuid().v4(),
        planId: planId,
        weekNumber: nextWeekNum,
        title: newTitle,
        days: const [
          StudyDay(dayName: 'Maanantai (Thứ 2)', activityIds: []),
          StudyDay(dayName: 'Tiistai (Thứ 3)', activityIds: []),
          StudyDay(dayName: 'Keskiviikko (Thứ 4)', activityIds: []),
          StudyDay(dayName: 'Torstai (Thứ 5)', activityIds: []),
          StudyDay(dayName: 'Perjantai (Thứ 6)', activityIds: []),
          StudyDay(dayName: 'Lauantai (Thứ 7)', activityIds: []),
          StudyDay(dayName: 'Sunnuntai (Chủ Nhật)', activityIds: []),
        ],
      );

      try {
        await ref.read(studyPlanRepositoryProvider).createWeek(newWeek);

        // Cập nhật durationWeeks của StudyPlan trong Firestore (tăng thêm 1)
        final plansAsync = ref.read(studyPlansStreamProvider);
        final plans = plansAsync.value ?? [];
        final planIndex = plans.indexWhere((p) => p.id == planId);
        if (planIndex != -1) {
          final plan = plans[planIndex];
          final updatedPlan = plan.copyWith(
            durationWeeks: plan.durationWeeks + 1,
          );
          await ref.read(studyPlanRepositoryProvider).updatePlan(updatedPlan);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lỗi khi thêm tuần học: $e')),
          );
        }
      }
    }
  }
}

class _ActivitiesSummary extends ConsumerWidget {
  final List<String> activityIds;
  const _ActivitiesSummary({required this.activityIds});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (activityIds.isEmpty) {
      return const Text('0 hoạt động');
    }

    final activitiesAsync = ref.watch(activitiesStreamProvider);
    return activitiesAsync.when(
      data: (allActivities) {
        final titles = activityIds
            .map((id) {
              final activity = allActivities.firstWhere(
                (a) => a.id == id,
                orElse: () => const Activity(
                  id: '',
                  title: 'Unknown',
                  type: ActivityType.breakTime,
                ),
              );
              return activity.title;
            })
            .join(', ');
        return Text(titles, maxLines: 1, overflow: TextOverflow.ellipsis);
      },
      loading: () => const SizedBox(),
      error: (_, __) => const Text('Error loading activities'),
    );
  }
}

class StudyDayActivityManagementDialog extends ConsumerStatefulWidget {
  final StudyPlanWeek week;
  final int dayIndex;

  const StudyDayActivityManagementDialog({
    super.key,
    required this.week,
    required this.dayIndex,
  });

  @override
  ConsumerState<StudyDayActivityManagementDialog> createState() =>
      _StudyDayActivityManagementDialogState();
}

class _StudyDayActivityManagementDialogState
    extends ConsumerState<StudyDayActivityManagementDialog> {
  String _searchQuery = '';
  String _selectedFilter = 'all'; // 'all', 'lesson', 'exercise'

  @override
  Widget build(BuildContext context) {
    // Watch the weeks stream to get the latest data for this specific week
    final weeksAsync = ref.watch(planWeeksProvider(widget.week.planId));

    return weeksAsync.when(
      data: (weeks) {
        // Find the most up-to-date version of this week
        final updatedWeek = weeks.firstWhere(
          (w) => w.id == widget.week.id,
          orElse: () => widget.week,
        );
        final day = updatedWeek.days[widget.dayIndex];
        final allActivitiesAsync = ref.watch(activitiesStreamProvider);

        return AlertDialog(
          title: Text('Hoạt động: ${day.dayName}'),
          content: SizedBox(
            width: 550,
            height: 650,
            child: allActivitiesAsync.when(
              data: (allActivities) {
                final currentActivities = day.activityIds
                    .map(
                      (id) => allActivities.firstWhere(
                        (a) => a.id == id,
                        orElse: () => Activity(
                          id: id,
                          title: 'Unknown ID: $id',
                          type: ActivityType.breakTime,
                        ),
                      ),
                    )
                    .toList();

                // Lọc danh sách hoạt động dựa trên tìm kiếm và bộ lọc nhanh
                final filteredNewActivities = allActivities.where((activity) {
                  // Không hiển thị nếu đã được thêm vào ngày hiện tại
                  if (day.activityIds.contains(activity.id)) {
                    return false;
                  }
                  
                  // Lọc theo từ khóa tìm kiếm
                  final matchesSearch = activity.title.toLowerCase().contains(_searchQuery.toLowerCase()) || 
                      (activity.description.toLowerCase().contains(_searchQuery.toLowerCase()));
                  if (!matchesSearch) return false;

                  // Lọc theo loại hoạt động
                  if (_selectedFilter == 'lesson') {
                    return activity.type == ActivityType.lesson;
                  } else if (_selectedFilter == 'exercise') {
                    return activity.type == ActivityType.exercise;
                  }

                  return true;
                }).toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Danh sách hoạt động trong ngày:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      flex: 4,
                      child: currentActivities.isEmpty
                          ? const Center(
                              child: Text(
                                'Chưa gán hoạt động nào.',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: currentActivities.length,
                              itemBuilder: (context, index) {
                                final activity = currentActivities[index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(vertical: 4),
                                  child: ListTile(
                                    leading: _getTypeIcon(activity.type),
                                    title: Text(activity.title),
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                      ),
                                      onPressed: () =>
                                          _removeActivity(ref, updatedWeek, index),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    const Divider(),
                    const SizedBox(height: 8),
                    const Text(
                      'Thêm hoạt động mới:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    // Search Bar
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Tìm kiếm hoạt động...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Filter Chips
                    Row(
                      children: [
                        FilterChip(
                          label: const Text('Tất cả'),
                          selected: _selectedFilter == 'all',
                          onSelected: (selected) {
                            if (selected) {
                              setState(() => _selectedFilter = 'all');
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                        FilterChip(
                          label: const Text('Bài học'),
                          selected: _selectedFilter == 'lesson',
                          onSelected: (selected) {
                            if (selected) {
                              setState(() => _selectedFilter = 'lesson');
                            }
                          },
                        ),
                        const SizedBox(width: 8),
                        FilterChip(
                          label: const Text('Bài tập'),
                          selected: _selectedFilter == 'exercise',
                          onSelected: (selected) {
                            if (selected) {
                              setState(() => _selectedFilter = 'exercise');
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      flex: 6,
                      child: filteredNewActivities.isEmpty
                          ? const Center(
                              child: Text(
                                'Không tìm thấy hoạt động nào phù hợp.',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: filteredNewActivities.length,
                              itemBuilder: (context, index) {
                                final activity = filteredNewActivities[index];
                                return ListTile(
                                  dense: true,
                                  leading: _getTypeIcon(activity.type),
                                  title: Text(activity.title),
                                  trailing: const Icon(Icons.add),
                                  onTap: () =>
                                      _addActivity(ref, updatedWeek, activity.id),
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Text('Error: $e'),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Đóng'),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Text('Error: $e'),
    );
  }

  void _addActivity(
    WidgetRef ref,
    StudyPlanWeek currentWeek,
    String activityId,
  ) {
    final updatedDays = [...currentWeek.days];
    final day = updatedDays[widget.dayIndex];
    updatedDays[widget.dayIndex] = day.copyWith(
      activityIds: [...day.activityIds, activityId],
    );

    final updatedWeek = currentWeek.copyWith(days: updatedDays);
    ref.read(studyPlanRepositoryProvider).updateWeek(updatedWeek);
  }

  void _removeActivity(WidgetRef ref, StudyPlanWeek currentWeek, int index) {
    final updatedDays = [...currentWeek.days];
    final day = updatedDays[widget.dayIndex];
    final newIds = [...day.activityIds];
    newIds.removeAt(index);
    updatedDays[widget.dayIndex] = day.copyWith(activityIds: newIds);

    final updatedWeek = currentWeek.copyWith(days: updatedDays);
    ref.read(studyPlanRepositoryProvider).updateWeek(updatedWeek);
  }

  Icon _getTypeIcon(ActivityType type) {
    switch (type) {
      case ActivityType.lesson:
        return const Icon(Icons.book, size: 20);
      case ActivityType.music:
        return const Icon(Icons.music_note, size: 20);
      case ActivityType.exercise:
        return const Icon(Icons.edit_note, size: 20);
      case ActivityType.communication:
        return const Icon(Icons.chat, size: 20);
      case ActivityType.writing:
        return const Icon(Icons.create, size: 20);
      case ActivityType.observation:
        return const Icon(Icons.visibility, size: 20);
      case ActivityType.movie:
        return const Icon(Icons.movie, size: 20);
      case ActivityType.breakTime:
        return const Icon(Icons.hourglass_empty, size: 20);
    }
  }
}
