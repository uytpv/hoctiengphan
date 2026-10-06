import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/study_plan_repository.dart';
import '../domain/models/study_plan.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/common/widgets/bilingual_label.dart';
import '../../../core/localization/language_provider.dart';
import 'widgets/action_detail_sheet.dart';

/// Shows weeks → days → activities for a single study plan.
class StudyPlanDetailScreen extends ConsumerStatefulWidget {
  const StudyPlanDetailScreen({
    super.key,
    required this.planId,
    this.initialWeekId,
    this.initialDayId,
  });

  final String planId;
  final String? initialWeekId;
  final String? initialDayId;

  @override
  ConsumerState<StudyPlanDetailScreen> createState() =>
      _StudyPlanDetailScreenState();
}

class _StudyPlanDetailScreenState
    extends ConsumerState<StudyPlanDetailScreen> {
  String? _selectedWeekId;
  String? _selectedDayId;
  Map<String, String> _progress = {};
  StudyPlanWeek? _resolvedWeek;
  bool _loadingWeek = false;
  bool _initialSelectionDone = false;

  @override
  void initState() {
    super.initState();
    _selectedWeekId = widget.initialWeekId;
    _selectedDayId = widget.initialDayId;
    _loadProgress();
  }

  @override
  void didUpdateWidget(covariant StudyPlanDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialWeekId != widget.initialWeekId ||
        oldWidget.initialDayId != widget.initialDayId) {
      _selectedWeekId = widget.initialWeekId;
      _selectedDayId = widget.initialDayId;
      _initialSelectionDone = false;
    }
  }

  Future<void> _loadProgress() async {
    final repo = ref.read(studyPlanRepositoryProvider);
    final p = await repo.getUserProgress(widget.planId);
    if (mounted) setState(() => _progress = p);
  }

  Future<void> _selectWeek(StudyPlanWeek raw, {String? dayId}) async {
    setState(() {
      _selectedWeekId = raw.id;
      _selectedDayId = dayId;
      _resolvedWeek = raw; // show immediately with empty activities
      _loadingWeek = true;
    });
    final repo = ref.read(studyPlanRepositoryProvider);
    final resolved = await repo.resolveWeekActivities(raw);
    if (mounted) {
      setState(() {
        _resolvedWeek = resolved;
        _loadingWeek = false;
        if (dayId != null) {
          _selectedDayId = dayId;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final weeksAsync = ref.watch(weekListProvider(widget.planId));
    final lang = ref.watch(languageProvider);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return weeksAsync.when(
      loading: () => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          elevation: 0,
          leading: BackButton(onPressed: () => context.go('/')),
          title: const Text('Lộ trình', style: TextStyle(color: AppColors.surfaceDark)),
        ),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          elevation: 0,
          leading: BackButton(onPressed: () => context.go('/')),
          title: const Text('Lộ trình', style: TextStyle(color: AppColors.surfaceDark)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Lỗi tải dữ liệu / Data Load Error'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.invalidate(weekListProvider(widget.planId)),
                child: const Text('Thử lại / Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (weeks) {
        if (!_initialSelectionDone && weeks.isNotEmpty) {
          _initialSelectionDone = true;
          if (_selectedWeekId != null && _selectedWeekId!.isNotEmpty) {
            final targetWeek = weeks.firstWhere(
              (w) => w.id == _selectedWeekId,
              orElse: () => weeks.first,
            );
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                _selectWeek(targetWeek, dayId: _selectedDayId);
              }
            });
          }
        }

        return PopScope(
          canPop: !isMobile || (_selectedDayId == null && _selectedWeekId == null),
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            if (isMobile) {
              if (_selectedDayId != null) {
                setState(() => _selectedDayId = null);
              } else if (_selectedWeekId != null) {
                setState(() {
                  _selectedWeekId = null;
                  _resolvedWeek = null;
                });
              }
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.surface,
              elevation: 0,
              leading: BackButton(
                onPressed: () {
                  if (isMobile) {
                    if (_selectedDayId != null) {
                      setState(() => _selectedDayId = null);
                      return;
                    } else if (_selectedWeekId != null) {
                      setState(() {
                        _selectedWeekId = null;
                        _resolvedWeek = null;
                      });
                      return;
                    }
                  }
                  context.go('/');
                },
              ),
              title: Text(
                isMobile
                    ? (_selectedDayId != null
                        ? (_resolvedWeek?.days
                                .firstWhere((d) => d.id == _selectedDayId,
                                    orElse: () => _resolvedWeek!.days.first)
                                .name ??
                            'Bài học')
                        : (_selectedWeekId != null
                            ? (_resolvedWeek?.title ?? 'Chọn ngày')
                            : 'Lộ trình'))
                    : 'Lộ trình',
                style: AppTextStyles.headingSm.copyWith(color: AppColors.surfaceDark),
              ),
            ),
            body: isMobile
                ? _buildMobileBody(weeks, lang)
                : _buildDesktopBody(weeks, lang),
          ),
        );
      },
    );
  }

  Widget _buildMobileBody(List<StudyPlanWeek> weeks, String lang) {
    if (_selectedWeekId == null) {
      return _WeekSidebar(
        weeks: weeks,
        selectedId: _selectedWeekId,
        onSelect: (week) => _selectWeek(week),
        isMobile: true,
      );
    } else if (_resolvedWeek == null || _loadingWeek) {
      return const Center(child: CircularProgressIndicator());
    } else if (_selectedDayId == null) {
      return _DayList(
        week: _resolvedWeek!,
        selectedDayId: _selectedDayId,
        lang: lang,
        isLoading: _loadingWeek,
        onSelect: (id) => setState(() => _selectedDayId = id),
        isMobile: true,
      );
    } else {
      return _ActivityPanel(
        week: _resolvedWeek!,
        dayId: _selectedDayId!,
        lang: lang,
        progress: _progress,
        planId: widget.planId,
        onActivityDone: _loadProgress,
      );
    }
  }

  Widget _buildDesktopBody(List<StudyPlanWeek> weeks, String lang) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: week list
        _WeekSidebar(
          weeks: weeks,
          selectedId: _selectedWeekId,
          onSelect: (week) => _selectWeek(week),
          isMobile: false,
        ),
        const VerticalDivider(width: 1),
        // Middle: day list
        if (_resolvedWeek != null)
          _DayList(
            week: _resolvedWeek!,
            selectedDayId: _selectedDayId,
            lang: lang,
            isLoading: _loadingWeek,
            onSelect: (id) => setState(() => _selectedDayId = id),
            isMobile: false,
          ),
        const VerticalDivider(width: 1),
        // Right: activity list
        if (_resolvedWeek != null && _selectedDayId != null)
          Expanded(
            child: _ActivityPanel(
              week: _resolvedWeek!,
              dayId: _selectedDayId!,
              lang: lang,
              progress: _progress,
              planId: widget.planId,
              onActivityDone: _loadProgress,
            ),
          )
        else
          const Expanded(child: _HintPanel()),
      ],
    );
  }
}

