import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_tool/features/student/domain/user_progress.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository(this._firestore);

  CollectionReference<UserProfile> get _collection => _firestore
      .collection('users')
      .withConverter<UserProfile>(
        fromFirestore: (snapshot, _) =>
            UserProfile.fromJson(snapshot.data()!..['id'] = snapshot.id),
        toFirestore: (user, _) => user.toJson()..remove('id'),
      );

  Future<void> createUser(UserProfile user) =>
      _collection.doc(user.id).set(user);

  Future<void> updateUser(UserProfile user) =>
      _collection.doc(user.id).set(user);

  Stream<List<UserProfile>> getUsers() => _collection.snapshots().map(
    (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
  );
}

final userRepositoryProvider = Provider(
  (ref) => UserRepository(FirebaseFirestore.instance),
);

final usersStreamProvider = StreamProvider<List<UserProfile>>((ref) {
  return ref.watch(userRepositoryProvider).getUsers();
});
