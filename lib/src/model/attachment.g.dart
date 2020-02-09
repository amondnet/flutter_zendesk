// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attachment _$AttachmentFromJson(Map json) {
  return Attachment(
    json['id'] as int,
    json['file_name'] as String,
    json['content_url'] as String,
    json['content_type'] as String,
    json['size'] as int,
    (json['thumbnails'] as List)
        ?.map((e) => e == null ? null : Photo.fromJson(e as Map))
        ?.toList(),
    json['inline'] as bool,
    json['deleted'] as bool,
  );
}

Map<String, dynamic> _$AttachmentToJson(Attachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'file_name': instance.fileName,
      'content_url': instance.contentUrl,
      'content_type': instance.contentType,
      'size': instance.size,
      'thumbnails': instance.thumbnails,
      'inline': instance.inline,
      'deleted': instance.deleted,
    };

Photo _$PhotoFromJson(Map json) {
  return Photo(
    json['id'] as int,
    json['file_name'] as String,
    json['content_url'] as String,
    json['content_type'] as String,
    json['size'] as int,
    (json['thumbnails'] as List)
        ?.map((e) => e == null ? null : Photo.fromJson(e as Map))
        ?.toList(),
    json['inline'] as bool,
    json['deleted'] as bool,
  );
}

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'id': instance.id,
      'file_name': instance.fileName,
      'content_url': instance.contentUrl,
      'content_type': instance.contentType,
      'size': instance.size,
      'thumbnails': instance.thumbnails,
      'inline': instance.inline,
      'deleted': instance.deleted,
    };
