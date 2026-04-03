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
    final data = doc.data() as Map<String, dynamic>;
    return Vocabulary(
      id: doc.id,
      finnish: data['finnish'] ?? '',
      vietnamese: data['vietnamese'] ?? '',
      english: data['english'] ?? '',
      pronunciation: data['pronunciation'],
      lessonId: data['lessonId'],
      category: data['category'],
      audioUrl: data['audioUrl'],
      imageUrl: data['imageUrl'],
      example: data['example'],
      exampleTranslation: data['exampleTranslation'],
    );
  }

  Map<String, dynamic> toFirestore() {
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

  Vocabulary copyWith({
    String? id,
    String? finnish,
    String? vietnamese,
    String? english,
    String? pronunciation,
    String? lessonId,
    String? category,
    String? audioUrl,
    String? imageUrl,
    String? example,
    String? exampleTranslation,
  }) {
    return Vocabulary(
      id: id ?? this.id,
      finnish: finnish ?? this.finnish,
      vietnamese: vietnamese ?? this.vietnamese,
      english: english ?? this.english,
      pronunciation: pronunciation ?? this.pronunciation,
      lessonId: lessonId ?? this.lessonId,
      category: category ?? this.category,
      audioUrl: audioUrl ?? this.audioUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      example: example ?? this.example,
      exampleTranslation: exampleTranslation ?? this.exampleTranslation,
    );
  }
}
