import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_tool/features/activity/domain/activity.dart';

class ActivityRepository {
  final FirebaseFirestore _firestore;

  ActivityRepository(this._firestore);

  CollectionReference<Activity> get _collection => _firestore
      .collection('activities')
      .withConverter<Activity>(
        fromFirestore: (snapshot, _) {
          final data = snapshot.data()!;
          data['id'] = snapshot.id;
          // Chuyển đổi Timestamp sang String để fromJson của freezed có thể parse được
          if (data['createdAt'] is Timestamp) {
            data['createdAt'] = (data['createdAt'] as Timestamp)
                .toDate()
                .toIso8601String();
          }
          return Activity.fromJson(data);
        },
        toFirestore: (activity, _) => activity.toJson()..remove('id'),
      );

  Future<void> createActivity(Activity activity) => _collection.add(activity);

  Future<String> createActivityAndGetId(Activity activity) async {
    final docRef = await _collection.add(activity);
    return docRef.id;
  }

  Future<void> updateActivity(Activity activity) =>
      _collection.doc(activity.id).set(activity);

  Future<Activity?> getActivityByLessonId(String lessonId) async {
    final query = await _collection.where('lessonId', isEqualTo: lessonId).get();
    if (query.docs.isNotEmpty) {
      return query.docs.first.data();
    }
    return null;
  }

  Future<String> upsertLessonActivity(String lessonId, String title, String description) async {
    final query = await _collection.where('lessonId', isEqualTo: lessonId).get();
    if (query.docs.isNotEmpty) {
      final doc = query.docs.first;
      final existingActivity = doc.data();
      final updated = existingActivity.copyWith(
        title: title,
        description: description,
      );
      await updateActivity(updated);
      return doc.id;
    } else {
      final activity = Activity(
        id: '',
        title: title,
        description: description,
        type: ActivityType.lesson,
        lessonId: lessonId,
        isPublic: true,
        createdAt: DateTime.now(),
      );
      return await createActivityAndGetId(activity);
    }
  }

  Future<String> upsertExerciseActivity(String exerciseId, String title, String description) async {
    final query = await _collection.where('exerciseId', isEqualTo: exerciseId).get();
    if (query.docs.isNotEmpty) {
      final doc = query.docs.first;
      final existingActivity = doc.data();
      final updated = existingActivity.copyWith(
        title: title,
        description: description,
      );
      await updateActivity(updated);
      return doc.id;
    } else {
      final activity = Activity(
        id: '',
        title: title,
        description: description,
        type: ActivityType.exercise,
        exerciseId: exerciseId,
        isPublic: true,
        createdAt: DateTime.now(),
      );
      return await createActivityAndGetId(activity);
    }
  }

  Future<void> deleteActivity(String id) => _collection.doc(id).delete();

  Stream<List<Activity>> getActivities() => _collection.snapshots().map(
    (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
  );
}

final activityRepositoryProvider = Provider(
  (ref) => ActivityRepository(FirebaseFirestore.instance),
);

final activitiesStreamProvider = StreamProvider<List<Activity>>((ref) {
  return ref.watch(activityRepositoryProvider).getActivities();
});
