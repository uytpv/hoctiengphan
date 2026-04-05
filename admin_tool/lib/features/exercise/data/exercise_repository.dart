import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/exercise.dart';

final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) {
  return ExerciseRepository(FirebaseFirestore.instance);
});

final exercisesStreamProvider = StreamProvider<List<Exercise>>((ref) {
  final repository = ref.watch(exerciseRepositoryProvider);
  return repository.watchExercises();
});

class ExerciseRepository {
  final FirebaseFirestore _firestore;

  ExerciseRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('exercises');

  Stream<List<Exercise>> watchExercises() {
    return _collection.snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => Exercise.fromJson({...doc.data(), 'id': doc.id}))
          .toList(),
    );
  }

  Future<void> createExercise(Exercise exercise) async {
    final data = exercise.toJson();
    data.remove('id');
    await _collection.add(data);
  }

  Future<void> updateExercise(Exercise exercise) async {
    final data = exercise.toJson();
    data.remove('id');
    await _collection.doc(exercise.id).set(data, SetOptions(merge: true));
  }

  Future<void> deleteExercise(String id) async {
    await _collection.doc(id).delete();
  }
}
