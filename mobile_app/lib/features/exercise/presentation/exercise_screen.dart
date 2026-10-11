import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:animations/animations.dart';
import 'package:confetti/confetti.dart';
import '../domain/models/exercise_type.dart';
import '../domain/models/question.dart';
import 'exercise_notifier.dart';

class ExerciseScreen extends ConsumerStatefulWidget {
  final String exerciseId;
  final String? planId;
  final String? activityId;

  const ExerciseScreen({
    super.key,
    required this.exerciseId,
    this.planId,
    this.activityId,
  });

  @override
  ConsumerState<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends ConsumerState<ExerciseScreen> {
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
    final params = (
      exerciseId: widget.exerciseId,
      planId: widget.planId,
      activityId: widget.activityId,
    );
    final state = ref.watch(exerciseNotifierProvider(params));
    final notifier = ref.read(exerciseNotifierProvider(params).notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(state.exercise?.titleFi ?? 'Harjoitus'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _showExitConfirmation(context),
        ),
        actions: [
          if (state.exercise != null && state.result == null)
            _buildTimer(state.timeElapsed),
        ],
      ),
      body: Stack(
        children: [
          if (state.isLoading)
            const Center(child: CircularProgressIndicator())
          else if (state.error != null)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Virhe: ${state.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => notifier.loadExercise(),
                    child: const Text('Yritä uudelleen'),
                  ),
                ],
              ),
            )
          else if (state.result != null)
            _ExerciseResultView(
              result: state.result!,
              onFinished: () => context.pop(),
              onRetry: () => notifier.reset(),
              confettiController: _confettiController,
            )
          else if (state.exercise != null)
            Column(
              children: [
                LinearProgressIndicator(
                  value: (state.currentIndex + 1) / state.exercise!.questions.length,
                  backgroundColor: Colors.grey[200],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kysymys ${state.currentIndex + 1} / ${state.exercise!.questions.length}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Pisteet: ${state.score}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageTransitionSwitcher(
                    duration: const Duration(milliseconds: 300),
                    reverse: false,
                    transitionBuilder: (child, animation, secondaryAnimation) {
                      return SharedAxisTransition(
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.horizontal,
                        child: child,
                      );
                    },
                    child: KeyedSubtree(
                      key: ValueKey(state.currentIndex),
                      child: _QuestionCard(
                        question: state.exercise!.questions[state.currentIndex],
                        onAnswer: (answer) => notifier.submitCurrentAnswer(answer),
                        currentAnswer: state.answers[state.currentIndex.toString()],

                      ),
                    ),
                  ),
                ),
              ],
            ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimer(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            const Icon(Icons.timer_outlined, size: 18),
            const SizedBox(width: 4),
            Text(
              '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _showExitConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Lopetetaanko harjoitus?'),
        content: const Text('Edistymistäsi ei tallenneta.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Jatka'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.pop();
            },
            child: const Text('Lopeta', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final Question question;
  final Function(dynamic) onAnswer;
  final dynamic currentAnswer;

  const _QuestionCard({
    required this.question,
    required this.onAnswer,
    this.currentAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            question.prompt,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          _buildInputWidget(context),
        ],
      ),
    );
  }

  Widget _buildInputWidget(BuildContext context) {
    switch (question.type) {
      case ExerciseType.multipleChoice:
        return Column(
          children: question.options!.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  side: BorderSide(
                    color: currentAnswer == index ? Colors.blue : Colors.grey[300]!,
                    width: currentAnswer == index ? 2 : 1,
                  ),
                  backgroundColor: currentAnswer == index ? Colors.blue.withValues(alpha: 0.05) : null,
                ),
                onPressed: () => onAnswer(index),
                child: Text(option),
              ),
            );
          }).toList(),
        );
      case ExerciseType.fillInBlank:
        return TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Kirjoita vastaus...',
          ),
          onChanged: (value) => onAnswer(value),
          onSubmitted: (value) => onAnswer(value),
        );
      case ExerciseType.trueFalse:
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green.withValues(alpha: 0.8)),
                onPressed: () => onAnswer(true),
                child: const Text('Oikein'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red.withValues(alpha: 0.8)),
                onPressed: () => onAnswer(false),
                child: const Text('Väärin'),
              ),
            ),
          ],
        );
      default:
        return const Text('Tätä tehtävätyyppiä ei vielä tueta.');
    }
  }
}

class _ExerciseResultView extends StatelessWidget {
  final Map<String, dynamic> result;
  final VoidCallback onFinished;
  final VoidCallback onRetry;
  final ConfettiController confettiController;

  const _ExerciseResultView({
    required this.result,
    required this.onFinished,
    required this.onRetry,
    required this.confettiController,
  });

  @override
  Widget build(BuildContext context) {
    final score = (result['score'] as num?)?.toInt() ?? 0;
    final total = (result['total'] as num?)?.toInt() ?? 0;
    final percentage = (result['percentage'] as num?)?.toDouble() ??
        (total > 0 ? (score / total) * 100 : 0.0);
    final isPassed = result['passed'] == true ||
        result['isPassed'] == true ||
        percentage >= 70;
    final feedback = (result['feedback'] as List<dynamic>?) ?? [];
    final wrongAnswers = feedback
        .where((item) => item is Map && item['isCorrect'] == false)
        .toList();

    if (isPassed) {
      confettiController.play();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isPassed ? Icons.check_circle_outline : Icons.sentiment_dissatisfied,
            size: 90,
            color: isPassed ? Colors.green : Colors.orange,
          ),
          const SizedBox(height: 20),
          Text(
            isPassed
                ? 'Hienoa työtä! • Làm rất tốt!'
                : 'Melkein onnistui! • Cố gắng thêm nhé!',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Sait $score / $total pistettä (${percentage.toStringAsFixed(0)}%)',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: isPassed ? Colors.green[700] : Colors.orange[800],
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            isPassed
                ? 'Onneksi olkoon! Suoritit harjoituksen hyväksytysti.'
                : 'Pistemäärä jäi alle 70%. Kertaa materiaali ja yritä uudelleen!',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),

          // Hiển thị danh sách câu làm sai và giải thích (nếu có)
          if (wrongAnswers.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info_outline,
                          size: 20, color: Colors.orange),
                      const SizedBox(width: 8),
                      Text(
                        'Kertaa nämä kysymykset (${wrongAnswers.length}):',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...wrongAnswers.map((item) {
                    final map = item as Map<String, dynamic>;
                    final prompt = map['prompt'] as String? ?? 'Kysymys';
                    final explanation = map['explanation'] as String?;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('• $prompt',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          if (explanation != null && explanation.isNotEmpty)
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12.0, top: 4.0),
                              child: Text(
                                '💡 $explanation',
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 13),
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],

          // Nút hành động: Làm lại bài hoặc Tiếp tục
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Yritä uudelleen'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    minimumSize: const Size(0, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: onFinished,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Jatka'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
