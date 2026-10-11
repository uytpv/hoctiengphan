import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/exercise.dart';
import '../domain/models/exercise_type.dart';

class ExerciseRepository {
  final FirebaseFirestore _db;
  final FirebaseAuth _auth;

  ExerciseRepository({
    FirebaseFirestore? db,
    FirebaseAuth? auth,
  })  : _db = db ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  Future<List<Exercise>> getExercisesByLesson(String lessonId) async {
    try {
      final snap = await _db
          .collection('exercises')
          .where('lessonId', isEqualTo: lessonId)
          .get();
      return snap.docs.map(Exercise.fromDoc).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Exercise> getExerciseById(String id) async {
    try {
      final doc = await _db.collection('exercises').doc(id).get();
      if (!doc.exists) {
        throw Exception('Harjoitusta ei löydy (Exercise not found: $id)');
      }
      return Exercise.fromDoc(doc);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> submitAnswer({
    required Exercise exercise,
    required Map<String, dynamic> answers,
    String? planId,
    String? activityId,
  }) async {
    try {
      final questions = exercise.questions;
      final total = questions.isEmpty ? 1 : questions.length;
      int score = 0;
      final feedback = <Map<String, dynamic>>[];

      for (var i = 0; i < questions.length; i++) {
        final q = questions[i];
        final userAnswer = answers[i.toString()];
        bool isCorrect = false;

        if (q.type == ExerciseType.multipleChoice || q.type == ExerciseType.trueFalse) {
          if (userAnswer is int && q.correctIndex != null) {
            isCorrect = userAnswer == q.correctIndex;
          } else if (userAnswer is bool && q.correctIndex != null) {
            // 0: True (Oikein), 1: False (Väärin)
            final expectedBool = q.correctIndex == 0;
            isCorrect = userAnswer == expectedBool;
          } else if (userAnswer != null && q.correctIndex != null) {
            isCorrect = userAnswer.toString() == q.correctIndex.toString();
          }
        } else if (q.type == ExerciseType.fillInBlank) {
          final uStr = (userAnswer?.toString() ?? '').trim().toLowerCase();
          final cStr = (q.correctText ?? '').trim().toLowerCase();
          isCorrect = uStr.isNotEmpty && uStr == cStr;
        }

        if (isCorrect) score++;

        feedback.add({
          'questionIndex': i,
          'prompt': q.prompt,
          'isCorrect': isCorrect,
          'userAnswer': userAnswer,
          'correctAnswer': q.type == ExerciseType.fillInBlank ? q.correctText : q.correctIndex,
          'explanation': q.explanation,
        });
      }

      final percentage = (score / total) * 100;
      final passed = percentage >= 70;

      // Đồng bộ trực tiếp vào user_progress trong Firestore khi hoàn thành
      if (passed && _uid != null && planId != null && planId.isNotEmpty && activityId != null && activityId.isNotEmpty) {
        final progressRef = _db
            .collection('user_progress')
            .doc(_uid)
            .collection('plans')
            .doc(planId);

        await progressRef.set(
          {
            'activities': {
              activityId: {
                'status': 'done',
                'score': score,
                'total': total,
                'percentage': percentage,
                'completedAt': FieldValue.serverTimestamp(),
              }
            },
            'updatedAt': FieldValue.serverTimestamp(),
          },
          SetOptions(merge: true),
        );
      }

      return {
        'score': score,
        'total': total,
        'percentage': percentage,
        'passed': passed,
        'isPassed': passed, // Khớp cả 2 key để tương thích UI
        'feedback': feedback,
      };
    } catch (e) {
      rethrow;
    }
  }
}

final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) {
  return ExerciseRepository();
});
