import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/vocabulary.dart';

class VocabularyRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addVocabulary(Vocabulary voc) async {
    await _db.collection('vocabularies').add(voc.toFirestore());
  }

  Future<void> updateVocabulary(Vocabulary voc) async {
    await _db.collection('vocabularies').doc(voc.id).update(voc.toFirestore());
  }

  Future<void> deleteVocabulary(String id) async {
    await _db.collection('vocabularies').doc(id).delete();
  }
}

// Provider for vocabulary repository
final vocabularyRepositoryProvider = Provider((ref) => VocabularyRepository());
