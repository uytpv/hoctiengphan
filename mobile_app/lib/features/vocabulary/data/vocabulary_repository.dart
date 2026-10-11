import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/vocabulary.dart';

class VocabularyRepository {
  final FirebaseFirestore _firestore;

  VocabularyRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('vocabularies');

  /// Stream danh sách từ vựng với lọc và sắp xếp
  Stream<List<Vocabulary>> watchVocabularies({
    String? lessonId,
    String? category,
    int limit = 150,
  }) {
    Query<Map<String, dynamic>> query = _collection;

    if (lessonId != null && lessonId.isNotEmpty) {
      query = query.where('lessonId', isEqualTo: lessonId);
    } else if (category != null && category.isNotEmpty) {
      query = query.where('category', isEqualTo: category);
    }

    return query.limit(limit).snapshots().map((snapshot) {
      final list = snapshot.docs
          .map((doc) => Vocabulary.fromFirestore(doc))
          .toList();
      list.sort((a, b) => a.finnish.toLowerCase().compareTo(b.finnish.toLowerCase()));
      return list;
    });
  }

  /// Lấy danh sách từ vựng 1 lần cho Flashcard
  Future<List<Vocabulary>> getVocabularies({
    String? lessonId,
    String? category,
    int limit = 150,
  }) async {
    Query<Map<String, dynamic>> query = _collection;

    if (lessonId != null && lessonId.isNotEmpty) {
      query = query.where('lessonId', isEqualTo: lessonId);
    } else if (category != null && category.isNotEmpty) {
      query = query.where('category', isEqualTo: category);
    }

    final snapshot = await query.limit(limit).get();
    final list = snapshot.docs
        .map((doc) => Vocabulary.fromFirestore(doc))
        .toList();
    list.sort((a, b) => a.finnish.toLowerCase().compareTo(b.finnish.toLowerCase()));
    return list;
  }

  /// Lấy danh sách các categories duy nhất
  Future<List<String>> getCategories() async {
    try {
      final snap = await _firestore.collection('categories').get();
      if (snap.docs.isNotEmpty) {
        return snap.docs
            .map((d) => d.data()['name']?.toString() ?? d.id)
            .toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }
}

final vocabularyRepositoryProvider = Provider<VocabularyRepository>((ref) {
  return VocabularyRepository();
});
