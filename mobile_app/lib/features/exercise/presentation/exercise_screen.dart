import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/localization/language_provider.dart';
import '../../study_plan/data/study_plan_repository.dart';

class ExerciseScreen extends ConsumerStatefulWidget {
  const ExerciseScreen({
    super.key,
    required this.exerciseId,
    required this.planId,
    required this.weekId,
    required this.dayId,
    required this.activityId,
  });

  final String exerciseId;
  final String planId;
  final String weekId;
  final String dayId;
  final String activityId;

  @override
  ConsumerState<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends ConsumerState<ExerciseScreen> {
  Map<String, dynamic>? _exercise;
  bool _loading = true;
  bool _submitted = false;
  bool _submitting = false;

  // question index → chosen answer index
  final Map<int, int> _answers = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('exercises')
          .doc(widget.exerciseId)
          .get();
      if (mounted) {
        setState(() {
          _exercise = doc.data();
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  int _calcScore(List questions) {
    int correct = 0;
    for (int i = 0; i < questions.length; i++) {
      final q = questions[i] as Map<String, dynamic>;
      final correctIdx = q['correctIndex'] as int? ?? 0;
      if (_answers[i] == correctIdx) correct++;
    }
    return correct;
  }

  Future<void> _submit(List questions) async {
    setState(() => _submitting = true);
    final score = _calcScore(questions);
    final total = questions.length;

    final repo = ref.read(studyPlanRepositoryProvider);
    await repo.markActivityDone(
      planId: widget.planId,
      weekId: widget.weekId,
      dayId: widget.dayId,
      activityId: widget.activityId,
    );

    if (mounted) {
      setState(() {
        _submitted = true;
        _submitting = false;
      });
      _showResult(score, total);
    }
  }

  void _showResult(int score, int total) {
    final lang = ref.read(languageProvider);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          score == total
              ? '🎉 ${lang == "vi" ? "Xuất sắc!" : "Perfect!"}'
              : '📊 ${lang == "vi" ? "Kết quả" : "Result"}',
          style: AppTextStyles.headingSm,
        ),
        content: Text(
          '$score / $total ${lang == "vi" ? "câu đúng" : "correct"}',
          style: AppTextStyles.bodyLg,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/study-plan/${widget.planId}');
            },
            child: Text(lang == 'vi' ? 'Quay lại lộ trình' : 'Back to roadmap'),
          ),
          if (score < total)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _submitted = false;
                  _answers.clear();
                });
              },
              child: Text(lang == 'vi' ? 'Làm lại' : 'Retry'),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(languageProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: BackButton(
          onPressed: () => context.go('/study-plan/${widget.planId}'),
        ),
        title: Row(children: [
          Icon(Icons.edit_outlined,
              color: const Color(0xFF6C63FF), size: 20),
          const SizedBox(width: 8),
          Text(lang == 'vi' ? 'Bài tập' : 'Exercise',
              style: AppTextStyles.headingSm),
        ]),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _exercise == null
              ? Center(
                  child: Text(
                    lang == 'vi'
                        ? 'Không tìm thấy bài tập'
                        : 'Exercise not found',
                    style: AppTextStyles.bodyLg,
                  ),
                )
              : _ExerciseBody(
                  exercise: _exercise!,
                  lang: lang,
                  answers: _answers,
                  submitted: _submitted,
                  submitting: _submitting,
                  onAnswerChanged: (qi, ai) =>
                      setState(() => _answers[qi] = ai),
                  onSubmit: _submit,
                ),
    );
  }
}

class _ExerciseBody extends StatelessWidget {
  const _ExerciseBody({
    required this.exercise,
    required this.lang,
    required this.answers,
    required this.submitted,
    required this.submitting,
    required this.onAnswerChanged,
    required this.onSubmit,
  });

  final Map<String, dynamic> exercise;
  final String lang;
  final Map<int, int> answers;
  final bool submitted;
  final bool submitting;
  final void Function(int qi, int ai) onAnswerChanged;
  final void Function(List) onSubmit;

  @override
  Widget build(BuildContext context) {
    final titleFi = exercise['titleFi'] as String? ?? '';
    final questions =
        (exercise['questions'] as List?) ?? [];

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titleFi,
                      style: AppTextStyles.headingMd),
                  const SizedBox(height: 4),
                  Text(
                    lang == 'vi'
                        ? 'Chọn câu trả lời đúng'
                        : 'Choose the correct answer',
                    style: AppTextStyles.bodyMd
                        .copyWith(color: AppColors.neutral),
                  ),
                  const SizedBox(height: 24),
                  ...List.generate(questions.length, (qi) {
                    final q =
                        questions[qi] as Map<String, dynamic>;
                    return _QuestionCard(
                      index: qi,
                      question: q,
                      selectedAnswer: answers[qi],
                      submitted: submitted,
                      onSelect: (ai) => onAnswerChanged(qi, ai),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(top: BorderSide(color: AppColors.border)),
          ),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (submitted || submitting ||
                      answers.length < questions.length)
                  ? null
                  : () => onSubmit(questions),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: submitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : Text(
                      lang == 'vi' ? 'Nộp bài' : 'Submit',
                      style: AppTextStyles.labelLg
                          .copyWith(color: Colors.white),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.index,
    required this.question,
    required this.selectedAnswer,
    required this.submitted,
    required this.onSelect,
  });

  final int index;
  final Map<String, dynamic> question;
  final int? selectedAnswer;
  final bool submitted;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final prompt = question['prompt'] as String? ?? '';
    final options =
        (question['options'] as List?)?.cast<String>() ?? [];
    final correctIdx = question['correctIndex'] as int? ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${index + 1}. $prompt', style: AppTextStyles.bodyLg),
          const SizedBox(height: 12),
          ...List.generate(options.length, (ai) {
            final isSelected = selectedAnswer == ai;
            final isCorrect = ai == correctIdx;

            Color bgColor = Colors.transparent;
            Color borderColor = AppColors.border;
            Color textColor = AppColors.surfaceDark;

            if (submitted) {
              if (isCorrect) {
                bgColor = AppColors.done.withValues(alpha: 0.1);
                borderColor = AppColors.done;
                textColor = AppColors.done;
              } else if (isSelected && !isCorrect) {
                bgColor = AppColors.error.withValues(alpha: 0.1);
                borderColor = AppColors.error;
                textColor = AppColors.error;
              }
            } else if (isSelected) {
              bgColor = AppColors.primary.withValues(alpha: 0.1);
              borderColor = AppColors.primary;
              textColor = AppColors.primary;
            }

            return GestureDetector(
              onTap: submitted ? null : () => onSelect(ai),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: bgColor,
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      '${String.fromCharCode(65 + ai)}.',
                      style: AppTextStyles.labelMd
                          .copyWith(color: textColor),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(options[ai],
                          style: AppTextStyles.bodyMd
                              .copyWith(color: textColor)),
                    ),
                    if (submitted && isCorrect)
                      const Icon(Icons.check_circle,
                          color: AppColors.done, size: 18),
                    if (submitted && isSelected && !isCorrect)
                      const Icon(Icons.cancel,
                          color: AppColors.error, size: 18),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
