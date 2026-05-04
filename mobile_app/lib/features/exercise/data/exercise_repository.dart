import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../domain/models/exercise.dart';

class ExerciseRepository {
  final Dio _dio;

  ExerciseRepository(this._dio);

  Future<List<Exercise>> getExercisesByLesson(String lessonId) async {
    try {
      final response = await _dio.get('/exercise/lesson/$lessonId');
      final List data = response.data;
      return data.map((json) => Exercise.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Exercise> getExerciseById(String id) async {
    try {
      final response = await _dio.get('/exercise/$id');
      return Exercise.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> submitAnswer({
    required String exerciseId,
    required Map<String, dynamic> answers,
    String? planId,
    String? activityId,
  }) async {
    try {
      final response = await _dio.post('/exercise/submit', data: {
        'exerciseId': exerciseId,
        'answers': answers,
        'planId': planId,
        'activityId': activityId,
      });
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }
}

final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) {
  return ExerciseRepository(ref.watch(apiClientProvider).dio);
});
