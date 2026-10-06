import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/immersion_resource.dart';

class ImmersionRepository {
  final FirebaseFirestore _firestore;

  ImmersionRepository(this._firestore);

  CollectionReference<ImmersionResource> get _collection => _firestore
      .collection('immersion_resources')
      .withConverter<ImmersionResource>(
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
          return ImmersionResource.fromJson(data);
        },
        toFirestore: (resource, _) => resource.toJson()..remove('id'),
      );

  Stream<List<ImmersionResource>> getImmersionResourcesStream({ImmersionType? type}) {
    return _collection.snapshots().map((snapshot) {
      var items = snapshot.docs.map((doc) => doc.data()).toList();
      if (type != null) {
        items = items.where((item) => item.type == type).toList();
      }
      items.sort((a, b) {
        final aTime = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bTime = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bTime.compareTo(aTime);
      });
      return items;
    });
  }

  Future<List<ImmersionResource>> getAllImmersionResources({ImmersionType? type}) async {
    final snapshot = await _collection.get();
    var items = snapshot.docs.map((doc) => doc.data()).toList();
    if (type != null) {
      items = items.where((item) => item.type == type).toList();
    }
    items.sort((a, b) {
      final aTime = a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bTime = b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bTime.compareTo(aTime);
    });
    return items;
  }

  Future<ImmersionResource?> getById(String id) async {
    final doc = await _collection.doc(id).get();
    return doc.data();
  }

  Future<String> createImmersionResource(ImmersionResource resource) async {
    final docRef = await _collection.add(resource.copyWith(
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ));
    return docRef.id;
  }

  Future<void> updateImmersionResource(ImmersionResource resource) async {
    await _collection.doc(resource.id).set(
      resource.copyWith(updatedAt: DateTime.now()),
      SetOptions(merge: true),
    );
  }

  Future<void> deleteImmersionResource(String id) => _collection.doc(id).delete();
}

final immersionRepositoryProvider = Provider<ImmersionRepository>((ref) {
  return ImmersionRepository(FirebaseFirestore.instance);
});

final immersionListProvider = StreamProvider.family<List<ImmersionResource>, ImmersionType?>((ref, type) {
  return ref.watch(immersionRepositoryProvider).getImmersionResourcesStream(type: type);
});
