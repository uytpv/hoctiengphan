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

  CollectionReference<Lesson> get _typedCollection => _firestore
      .collection('lessons')
      .withConverter<Lesson>(
        fromFirestore: (snapshot, _) =>
            Lesson.fromJson(snapshot.data()!..['id'] = snapshot.id),
        toFirestore: (lesson, _) => lesson.toJson()..remove('id'),
      );

  Stream<List<Lesson>> watchLessons() {
    return _typedCollection.snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => doc.data()).toList()
            ..sort((a, b) => a.chapter.compareTo(b.chapter)),
    );
  }

  Future<List<Lesson>> getLessonsOnce() async {
    final snapshot = await _typedCollection.get();
    return snapshot.docs.map((doc) => doc.data()).toList()
      ..sort((a, b) => a.chapter.compareTo(b.chapter));
  }

  Future<void> createLesson(Lesson lesson) => _typedCollection.add(lesson);

  Future<void> updateLesson(Lesson lesson) =>
      _typedCollection.doc(lesson.id).set(lesson, SetOptions(merge: true));

  Future<void> deleteLesson(String id) => _typedCollection.doc(id).delete();
}
