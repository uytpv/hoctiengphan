import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/vocabulary.dart';

class VocabularyRepository {
  final FirebaseFirestore _firestore;

  VocabularyRepository(this._firestore);

  Stream<List<Vocabulary>> watchVocabularies() {
    return _firestore.collection('vocabulary').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Vocabulary.fromJson(data);
      }).toList();
    });
  }

  Future<void> addVocabulary(Vocabulary vocab) async {
    final docRef = _firestore.collection('vocabulary').doc();
    final data = vocab.toJson();
    data.remove('id');
    await docRef.set(data);
  }

  Future<void> updateVocabulary(Vocabulary vocab) async {
    final data = vocab.toJson();
    data.remove('id');
    await _firestore.collection('vocabulary').doc(vocab.id).update(data);
  }

  Future<void> deleteVocabulary(String id) async {
    await _firestore.collection('vocabulary').doc(id).delete();
  }
}

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final vocabularyRepositoryProvider = Provider<VocabularyRepository>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return VocabularyRepository(firestore);
});

final vocabulariesStreamProvider = StreamProvider<List<Vocabulary>>((ref) {
  final repository = ref.watch(vocabularyRepositoryProvider);
  return repository.watchVocabularies();
});
