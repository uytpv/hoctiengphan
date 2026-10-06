import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_tool/features/study_plan/data/study_plan_repository.dart';
import 'package:admin_tool/features/study_plan/domain/study_plan.dart';
import 'package:admin_tool/features/lesson/data/lesson_repository.dart';
import 'package:admin_tool/features/lesson/domain/lesson.dart';
import 'package:admin_tool/features/grammar/data/grammar_repository.dart';
import 'package:admin_tool/features/grammar/domain/grammar.dart';
import 'package:admin_tool/features/immersion/data/immersion_repository.dart';
import 'package:admin_tool/features/immersion/domain/immersion_resource.dart';

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
        title: const Text('Chi Tiết Lộ Trình Học'),
        actions: [
          ElevatedButton.icon(
            onPressed: () => _handleAddWeek(context, ref),
            icon: const Icon(Icons.add),
            label: const Text('Thêm Tuần Mới'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent.shade700,
              foregroundColor: Colors.white,
            ),
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
                    'Chưa có dữ liệu tuần học nào trong lộ trình.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => _handleAddWeek(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('Thêm Tuần Đầu Tiên'),
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
              final totalActions = week.days.fold(
                0,
                (sum, day) => sum + (day.actions.isNotEmpty ? day.actions.length : day.activityIds.length),
              );

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueGrey.shade800,
                    child: Text(
                      '${week.weekNumber}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          week.title,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, size: 18),
                        tooltip: 'Đổi tên tuần',
                        onPressed: () => _editWeekTitle(context, ref, week),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    '${week.days.length} ngày • $totalActions nhiệm vụ học tập',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  children: week.days.asMap().entries.map((entry) {
                    final dayIndex = entry.key;
                    final day = entry.value;
                    return ListTile(
                      dense: true,
                      leading: const Icon(Icons.calendar_today, size: 18, color: Colors.blueGrey),
                      title: Text(
                        day.dayName,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                      subtitle: _DayActionsSummary(day: day),
                      trailing: ElevatedButton.icon(
                        icon: const Icon(Icons.playlist_add_check, size: 16),
                        label: const Text('Quản lý'),
                        style: ElevatedButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        ),
                        onPressed: () => _manageDayActions(context, ref, week, dayIndex),
                      ),
                      onTap: () => _manageDayActions(context, ref, week, dayIndex),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Lỗi tải tuần học: $e')),
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
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
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

  Future<void> _manageDayActions(
    BuildContext context,
    WidgetRef ref,
    StudyPlanWeek week,
    int dayIndex,
  ) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StudyDayActionManagementDialog(week: week, dayIndex: dayIndex),
    );
  }

  Future<void> _handleAddWeek(BuildContext context, WidgetRef ref) async {
    final weeksAsync = ref.read(planWeeksProvider(planId));
    final weeks = weeksAsync.value ?? [];

    final nextWeekNum = weeks.isEmpty
        ? 1
        : (weeks.map((w) => w.weekNumber).reduce((a, b) => a > b ? a : b) + 1);

    final titleController = TextEditingController(text: 'Tuần $nextWeekNum: ');

    final newTitle = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thêm tuần học mới'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: 'Tên tuần học',
            hintText: 'VD: Tuần 1: Chào hỏi & Làm quen',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.trim().isNotEmpty) {
                Navigator.pop(context, titleController.text.trim());
              }
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
          StudyDay(dayIndex: 1, dayName: 'Maanantai (Thứ 2)'),
          StudyDay(dayIndex: 2, dayName: 'Tiistai (Thứ 3)'),
          StudyDay(dayIndex: 3, dayName: 'Keskiviikko (Thứ 4)'),
          StudyDay(dayIndex: 4, dayName: 'Torstai (Thứ 5)'),
          StudyDay(dayIndex: 5, dayName: 'Perjantai (Thứ 6)'),
          StudyDay(dayIndex: 6, dayName: 'Lauantai (Thứ 7)'),
          StudyDay(dayIndex: 7, dayName: 'Sunnuntai (Chủ Nhật)'),
        ],
      );

      try {
        await ref.read(studyPlanRepositoryProvider).createWeek(newWeek);
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lỗi khi thêm tuần: $e')),
          );
        }
      }
    }
  }
}

