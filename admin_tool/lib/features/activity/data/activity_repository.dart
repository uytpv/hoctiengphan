import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_tool/features/activity/domain/activity.dart';

class ActivityRepository {
  final FirebaseFirestore _firestore;

  ActivityRepository(this._firestore);

  CollectionReference<Activity> get _collection =>
      _firestore.collection('activities').withConverter<Activity>(
            fromFirestore: (snapshot, _) => Activity.fromJson(snapshot.data()!..['id'] = snapshot.id),
            toFirestore: (activity, _) => activity.toJson()..remove('id'),
          );

  Future<void> createActivity(Activity activity) => _collection.add(activity);

  Future<String> createActivityAndGetId(Activity activity) async {
    final docRef = await _collection.add(activity);
    return docRef.id;
  }

  Future<void> updateActivity(Activity activity) =>
      _collection.doc(activity.id).set(activity);

  Future<void> deleteActivity(String id) => _collection.doc(id).delete();

  Stream<List<Activity>> getActivities() =>
      _collection.snapshots().map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
}

final activityRepositoryProvider = Provider((ref) => ActivityRepository(FirebaseFirestore.instance));

final activitiesStreamProvider = StreamProvider<List<Activity>>((ref) {
  return ref.watch(activityRepositoryProvider).getActivities();
});