class _WeekSidebar extends StatelessWidget {
  const _WeekSidebar({
    required this.weeks,
    required this.selectedId,
    required this.onSelect,
    required this.isMobile,
  });
  final List<StudyPlanWeek> weeks;
  final String? selectedId;
  final ValueChanged<StudyPlanWeek> onSelect;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: weeks.length,
        itemBuilder: (context, i) {
          final w = weeks[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.border, width: 1),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.calendar_view_week_outlined,
                  color: AppColors.primary,
                ),
              ),
              title: Text(
                w.title,
                style: AppTextStyles.bodyMd.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.surfaceDark,
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: AppColors.neutral,
              ),
              onTap: () => onSelect(w),
            ),
          );
        },
      );
    }

    return SizedBox(
      width: 120,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: weeks.length,
        itemBuilder: (context, i) {
          final w = weeks[i];
          final selected = w.id == selectedId;
          return InkWell(
            onTap: () => onSelect(w),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                border: selected
                    ? const Border(
                        right: BorderSide(
                            color: AppColors.primary, width: 3))
                    : null,
              ),
              child: Text(
                w.title,
                style: AppTextStyles.labelMd.copyWith(
                  color: selected
                      ? AppColors.primary
                      : AppColors.neutral,
                  fontWeight: selected
                      ? FontWeight.w700
                      : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DayList extends StatelessWidget {
  const _DayList({
    required this.week,
    required this.selectedDayId,
    required this.lang,
    required this.isLoading,
    required this.onSelect,
    required this.isMobile,
  });
  final StudyPlanWeek week;
  final String? selectedDayId;
  final String lang;
  final bool isLoading;
  final ValueChanged<String> onSelect;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              week.title,
              style: AppTextStyles.headingSm,
            ),
          ),
          const Divider(height: 1),
          if (isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: week.days.length,
                itemBuilder: (context, i) {
                  final day = week.days[i];
                  final hasActivities = day.actions.isNotEmpty || day.activityIds.isNotEmpty;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: AppColors.border, width: 1),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.today_outlined,
                          color: Colors.blue,
                        ),
                      ),
                      title: Text(
                        day.name,
                        style: AppTextStyles.bodyMd.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.surfaceDark,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (hasActivities)
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          const Icon(
                            Icons.chevron_right,
                            color: AppColors.neutral,
                          ),
                        ],
                      ),
                      onTap: () => onSelect(day.id),
                    ),
                  );
                },
              ),
            ),
        ],
      );
    }

    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              week.title,
              style: AppTextStyles.headingSm,
            ),
          ),
          const Divider(height: 1),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                  child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2))),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: week.days.length,
                itemBuilder: (context, i) {
                  final day = week.days[i];
                  final selected = day.id == selectedDayId;
                  final hasActivities =
                      day.actions.isNotEmpty || day.activityIds.isNotEmpty;
                  return InkWell(
                    onTap: () => onSelect(day.id),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      color: selected
                          ? AppColors.primary
                              .withValues(alpha: 0.1)
                          : null,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              day.name,
                              style:
                                  AppTextStyles.bodyMd.copyWith(
                                fontWeight: selected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.surfaceDark,
                              ),
                            ),
                          ),
                          if (hasActivities)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: AppColors.primary
                                    .withValues(alpha: 0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _ActivityPanel extends ConsumerWidget {
  const _ActivityPanel({
    required this.week,
    required this.dayId,
    required this.lang,
    required this.progress,
    required this.planId,
    required this.onActivityDone,
  });
  final StudyPlanWeek week;
  final String dayId;
  final String lang;
  final Map<String, String> progress;
  final String planId;
  final VoidCallback onActivityDone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final day = week.days.firstWhere((d) => d.id == dayId,
        orElse: () => week.days.first);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: BilingualLabel(
            primary: day.name,
            secondary: week.title,
            primaryStyle: AppTextStyles.headingSm,
          ),
        ),
        const Divider(height: 1),
        if (day.actions.isNotEmpty)
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: day.actions.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final action = day.actions[i];
                final isDone = progress[action.id] == 'done';
                return _DailyActionTile(
                  action: action,
                  isDone: isDone,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (ctx) => ActionDetailSheet(
                        action: action,
                        planId: planId,
                        weekId: week.id,
                        dayId: dayId,
                        isInitiallyDone: isDone,
                        onStatusChanged: onActivityDone,
                      ),
                    );
                  },
                );
              },
            ),
          )
        else if (day.activities.isEmpty && day.activityIds.isEmpty)
          const Expanded(child: _EmptyDayPanel())
        else if (day.activities.isEmpty &&
            day.activityIds.isNotEmpty)
          const Expanded(
              child: Center(child: CircularProgressIndicator()))
        else
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: day.activities.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final activity = day.activities[i];
                final isDone = progress[activity.id] == 'done';
                return _ActivityTile(
                  activity: activity,
                  lang: lang,
                  isDone: isDone,
                  onTap: () {
                    if (activity.type == ActivityType.lesson) {
                      context.go(
                          '/lesson/${activity.referenceId}?planId=$planId&weekId=${week.id}&dayId=$dayId&activityId=${activity.id}');
                    } else if (activity.type ==
                        ActivityType.exercise) {
                      context.go(
                          '/exercise/${activity.referenceId}?planId=$planId&weekId=${week.id}&dayId=$dayId&activityId=${activity.id}');
                    }
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}

class _DailyActionTile extends StatelessWidget {
  final DailyActionItem action;
  final bool isDone;
  final VoidCallback onTap;

  const _DailyActionTile({
    required this.action,
    required this.isDone,
    required this.onTap,
  });

  IconData _getTypeIcon(ActionItemType type) {
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

  Color _getTypeColor(ActionItemType type) {
    switch (type) {
      case ActionItemType.lessonFull:
      case ActionItemType.lessonSlice:
        return AppColors.primary;
      case ActionItemType.vocabularySet:
        return const Color(0xFFFF6B35);
      case ActionItemType.grammarPoint:
        return const Color(0xFF32AE88);
      case ActionItemType.exerciseSet:
        return const Color(0xFF6C63FF);
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

  String _getTypeLabel(ActionItemType type) {
    switch (type) {
      case ActionItemType.lessonFull:
        return 'Bài học giáo trình';
      case ActionItemType.lessonSlice:
        return 'Phần bài học';
      case ActionItemType.vocabularySet:
        return 'Luyện từ vựng';
      case ActionItemType.grammarPoint:
        return 'Ngữ pháp';
      case ActionItemType.exerciseSet:
        return 'Bài tập';
      case ActionItemType.immersionMusic:
        return 'Âm nhạc đời sống';
      case ActionItemType.immersionMovie:
        return 'Video đời sống';
      case ActionItemType.immersionSign:
        return 'Biển báo thực tế';
      case ActionItemType.custom:
        return 'Nhiệm vụ tự do';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getTypeColor(action.type);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDone
                ? AppColors.done.withValues(alpha: 0.07)
                : AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDone
                  ? AppColors.done.withValues(alpha: 0.3)
                  : AppColors.border,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(_getTypeIcon(action.type), size: 20, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      action.title,
                      style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: isDone ? FontWeight.normal : FontWeight.w600,
                        color: isDone ? AppColors.neutral : AppColors.surfaceDark,
                        decoration: isDone ? TextDecoration.lineThrough : null,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Text(
                          _getTypeLabel(action.type),
                          style: AppTextStyles.caption.copyWith(color: color, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' • ${action.estimatedMinutes} phút',
                          style: AppTextStyles.caption.copyWith(color: AppColors.neutral),
                        ),
                        if (action.steps.isNotEmpty)
                          Text(
                            ' • ${action.steps.length} bước',
                            style: AppTextStyles.caption.copyWith(color: AppColors.neutral),
                          ),
                      ],
                    ),
                    if (action.goal.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        'Mục tiêu: ${action.goal}',
                        style: AppTextStyles.caption.copyWith(color: AppColors.neutral),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (isDone)
                const Icon(Icons.check_circle, color: AppColors.done, size: 22)
              else
                const Icon(Icons.chevron_right, color: AppColors.neutral, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({
    required this.activity,
    required this.lang,
    required this.isDone,
    required this.onTap,
  });
  final Activity activity;
  final String lang;
  final bool isDone;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isInteractive = activity.type == ActivityType.lesson ||
        activity.type == ActivityType.exercise;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isInteractive ? onTap : null,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isDone
                ? AppColors.done.withValues(alpha: 0.07)
                : AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDone
                  ? AppColors.done.withValues(alpha: 0.3)
                  : AppColors.border,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: _typeColor(activity.type)
                      .withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _typeIcon(activity.type),
                  size: 18,
                  color: _typeColor(activity.type),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.title,
                      style: AppTextStyles.bodyMd.copyWith(
                        fontWeight: isDone
                            ? FontWeight.normal
                            : FontWeight.w500,
                        color: isDone
                            ? AppColors.neutral
                            : AppColors.surfaceDark,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _typeLabel(activity.type, lang),
                      style: AppTextStyles.caption,
                    ),
                    if (activity.description.isNotEmpty)
                      Text(
                        activity.description,
                        style: AppTextStyles.caption.copyWith(
                            color: AppColors.neutral),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              if (isDone)
                const Icon(Icons.check_circle,
                    color: AppColors.done, size: 20)
              else if (isInteractive)
                const Icon(Icons.chevron_right,
                    color: AppColors.neutral, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Color _typeColor(ActivityType t) {
    return switch (t) {
      ActivityType.lesson => AppColors.primary,
      ActivityType.exercise => const Color(0xFF6C63FF),
      ActivityType.grammar => const Color(0xFF32AE88),
      ActivityType.vocabulary => const Color(0xFFFF6B35),
    };
  }

  IconData _typeIcon(ActivityType t) {
    return switch (t) {
      ActivityType.lesson => Icons.menu_book_outlined,
      ActivityType.exercise => Icons.edit_outlined,
      ActivityType.grammar => Icons.account_tree_outlined,
      ActivityType.vocabulary => Icons.translate_outlined,
    };
  }

  String _typeLabel(ActivityType t, String lang) {
    if (lang == 'vi') {
      return switch (t) {
        ActivityType.lesson => 'Bài học',
        ActivityType.exercise => 'Bài tập',
        ActivityType.grammar => 'Ngữ pháp',
        ActivityType.vocabulary => 'Từ vựng',
      };
    }
    return switch (t) {
      ActivityType.lesson => 'Lesson',
      ActivityType.exercise => 'Exercise',
      ActivityType.grammar => 'Grammar',
      ActivityType.vocabulary => 'Vocabulary',
    };
  }
}

class _EmptyDayPanel extends StatelessWidget {
  const _EmptyDayPanel();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wb_sunny_outlined,
              size: 48, color: AppColors.borderLight),
          const SizedBox(height: 12),
          Text('Ngày nghỉ',
              style: AppTextStyles.bodyMd
                  .copyWith(color: AppColors.neutral)),
          const SizedBox(height: 4),
          Text('Không có hoạt động hôm nay',
              style: AppTextStyles.caption),
        ],
      ),
    );
  }
}

class _HintPanel extends StatelessWidget {
  const _HintPanel();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.touch_app_outlined,
              size: 56, color: AppColors.borderLight),
          const SizedBox(height: 12),
          Text('Chọn tuần và ngày',
              style: AppTextStyles.bodyMd
                  .copyWith(color: AppColors.neutral)),
        ],
      ),
    );
  }
}