class _DayActionsSummary extends StatelessWidget {
  final StudyDay day;

  const _DayActionsSummary({required this.day});

  @override
  Widget build(BuildContext context) {
    if (day.actions.isEmpty && day.activityIds.isEmpty) {
      return Text('0 nhiệm vụ', style: TextStyle(color: Colors.grey.shade500));
    }

    if (day.actions.isNotEmpty) {
      return Wrap(
        spacing: 6,
        runSpacing: 4,
        children: day.actions.map((act) {
          return Chip(
            avatar: Icon(_getActionIcon(act.type), size: 14),
            label: Text(
              act.title,
              style: const TextStyle(fontSize: 11),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            padding: EdgeInsets.zero,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: _getActionColor(act.type).withValues(alpha: 0.12),
          );
        }).toList(),
      );
    }

    return Text('${day.activityIds.length} hoạt động (cũ)', style: const TextStyle(color: Colors.grey));
  }

  IconData _getActionIcon(ActionItemType type) {
    switch (type) {
      case ActionItemType.lessonFull:
      case ActionItemType.lessonSlice:
        return Icons.school;
      case ActionItemType.vocabularySet:
        return Icons.spellcheck;
      case ActionItemType.grammarPoint:
        return Icons.auto_stories;
      case ActionItemType.exerciseSet:
        return Icons.assignment;
      case ActionItemType.immersionMusic:
        return Icons.music_note;
      case ActionItemType.immersionMovie:
        return Icons.movie;
      case ActionItemType.immersionSign:
        return Icons.traffic;
      case ActionItemType.custom:
        return Icons.star_border;
    }
  }

  Color _getActionColor(ActionItemType type) {
    switch (type) {
      case ActionItemType.lessonFull:
      case ActionItemType.lessonSlice:
        return Colors.blue;
      case ActionItemType.vocabularySet:
        return Colors.green;
      case ActionItemType.grammarPoint:
        return Colors.orange;
      case ActionItemType.exerciseSet:
        return Colors.indigo;
      case ActionItemType.immersionMusic:
        return Colors.purple;
      case ActionItemType.immersionMovie:
        return Colors.deepOrange;
      case ActionItemType.immersionSign:
        return Colors.teal;
      case ActionItemType.custom:
        return Colors.blueGrey;
    }
  }
}

class StudyDayActionManagementDialog extends ConsumerStatefulWidget {
  final StudyPlanWeek week;
  final int dayIndex;

  const StudyDayActionManagementDialog({
    super.key,
    required this.week,
    required this.dayIndex,
  });

  @override
  ConsumerState<StudyDayActionManagementDialog> createState() =>
      _StudyDayActionManagementDialogState();
}

class _StudyDayActionManagementDialogState
    extends ConsumerState<StudyDayActionManagementDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Lesson? _selectedLesson;
  String _lessonSliceMode = 'full'; // 'full', 'vocab', 'grammar', 'exercise'
  Grammar? _selectedGrammar;
  ImmersionResource? _selectedImmersion;

