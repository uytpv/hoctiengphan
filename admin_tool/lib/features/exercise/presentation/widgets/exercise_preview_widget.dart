import 'package:flutter/material.dart';

class ExercisePreviewWidget extends StatelessWidget {
  final String title;
  final String description;
  final String type;
  final String content;
  final List<Map<String, dynamic>> questions;

  const ExercisePreviewWidget({
    super.key,
    required this.title,
    required this.description,
    required this.type,
    required this.content,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9F6F0), // Paper-like color
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
        border: Border.all(color: const Color(0xFFE0D8C3), width: 1),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Text(
            title.isEmpty ? 'Untitled Exercise' : title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
            textAlign: TextAlign.center,
          ),
          if (description.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF7F8C8D),
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (content.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(content, style: const TextStyle(fontSize: 15)),
            ),
          ],
          const SizedBox(height: 24),
          const Divider(color: Color(0xFFE0D8C3), thickness: 2),
          const SizedBox(height: 16),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final q = questions[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: _buildQuestion(context, index, q),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion(
    BuildContext context,
    int index,
    Map<String, dynamic> q,
  ) {
    final text = q['text']?.toString() ?? '';
    final imageUrl = q['imageUrl']?.toString();
    final audioUrl = q['audioUrl']?.toString();
    final videoUrl = q['videoUrl']?.toString();

    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE0D8C3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF3498DB),
                  foregroundColor: Colors.white,
                  radius: 14,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: _buildQuestionContent(text, q)),
              ],
            ),

            // Media previews
            if (imageUrl != null && imageUrl.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                    onError: (_, __) {},
                  ),
                ),
                child: imageUrl.startsWith('http')
                    ? null
                    : const Center(
                        child: Icon(Icons.image, color: Colors.grey),
                      ),
              ),
            ],
            if (audioUrl != null && audioUrl.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1C40F).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color(0xFFF1C40F)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.play_circle_fill,
                      color: Color(0xFFF1C40F),
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      '0:00 / 1:20',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
            if (videoUrl != null && videoUrl.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(
                    Icons.play_circle_outline,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionContent(String text, Map<String, dynamic> q) {
    if (type == 'fill-in-blanks') {
      return _buildFillInBlanksText(text);
    } else if (type == 'translation') {
      return Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const Center(
            child: Icon(Icons.arrow_forward_rounded, color: Colors.grey),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 16),
              height: 40,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF3498DB),
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              alignment: Alignment.centerLeft,
              child: const Text('...', style: TextStyle(color: Colors.grey)),
            ),
          ),
        ],
      );
    } else if (type == 'multiple-choice' || type == 'true-false') {
      final options =
          (q['options'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
          [];
      final correctAnswers =
          (q['correctAnswers'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [];
      final isCheckbox = correctAnswers.length > 1;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          ...options.map((opt) {
            final isCorrect =
                correctAnswers.contains(opt) || q['correctAnswer'] == opt;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Icon(
                    isCheckbox
                        ? (isCorrect
                              ? Icons.check_box
                              : Icons.check_box_outline_blank)
                        : (isCorrect
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked),
                    color: isCorrect ? const Color(0xFF2ECC71) : Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      opt,
                      style: TextStyle(
                        fontSize: 15,
                        color: isCorrect
                            ? const Color(0xFF2ECC71)
                            : Colors.black87,
                        fontWeight: isCorrect
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      );
    }

    return Text(text, style: const TextStyle(fontSize: 16));
  }

  Widget _buildFillInBlanksText(String text) {
    if (text.isEmpty)
      return const Text(
        'Enter text with [[answer]] blanks',
        style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
      );

    final RegExp regex = RegExp(r'\[\[(.*?)\]\]');
    final matches = regex.allMatches(text);

    if (matches.isEmpty) {
      return Text(text, style: const TextStyle(fontSize: 16));
    }

    List<InlineSpan> spans = [];
    int lastMatchEnd = 0;

    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }

      final answer = match.group(1) ?? '';
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFF3498DB), width: 2),
              ),
            ),
            child: Text(
              answer.isEmpty ? '...' : answer,
              style: const TextStyle(
                color: Color(0xFF3498DB),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
          height: 1.8,
        ),
        children: spans,
      ),
    );
  }
}
