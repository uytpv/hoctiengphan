import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson.freezed.dart';
part 'lesson.g.dart';

@freezed
class Lesson with _$Lesson {
  const factory Lesson({
    required String id,
    @Default('') String title,
    @Default('') String chapter, // e.g., "Kappale 1"
    int? week, // Optionally link trực tiếp tới tuần học
    String? description, // Mô tả ngắn gọn
    @Default('') String content, // Nội dung Markdown chứa các shortcode nhúng
    @Default([]) List<String> vocabIds, // Danh sách ID từ vựng nhúng
    @Default([]) List<String> exerciseIds, // Danh sách ID bài tập nhúng
    @Default([]) List<String> audioUrls, // Danh sách link audio nhúng
    @Default([]) List<String> grammarIds, // Danh sách ID ngữ pháp nhúng hoặc liên kết
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Lesson;

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
}
