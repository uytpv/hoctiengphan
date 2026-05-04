import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import 'exercise_result_provider.dart';

class ExerciseCompletionScreen extends ConsumerStatefulWidget {
  final ({String exerciseId, String? planId, String? activityId}) params;
  final VoidCallback onDismiss;

  const ExerciseCompletionScreen({
    super.key,
    required this.params,
    required this.onDismiss,
  });

  @override
  ConsumerState<ExerciseCompletionScreen> createState() => _ExerciseCompletionScreenState();
}

class _ExerciseCompletionScreenState extends ConsumerState<ExerciseCompletionScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final summary = ref.watch(exerciseResultProvider(widget.params));

    if (summary == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (summary.percentage >= 70) {
      _confettiController.play();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildHeader(summary),
                        const SizedBox(height: 32),
                        _buildScoreCard(summary),
                        const SizedBox(height: 32),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Chi tiết bài làm',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final detail = summary.details[index];
                    return _QuestionResultItem(result: detail, index: index);
                  },
                  childCount: summary.details.length,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: widget.onDismiss,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Tiếp tục', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ExerciseSummary summary) {
    final isSuccess = summary.percentage >= 70;
    return Column(
      children: [
        Icon(
          isSuccess ? Icons.emoji_events : Icons.sentiment_satisfied,
          size: 80,
          color: isSuccess ? Colors.orange : Colors.blue,
        ),
        const SizedBox(height: 16),
        Text(
          isSuccess ? 'Tuyệt vời!' : 'Cố gắng lên!',
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          isSuccess 
            ? 'Bạn đã hoàn thành xuất sắc bài tập này.' 
            : 'Bạn đã hoàn thành bài tập. Hãy xem lại các câu sai nhé.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildScoreCard(ExerciseSummary summary) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[700]!, Colors.blue[500]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildScoreItem(
            '${summary.score}/${summary.total}',
            'Câu đúng',
            Colors.white,
          ),
          Container(width: 1, height: 40, color: Colors.white24),
          _buildScoreItem(
            '${summary.percentage.toStringAsFixed(0)}%',
            'Điểm số',
            Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildScoreItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: color.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}

class _QuestionResultItem extends StatelessWidget {
  final QuestionResult result;
  final int index;

  const _QuestionResultItem({required this.result, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: result.isCorrect ? Colors.green[50] : Colors.red[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: result.isCorrect ? Colors.green[100]! : Colors.red[100]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: result.isCorrect ? Colors.green : Colors.red,
                child: Icon(
                  result.isCorrect ? Icons.check : Icons.close,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Câu ${index + 1}: ${result.prompt}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildAnswerRow('Bạn chọn:', result.userAnswer, result.isCorrect ? Colors.green[700]! : Colors.red[700]!),
          if (!result.isCorrect) ...[
            const SizedBox(height: 4),
            _buildAnswerRow('Đáp án đúng:', result.correctAnswer, Colors.green[700]!),
          ],
          if (result.explanation != null && result.explanation!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Giải thích: ${result.explanation}',
                style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAnswerRow(String label, String value, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color),
          ),
        ),
      ],
    );
  }
}
