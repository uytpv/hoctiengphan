import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Exercise Option Shuffling Tests', () {
    test('Shuffling preserves correct answer text while changing index', () {
      final sampleQuestions = [
        {
          'prompt': '1. Minä _____ (olla) vietnamilainen.',
          'type': 'MULTIPLE_CHOICE',
          'options': ['olen', 'olet', 'on', 'olemme'],
          'correctIndex': 0,
          'explanation': "Ngôi minä (tôi) đi với 'olen'."
        },
        {
          'prompt': '2. Sinä _____ (olla) opiskelija.',
          'type': 'MULTIPLE_CHOICE',
          'options': ['olet', 'olen', 'on', 'olette'],
          'correctIndex': 0,
          'explanation': "Ngôi sinä (bạn) đi với 'olet'."
        },
        {
          'prompt': '3. Hän _____ (olla) opettaja.',
          'type': 'MULTIPLE_CHOICE',
          'options': ['on', 'olen', 'ovat', 'olet'],
          'correctIndex': 0,
          'explanation': "Ngôi hän (anh ấy/cô ấy) đi với 'on'."
        }
      ];

      final random = Random(42);

      for (var q in sampleQuestions) {
        final originalOptions = List<dynamic>.from(q['options'] as List);
        final originalCorrectIndex = q['correctIndex'] as int;
        final originalCorrectText = originalOptions[originalCorrectIndex];

        // Indexed entries shuffle logic
        final indexedEntries = originalOptions.asMap().entries.toList()..shuffle(random);
        final shuffledOptions = indexedEntries.map((e) => e.value).toList();
        final newCorrectIndex = indexedEntries.indexWhere((e) => e.key == originalCorrectIndex);

        // Verification 1: Length remains the same
        expect(shuffledOptions.length, originalOptions.length);

        // Verification 2: All items preserved
        expect(shuffledOptions.toSet(), originalOptions.toSet());

        // Verification 3: Correct answer at new index points to exact same string
        expect(shuffledOptions[newCorrectIndex], originalCorrectText);
      }
    });

    test('Verify across chapter_01_exercises.json questions', () {
      final file = File('../content/curriculum/chapter_01_exercises.json');
      expect(file.existsSync(), isTrue);

      final data = jsonDecode(file.readAsStringSync());
      final exercises = data['exercises'] as List<dynamic>;
      final targetExercise = exercises.firstWhere((e) => e['id'] == 'ex_w2_d1_chia_olla');

      expect(targetExercise, isNotNull);
      final questions = targetExercise['questions'] as List<dynamic>;
      expect(questions.length, 6);

      final random = Random(12345);
      final correctIndices = <int>[];

      for (var q in questions) {
        final options = List<dynamic>.from(q['options'] as List);
        final correctIndex = q['correctIndex'] as int;
        final correctText = options[correctIndex];

        final indexedEntries = options.asMap().entries.toList()..shuffle(random);
        final shuffledOptions = indexedEntries.map((e) => e.value).toList();
        final newCorrectIndex = indexedEntries.indexWhere((e) => e.key == correctIndex);

        expect(shuffledOptions[newCorrectIndex], correctText);
        correctIndices.add(newCorrectIndex);
      }

      // Over 6 questions, not all answers should remain at index 0
      final uniqueIndices = correctIndices.toSet();
      expect(uniqueIndices.length, greaterThan(1),
          reason: 'Correct answers should be distributed across multiple positions');
    });
  });
}
