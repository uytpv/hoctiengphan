import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson.freezed.dart';
part 'lesson.g.dart';

@freezed
class Lesson with _$Lesson {
  const factory Lesson({
    required String id,
    @Default('') String title,
    String? description, // Mô tả ngắn gọn nội dung bài học
    @Default(LessonContent()) LessonContent lessonContent, // Phần 1: Bài học
    @Default(LessonGrammar()) LessonGrammar grammar,      // Phần 2: Ngữ pháp
    @Default(LessonSpeaking()) LessonSpeaking speaking,   // Phần 3: Bài nói
    @Default([]) List<String> exerciseIds,               // Phần 4: Bài tập (Danh sách ID)
  }) = _Lesson;

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
}

@freezed
class LessonContent with _$LessonContent {
  const factory LessonContent({
    @Default('') String text,          // Nội dung bài học (Markdown/HTML)
    String? videoUrl,                  // Link video bài giảng (nếu có)
    @Default([]) List<String> imageIds, // Các hình ảnh minh họa trong bài
  }) = _LessonContent;

  factory LessonContent.fromJson(Map<String, dynamic> json) => _$LessonContentFromJson(json);
}

@freezed
class LessonGrammar with _$LessonGrammar {
  const factory LessonGrammar({
    @Default('') String text,          // Nội dung giải thích ngữ pháp
    String? audioUrl,                  // Audio giải thích hoặc ví dụ
  }) = _LessonGrammar;

  factory LessonGrammar.fromJson(Map<String, dynamic> json) => _$LessonGrammarFromJson(json);
}

@freezed
class LessonSpeaking with _$LessonSpeaking {
  const factory LessonSpeaking({
    @Default('') String text,          // Nội dung bài mẫu/hội thoại
    String? audioUrl,                  // Audio nghe mẫu
    String? conversationUrl,           // Script hoặc tài liệu hội thoại đi kèm
  }) = _LessonSpeaking;

  factory LessonSpeaking.fromJson(Map<String, dynamic> json) => _$LessonSpeakingFromJson(json);
}
