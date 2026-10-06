import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/models/study_plan.dart';
import '../../data/study_plan_repository.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ActionDetailSheet extends ConsumerStatefulWidget {
  final DailyActionItem action;
  final String planId;
  final String weekId;
  final String dayId;
  final bool isInitiallyDone;
  final VoidCallback onStatusChanged;

  const ActionDetailSheet({
    super.key,
    required this.action,
    required this.planId,
    required this.weekId,
    required this.dayId,
    required this.isInitiallyDone,
    required this.onStatusChanged,
  });

  @override
  ConsumerState<ActionDetailSheet> createState() => _ActionDetailSheetState();
}

class _ActionDetailSheetState extends ConsumerState<ActionDetailSheet> {
  late List<bool> _stepStatus;
  late bool _isDone;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _isDone = widget.isInitiallyDone;
    _stepStatus = List.generate(
      widget.action.steps.length,
      (index) => widget.action.steps[index].isDone || _isDone,
    );
  }

  Future<void> _toggleDone() async {
    setState(() => _isSaving = true);
    try {
      final repo = ref.read(studyPlanRepositoryProvider);
      await repo.markActivityDone(
        planId: widget.planId,
        weekId: widget.weekId,
        dayId: widget.dayId,
        activityId: widget.action.id,
      );
      setState(() {
        _isDone = true;
        _stepStatus = List.filled(_stepStatus.length, true);
      });
      widget.onStatusChanged();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🎉 Tuyệt vời! Bạn đã hoàn thành nhiệm vụ này!'),
            backgroundColor: AppColors.done,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _openExternalLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

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

  String _getActionOpenButtonLabel(ActionItemType type) {
    switch (type) {
      case ActionItemType.vocabularySet:
        return 'Vào Luyện Từ Vựng Ngay (Flashcards & Âm thanh)';
      case ActionItemType.grammarPoint:
        return 'Vào Học Ngữ Pháp Chuyên Sâu (Lý thuyết & Bài tập)';
      case ActionItemType.exerciseSet:
        return 'Vào Làm Bài Tập Tương Tác Ngay';
      case ActionItemType.lessonFull:
      case ActionItemType.lessonSlice:
        return 'Mở Bài Học & Hội Thoại Chuẩn';
      case ActionItemType.immersionMusic:
        return 'Mở Bài Hát & Học Lời Nhạc';
      case ActionItemType.immersionMovie:
        return 'Mở Video Học Thực Tế';
      case ActionItemType.immersionSign:
        return 'Xem Biển Báo & Từ Vựng Thực Tế';
      case ActionItemType.custom:
        return 'Mở Bài Học Tương Tác';
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = _getTypeColor(widget.action.type);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: typeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_getTypeIcon(widget.action.type), color: typeColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.action.title,
                      style: AppTextStyles.headingSm.copyWith(color: AppColors.surfaceDark),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Thời gian dự kiến: ${widget.action.estimatedMinutes} phút',
                      style: AppTextStyles.caption.copyWith(color: AppColors.neutral),
                    ),
                  ],
                ),
              ),
              if (_isDone)
                const Icon(Icons.check_circle, color: AppColors.done, size: 28),
            ],
          ),
          if (widget.action.goal.isNotEmpty) ...[
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.flag_outlined, size: 18, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Mục tiêu: ${widget.action.goal}',
                      style: AppTextStyles.bodySm.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (widget.action.targetRefId != null && widget.action.targetRefId!.isNotEmpty) ...[
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  context.go(
                    '/lesson/${widget.action.targetRefId}?planId=${widget.planId}&weekId=${widget.weekId}&dayId=${widget.dayId}&activityId=${widget.action.id}',
                  );
                },
                icon: const Icon(Icons.play_circle_fill),
                label: Text(_getActionOpenButtonLabel(widget.action.type)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: typeColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
          if (widget.action.externalLink != null && widget.action.externalLink!.isNotEmpty) ...[
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _openExternalLink(widget.action.externalLink!),
                icon: const Icon(Icons.open_in_new, size: 18),
                label: const Text('Mở Liên Kết Âm Nhạc / Video Tư Liệu'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
          if (widget.action.steps.isNotEmpty) ...[
            const SizedBox(height: 18),
            Text(
              'Quy trình phương pháp từng bước:',
              style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...widget.action.steps.asMap().entries.map((entry) {
              final idx = entry.key;
              final step = entry.value;
              final isStepDone = _stepStatus[idx];

              return InkWell(
                onTap: () {
                  setState(() {
                    _stepStatus[idx] = !_stepStatus[idx];
                  });
                },
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        isStepDone ? Icons.check_box : Icons.check_box_outline_blank,
                        color: isStepDone ? AppColors.done : Colors.grey,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          step.instruction,
                          style: AppTextStyles.bodySm.copyWith(
                            decoration: isStepDone ? TextDecoration.lineThrough : null,
                            color: isStepDone ? Colors.grey : AppColors.surfaceDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isDone || _isSaving ? null : _toggleDone,
              icon: _isSaving
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : Icon(_isDone ? Icons.check : Icons.task_alt),
              label: Text(_isDone ? 'ĐÃ HOÀN THÀNH' : 'ĐÁNH DẤU HOÀN THÀNH NHIỆM VỤ'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isDone ? Colors.grey.shade400 : AppColors.done,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
