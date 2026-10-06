import 'package:freezed_annotation/freezed_annotation.dart';

part 'immersion_resource.freezed.dart';
part 'immersion_resource.g.dart';

class ImmersionTypeConverter implements JsonConverter<ImmersionType, String> {
  const ImmersionTypeConverter();

  @override
  ImmersionType fromJson(String json) {
    switch (json) {
      case 'music':
        return ImmersionType.music;
      case 'movie':
      case 'video':
        return ImmersionType.movie;
      case 'street_sign':
      case 'streetSign':
      case 'sign':
        return ImmersionType.streetSign;
      case 'practical_life':
      case 'practicalLife':
      case 'life':
        return ImmersionType.practicalLife;
      default:
        return ImmersionType.practicalLife;
    }
  }

  @override
  String toJson(ImmersionType object) {
    switch (object) {
      case ImmersionType.music:
        return 'music';
      case ImmersionType.movie:
        return 'movie';
      case ImmersionType.streetSign:
        return 'street_sign';
      case ImmersionType.practicalLife:
        return 'practical_life';
    }
  }
}

enum ImmersionType {
  music,
  movie,
  streetSign,
  practicalLife,
}

@freezed
class ImmersionResource with _$ImmersionResource {
  const factory ImmersionResource({
    required String id,
    @ImmersionTypeConverter() required ImmersionType type,
    required String title,
    @Default('') String description,
    String? mediaUrl,
    String? thumbnailUrl,
    String? originalContent,
    String? vietnameseTranslation,
    @Default([]) List<String> vocabularyNotes,
    @Default([]) List<String> tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ImmersionResource;

  factory ImmersionResource.fromJson(Map<String, dynamic> json) =>
      _$ImmersionResourceFromJson(json);
}
