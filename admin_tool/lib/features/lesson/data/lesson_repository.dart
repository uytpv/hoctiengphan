import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/lesson.dart';

final lessonRepositoryProvider = Provider<LessonRepository>((ref) {
  return LessonRepository(FirebaseFirestore.instance);
});

final lessonsStreamProvider = StreamProvider<List<Lesson>>((ref) {
  final repository = ref.watch(lessonRepositoryProvider);
  return repository.watchLessons();
});

class LessonRepository {
  final FirebaseFirestore _firestore;

  LessonRepository(this._firestore);

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('lessons');

  Stream<List<Lesson>> watchLessons() {
    return _collection.snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => Lesson.fromJson({...doc.data(), 'id': doc.id}))
          .toList(),
    );
  }

  Future<void> createLesson(Lesson lesson) async {
    final data = lesson.toJson();
    data.remove('id'); // ID is the document ID
    await _collection.add(data);
  }

  Future<void> updateLesson(Lesson lesson) async {
    final data = lesson.toJson();
    data.remove('id');
    await _collection.doc(lesson.id).set(data, SetOptions(merge: true));
  }

  Future<void> deleteLesson(String id) async {
    await _collection.doc(id).delete();
  }
}
