// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'immersion_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImmersionResourceImpl _$$ImmersionResourceImplFromJson(
  Map<String, dynamic> json,
) => _$ImmersionResourceImpl(
  id: json['id'] as String,
  type: const ImmersionTypeConverter().fromJson(json['type'] as String),
  title: json['title'] as String,
  description: json['description'] as String? ?? '',
  mediaUrl: json['mediaUrl'] as String?,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  originalContent: json['originalContent'] as String?,
  vietnameseTranslation: json['vietnameseTranslation'] as String?,
  vocabularyNotes:
      (json['vocabularyNotes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$ImmersionResourceImplToJson(
  _$ImmersionResourceImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': const ImmersionTypeConverter().toJson(instance.type),
  'title': instance.title,
  'description': instance.description,
  'mediaUrl': instance.mediaUrl,
  'thumbnailUrl': instance.thumbnailUrl,
  'originalContent': instance.originalContent,
  'vietnameseTranslation': instance.vietnameseTranslation,
  'vocabularyNotes': instance.vocabularyNotes,
  'tags': instance.tags,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};