  // Custom action controllers
  final _customTitleController = TextEditingController();
  final _customGoalController = TextEditingController();
  final _customTimeController = TextEditingController(text: '15');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _customTitleController.dispose();
    _customGoalController.dispose();
    _customTimeController.dispose();
    super.dispose();
  }

  Future<void> _addAction(DailyActionItem action) async {
    final weeks = ref.read(planWeeksProvider(widget.week.planId)).value ?? [];
    final currentWeek = weeks.firstWhere((w) => w.id == widget.week.id, orElse: () => widget.week);
    final day = currentWeek.days[widget.dayIndex];

    final updatedActions = [...day.actions, action];
    final updatedDay = day.copyWith(actions: updatedActions);

    final updatedDays = List<StudyDay>.from(currentWeek.days);
    updatedDays[widget.dayIndex] = updatedDay;

    final updatedWeek = currentWeek.copyWith(days: updatedDays);
    await ref.read(studyPlanRepositoryProvider).updateWeek(updatedWeek);
  }

  Future<void> _removeAction(int actionIndex) async {
    final weeks = ref.read(planWeeksProvider(widget.week.planId)).value ?? [];
    final currentWeek = weeks.firstWhere((w) => w.id == widget.week.id, orElse: () => widget.week);
    final day = currentWeek.days[widget.dayIndex];

    final updatedActions = List<DailyActionItem>.from(day.actions)..removeAt(actionIndex);
    final updatedDay = day.copyWith(actions: updatedActions);

    final updatedDays = List<StudyDay>.from(currentWeek.days);
    updatedDays[widget.dayIndex] = updatedDay;

    final updatedWeek = currentWeek.copyWith(days: updatedDays);
    await ref.read(studyPlanRepositoryProvider).updateWeek(updatedWeek);
  }

  Future<void> _reorderAction(int oldIndex, int newIndex) async {
    final weeks = ref.read(planWeeksProvider(widget.week.planId)).value ?? [];
    final currentWeek = weeks.firstWhere((w) => w.id == widget.week.id, orElse: () => widget.week);
    final day = currentWeek.days[widget.dayIndex];

    final updatedActions = List<DailyActionItem>.from(day.actions);
    if (newIndex > oldIndex) newIndex -= 1;
    final item = updatedActions.removeAt(oldIndex);
    updatedActions.insert(newIndex, item);

    final updatedDay = day.copyWith(actions: updatedActions);
    final updatedDays = List<StudyDay>.from(currentWeek.days);
    updatedDays[widget.dayIndex] = updatedDay;

    final updatedWeek = currentWeek.copyWith(days: updatedDays);
    await ref.read(studyPlanRepositoryProvider).updateWeek(updatedWeek);
  }

  void _handleAddLessonAction() {
    if (_selectedLesson == null) return;
    final lesson = _selectedLesson!;

    DailyActionItem action;
    if (_lessonSliceMode == 'full') {
      action = DailyActionItem(
        id: const Uuid().v4(),
        type: ActionItemType.lessonFull,
        title: 'Học trọn bài: ${lesson.title}',
        goal: 'Nắm toàn bộ hội thoại, từ vựng và ngữ pháp của ${lesson.chapter}',
        estimatedMinutes: 45,
        targetRefId: lesson.id,
        steps: const [
          ActionStep(stepNumber: 1, instruction: 'Đọc hiểu kịch bản hội thoại và đối chiếu bản dịch'),
          ActionStep(stepNumber: 2, instruction: 'Nghe audio chuẩn Kirjakieli và văn nói Puhekieli'),
          ActionStep(stepNumber: 3, instruction: 'Ghi chép và luyện tập từ vựng & ngữ pháp trọng tâm'),
        ],
      );
    } else if (_lessonSliceMode == 'vocab') {
      action = DailyActionItem(
        id: const Uuid().v4(),
        type: ActionItemType.vocabularySet,
        title: 'Luyện từ vựng: ${lesson.chapter} (${lesson.vocabIds.length} từ)',
        goal: 'Thuộc và phát âm chuẩn các từ vựng mới của ${lesson.chapter}',
        estimatedMinutes: 20,
        targetRefId: lesson.id,
        specificItemIds: lesson.vocabIds,
        steps: const [
          ActionStep(stepNumber: 1, instruction: 'Đọc và nghe phát âm từng từ vựng trong bài'),
          ActionStep(stepNumber: 2, instruction: 'Luyện phản xạ nghĩa Việt - Phần'),
          ActionStep(stepNumber: 3, instruction: 'Tự đặt 3 câu ví dụ với các từ mới học'),
        ],
      );
    } else if (_lessonSliceMode == 'grammar') {
      final grammarTitle = _selectedGrammar?.title ?? 'Ngữ pháp ${lesson.chapter}';
      action = DailyActionItem(
        id: const Uuid().v4(),
        type: ActionItemType.grammarPoint,
        title: 'Ngữ pháp: $grammarTitle',
        goal: 'Hiểu bản chất và vận dụng chính xác quy tắc ngữ pháp',
        estimatedMinutes: 25,
        targetRefId: _selectedGrammar?.id ?? lesson.id,
        steps: const [
          ActionStep(stepNumber: 1, instruction: 'Đọc phân tích cấu trúc và quy tắc biến đổi'),
          ActionStep(stepNumber: 2, instruction: 'Quan sát các câu ví dụ mẫu'),
          ActionStep(stepNumber: 3, instruction: 'Làm bài tập vận dụng ngữ pháp'),
        ],
      );
    } else {
      action = DailyActionItem(
        id: const Uuid().v4(),
        type: ActionItemType.exerciseSet,
        title: 'Bài tập thực hành: ${lesson.chapter}',
        goal: 'Hoàn thành các câu hỏi trắc nghiệm và điền từ của bài',
        estimatedMinutes: 20,
        targetRefId: lesson.id,
        specificItemIds: lesson.exerciseIds,
        steps: const [
          ActionStep(stepNumber: 1, instruction: 'Làm bài tập trắc nghiệm và điền từ'),
          ActionStep(stepNumber: 2, instruction: 'Xem giải thích chi tiết các câu sai'),
        ],
      );
    }

    _addAction(action);
  }

  void _handleAddImmersionAction() {
    if (_selectedImmersion == null) return;
    final res = _selectedImmersion!;

    ActionItemType type;
    List<ActionStep> steps;

    switch (res.type) {
      case ImmersionType.music:
        type = ActionItemType.immersionMusic;
        steps = const [
          ActionStep(stepNumber: 1, instruction: 'Nghe lần 1 không nhìn lời (cảm nhận giai điệu & ngữ điệu tự nhiên)'),
          ActionStep(stepNumber: 2, instruction: 'Dò lời bài hát tiếng Phần và đối chiếu bản dịch tiếng Việt'),
          ActionStep(stepNumber: 3, instruction: 'Hát đuổi / Shadowing theo ca sĩ để rèn luyện cơ miệng và phát âm'),
          ActionStep(stepNumber: 4, instruction: 'Ghi nhớ các từ vựng và cấu trúc nổi bật trong bài'),
        ];
        break;
      case ImmersionType.movie:
        type = ActionItemType.immersionMovie;
        steps = const [
          ActionStep(stepNumber: 1, instruction: 'Xem trích đoạn video có phụ đề tiếng Phần'),
          ActionStep(stepNumber: 2, instruction: 'Đọc lời thoại và chú giải ngữ cảnh văn hóa'),
          ActionStep(stepNumber: 3, instruction: 'Nhại lại lời thoại của nhân vật'),
        ];
        break;
      case ImmersionType.streetSign:
      case ImmersionType.practicalLife:
        type = ActionItemType.immersionSign;
        steps = const [
          ActionStep(stepNumber: 1, instruction: 'Quan sát hình ảnh biển báo / tài liệu thực tế'),
          ActionStep(stepNumber: 2, instruction: 'Đọc chữ và suy đoán ý nghĩa từ ngữ cảnh'),
          ActionStep(stepNumber: 3, instruction: 'Đối chiếu bản dịch chi tiết và ghi nhớ từ vựng thực tế'),
        ];
        break;
    }

    final action = DailyActionItem(
      id: const Uuid().v4(),
      type: type,
      title: '${res.type == ImmersionType.music ? "🎵 Nghe nhạc" : "🚏 Đời sống"}: ${res.title}',
      goal: res.description.isNotEmpty ? res.description : 'Ứng dụng tiếng Phần Lan vào đời sống thực tế',
      estimatedMinutes: 20,
      targetRefId: res.id,
      externalLink: res.mediaUrl,
      steps: steps,
    );

    _addAction(action);
  }

  void _handleAddCustomAction() {
    final title = _customTitleController.text.trim();
    if (title.isEmpty) return;

    final minutes = int.tryParse(_customTimeController.text.trim()) ?? 15;
    final action = DailyActionItem(
      id: const Uuid().v4(),
      type: ActionItemType.custom,
      title: title,
      goal: _customGoalController.text.trim(),
      estimatedMinutes: minutes,
      steps: [
        ActionStep(stepNumber: 1, instruction: 'Thực hiện nhiệm vụ: $title'),
      ],
    );

    _addAction(action);
    _customTitleController.clear();
    _customGoalController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final weeksAsync = ref.watch(planWeeksProvider(widget.week.planId));

    return weeksAsync.when(
      data: (weeks) {
        final currentWeek = weeks.firstWhere((w) => w.id == widget.week.id, orElse: () => widget.week);
        final day = currentWeek.days[widget.dayIndex];
        final actions = day.actions;

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.blueAccent),
              const SizedBox(width: 8),
              Text('Nhiệm vụ: ${day.dayName} (${currentWeek.title})'),
            ],
          ),
          content: SizedBox(
            width: 780,
            height: 680,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '📋 Danh sách nhiệm vụ trong ngày (kéo thả hoặc nhấn nút để điều chỉnh):',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Expanded(
                  flex: 3,
                  child: actions.isEmpty
                      ? Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Text(
                            'Chưa có nhiệm vụ nào trong ngày này. Hãy chọn thêm bên dưới!',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        )
                      : ReorderableListView.builder(
                          itemCount: actions.length,
                          onReorder: _reorderAction,
                          itemBuilder: (context, index) {
                            final act = actions[index];
                            return Card(
                              key: ValueKey(act.id),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              elevation: 1,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.blueAccent.shade100,
                                  child: Text('${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                ),
                                title: Text(act.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                subtitle: Text(
                                  'Mục tiêu: ${act.goal.isNotEmpty ? act.goal : "Nắm chắc kiến thức"} • ${act.estimatedMinutes} phút • ${act.steps.length} bước phương pháp',
                                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                  onPressed: () => _removeAction(index),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                const Divider(height: 24),
                const Text(
                  '➕ Thêm nhiệm vụ học tập mới:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                TabBar(
                  controller: _tabController,
                  labelColor: Colors.blueAccent.shade700,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.blueAccent.shade700,
                  tabs: const [
                    Tab(icon: Icon(Icons.school), text: 'Từ Bài Học (Lesson)'),
                    Tab(icon: Icon(Icons.music_video), text: 'Kho Đời Sống (Immersion)'),
                    Tab(icon: Icon(Icons.edit_note), text: 'Tự Do (Custom Task)'),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  flex: 4,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // TAB 1: Từ bài học
                      _buildLessonSliceTab(),
                      // TAB 2: Kho thực tế Immersion
                      _buildImmersionTab(),
                      // TAB 3: Tự do Custom Task
                      _buildCustomTaskTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent.shade700, foregroundColor: Colors.white),
              child: const Text('HOÀN TẤT & ĐÓNG'),
            ),
          ],
        );
      },
      loading: () => const AlertDialog(content: SizedBox(height: 100, child: Center(child: CircularProgressIndicator()))),
      error: (e, s) => AlertDialog(content: Text('Lỗi: $e')),
    );
  }

  Widget _buildLessonSliceTab() {
    final lessonsAsync = ref.watch(lessonsStreamProvider);

    return lessonsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Lỗi tải bài học: $e')),
      data: (lessons) {
        if (lessons.isEmpty) {
          return const Center(child: Text('Chưa có bài học nào trong hệ thống.'));
        }

        if (_selectedLesson == null || !lessons.any((l) => l.id == _selectedLesson!.id)) {
          _selectedLesson = lessons.first;
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<Lesson>(
                initialValue: _selectedLesson,
                decoration: const InputDecoration(
                  labelText: 'Chọn Bài Học',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.menu_book),
                ),
                items: lessons.map((l) {
                  return DropdownMenuItem(value: l, child: Text(l.title, overflow: TextOverflow.ellipsis));
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedLesson = val);
                },
              ),
              const SizedBox(height: 12),
              const Text('Cách phân rã vào ngày học:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 6),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'full', label: Text('Trọn bài'), icon: Icon(Icons.all_inclusive, size: 16)),
                  ButtonSegment(value: 'vocab', label: Text('Từ vựng lẻ'), icon: Icon(Icons.spellcheck, size: 16)),
                  ButtonSegment(value: 'grammar', label: Text('Ngữ pháp lẻ'), icon: Icon(Icons.auto_stories, size: 16)),
                  ButtonSegment(value: 'exercise', label: Text('Bài tập lẻ'), icon: Icon(Icons.assignment, size: 16)),
                ],
                selected: {_lessonSliceMode},
                onSelectionChanged: (val) => setState(() => _lessonSliceMode = val.first),
              ),
              const SizedBox(height: 12),
              if (_lessonSliceMode == 'grammar') ...[
                ref.watch(grammarsStreamProvider).when(
                      data: (grammars) {
                        final available = grammars.where((g) => _selectedLesson?.grammarIds.contains(g.id) ?? true).toList();
                        final list = available.isNotEmpty ? available : grammars;
                        if (list.isNotEmpty && (_selectedGrammar == null || !list.any((g) => g.id == _selectedGrammar!.id))) {
                          _selectedGrammar = list.first;
                        }
                        return DropdownButtonFormField<Grammar>(
                          initialValue: _selectedGrammar,
                          decoration: const InputDecoration(labelText: 'Chọn điểm ngữ pháp cụ thể', border: OutlineInputBorder()),
                          items: list.map((g) => DropdownMenuItem(value: g, child: Text(g.title))).toList(),
                          onChanged: (val) => setState(() => _selectedGrammar = val),
                        );
                      },
                      loading: () => const LinearProgressIndicator(),
                      error: (_, __) => const SizedBox(),
                    ),
                const SizedBox(height: 12),
              ],
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: _handleAddLessonAction,
                  icon: const Icon(Icons.add),
                  label: const Text('THÊM VÀO NGÀY NÀY'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent.shade700, foregroundColor: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImmersionTab() {
    final immersionAsync = ref.watch(immersionListProvider(null));

    return immersionAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Lỗi: $e')),
      data: (items) {
        if (items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Chưa có tài nguyên nào trong Immersion Hub.'),
                const SizedBox(height: 8),
                Text('Hãy vào mục Immersion Hub trên Sidebar để thêm bài hát / biển báo!', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              ],
            ),
          );
        }

        if (_selectedImmersion == null || !items.any((i) => i.id == _selectedImmersion!.id)) {
          _selectedImmersion = items.first;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<ImmersionResource>(
              initialValue: _selectedImmersion,
              decoration: const InputDecoration(
                labelText: 'Chọn tài nguyên thực tế (Bài hát, Video, Biển báo...)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.music_video),
              ),
              items: items.map((i) {
                return DropdownMenuItem(value: i, child: Text('[${i.type.name}] ${i.title}', overflow: TextOverflow.ellipsis));
              }).toList(),
              onChanged: (val) => setState(() => _selectedImmersion = val),
            ),
            const SizedBox(height: 12),
            if (_selectedImmersion != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.purple.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quy trình phương pháp tự động nạp:',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple.shade900, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    const Text('✓ Bước 1: Thẩm âm / Quan sát trực giác', style: TextStyle(fontSize: 12)),
                    const Text('✓ Bước 2: Dò lời song ngữ Phần - Việt', style: TextStyle(fontSize: 12)),
                    const Text('✓ Bước 3: Shadowing luyện cơ miệng', style: TextStyle(fontSize: 12)),
                    const Text('✓ Bước 4: Đọc hiểu & thu hoạch từ mới', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ],
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: _handleAddImmersionAction,
                icon: const Icon(Icons.add),
                label: const Text('THÊM VÀO NGÀY NÀY'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade700, foregroundColor: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCustomTaskTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            controller: _customTitleController,
            decoration: const InputDecoration(
              labelText: 'Tiêu đề nhiệm vụ *',
              hintText: 'VD: Luyện phản xạ chào hỏi 5 phút mỗi sáng',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _customGoalController,
            decoration: const InputDecoration(
              labelText: 'Mục tiêu đạt được',
              hintText: 'VD: Nói trôi chảy không ngập ngừng',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _customTimeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Thời gian dự kiến (phút)',
              hintText: '15',
              border: OutlineInputBorder(),
              suffixText: 'phút',
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: _handleAddCustomAction,
              icon: const Icon(Icons.add),
              label: const Text('THÊM NHIỆM VỤ'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey.shade700, foregroundColor: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
