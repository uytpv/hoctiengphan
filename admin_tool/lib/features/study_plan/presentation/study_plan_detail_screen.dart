import 'package:flutter/material.dart';
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
      appBar: AppBar(title: const Text('Chi Tiết Lộ Trình')),
      body: weeksAsync.when(
        data: (weeks) {
          if (weeks.isEmpty) {
            return const Center(child: Text('Không có dữ liệu tuần học.'));
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
}

class _ActivitiesSummary extends ConsumerWidget {
  final List<String> activityIds;
  const _ActivitiesSummary({required this.activityIds});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (activityIds.isEmpty) return const Text('0 hoạt động');

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

class StudyDayActivityManagementDialog extends ConsumerWidget {
  final StudyPlanWeek week;
  final int dayIndex;

  const StudyDayActivityManagementDialog({
    super.key,
    required this.week,
    required this.dayIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the weeks stream to get the latest data for this specific week
    final weeksAsync = ref.watch(planWeeksProvider(week.planId));

    return weeksAsync.when(
      data: (weeks) {
        // Find the most up-to-date version of this week
        final updatedWeek = weeks.firstWhere(
          (w) => w.id == week.id,
          orElse: () => week,
        );
        final day = updatedWeek.days[dayIndex];
        final allActivitiesAsync = ref.watch(activitiesStreamProvider);

        return AlertDialog(
          title: Text('Hoạt động: ${day.dayName}'),
          content: SizedBox(
            width: 500,
            height: 600,
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

                return Column(
                  children: [
                    const Text(
                      'Danh sách hoạt động trong ngày:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        itemCount: currentActivities.length,
                        itemBuilder: (context, index) {
                          final activity = currentActivities[index];
                          return ListTile(
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
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    const Text(
                      'Thêm hoạt động mới:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        itemCount: allActivities.length,
                        itemBuilder: (context, index) {
                          final activity = allActivities[index];
                          if (day.activityIds.contains(activity.id))
                            return const SizedBox();
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
    final day = updatedDays[dayIndex];
    updatedDays[dayIndex] = day.copyWith(
      activityIds: [...day.activityIds, activityId],
    );

    final updatedWeek = currentWeek.copyWith(days: updatedDays);
    ref.read(studyPlanRepositoryProvider).updateWeek(updatedWeek);
  }

  void _removeActivity(WidgetRef ref, StudyPlanWeek currentWeek, int index) {
    final updatedDays = [...currentWeek.days];
    final day = updatedDays[dayIndex];
    final newIds = [...day.activityIds];
    newIds.removeAt(index);
    updatedDays[dayIndex] = day.copyWith(activityIds: newIds);

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
