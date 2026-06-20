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
        fromFirestore: (snapshot, _) {
          final data = snapshot.data()!;
          data['id'] = snapshot.id;
          if (data['createdAt'] is Timestamp) {
            data['createdAt'] = (data['createdAt'] as Timestamp)
                .toDate()
                .toIso8601String();
          }
          if (data['updatedAt'] is Timestamp) {
            data['updatedAt'] = (data['updatedAt'] as Timestamp)
                .toDate()
                .toIso8601String();
          }
          return Lesson.fromJson(data);
        },
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

  Future<String> createLesson(Lesson lesson) async {
    final docRef = await _typedCollection.add(lesson);
    return docRef.id;
  }

  Future<void> updateLesson(Lesson lesson) =>
      _typedCollection.doc(lesson.id).set(lesson, SetOptions(merge: true));

  Future<void> deleteLesson(String id) => _typedCollection.doc(id).delete();
}
