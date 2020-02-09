// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZdkComment _$ZdkCommentFromJson(Map json) {
  return ZdkComment(
    json['body'] as String,
    json['id'] as int,
    json['author_id'] as int,
    json['request_id'] as String,
    json['html_body'] as String,
    json['created_at'] as String,
    (json['last_commenting_agents_ids'] as List)
        ?.map((e) => e as int)
        ?.toList(),
    json['first_comment'] == null
        ? null
        : ZdkComment.fromJson(json['first_comment'] as Map),
    (json['attachments'] as List)
        ?.map((e) => e == null ? null : Attachment.fromJson(e as Map))
        ?.toList(),
  );
}

Map<String, dynamic> _$ZdkCommentToJson(ZdkComment instance) =>
    <String, dynamic>{
      'body': instance.body,
      'id': instance.id,
      'author_id': instance.authorId,
      'request_id': instance.requestId,
      'html_body': instance.htmlBody,
      'created_at': instance.createdAt,
      'last_commenting_agents_ids': instance.lastCommentingAgentsIds,
      'first_comment': instance.firstComment?.toJson(),
      'attachments': instance.attachments?.map((e) => e?.toJson())?.toList(),
    };
