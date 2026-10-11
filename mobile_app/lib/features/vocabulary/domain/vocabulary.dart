import 'package:cloud_firestore/cloud_firestore.dart';

class Vocabulary {
  final String id;
  final String finnish;
  final String? pronunciation;
  final String vietnamese;
  final String english;
  final String? lessonId;
  final String? category;
  final String? audioUrl;
  final String? imageUrl;
  final String? example;
  final String? exampleTranslation;

  Vocabulary({
    required this.id,
    required this.finnish,
    required this.vietnamese,
    required this.english,
    this.pronunciation,
    this.lessonId,
    this.category,
    this.audioUrl,
    this.imageUrl,
    this.example,
    this.exampleTranslation,
  });

  factory Vocabulary.fromFirestore(DocumentSnapshot doc) {
    final data = (doc.data() as Map<String, dynamic>?) ?? {};
    return Vocabulary.fromMap(data, doc.id);
  }

  factory Vocabulary.fromMap(Map<String, dynamic> data, String id) {
    return Vocabulary(
      id: id,
      finnish: data['finnish'] as String? ?? '',
      vietnamese: data['vietnamese'] as String? ?? '',
      english: data['english'] as String? ?? '',
      pronunciation: data['pronunciation'] as String?,
      lessonId: data['lessonId'] as String?,
      category: data['category'] as String? ??
          ((data['categoryIds'] is List && (data['categoryIds'] as List).isNotEmpty)
              ? (data['categoryIds'] as List).first.toString()
              : null),
      audioUrl: data['audioUrl'] as String?,
      imageUrl: data['imageUrl'] as String?,
      example: data['example'] as String?,
      exampleTranslation: data['exampleTranslation'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'finnish': finnish,
      'vietnamese': vietnamese,
      'english': english,
      'pronunciation': pronunciation,
      'lessonId': lessonId,
      'category': category,
      'audioUrl': audioUrl,
      'imageUrl': imageUrl,
      'example': example,
      'exampleTranslation': exampleTranslation,
    };
  }
}
