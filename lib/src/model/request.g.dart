// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZdkRequest _$ZdkRequestFromJson(Map json) {
  return ZdkRequest(
      createdAt: json['created_at'] as String,
      commentCount: json['comment_count'] as int,
      updatedAt: json['updated_at'] as String,
      publicUpdatedAt: json['public_updated_at'] as String,
      id: json['id'] as String,
      requesterId: json['requester_id'] as int,
      collaboratorIds:
          (json['collaborator_ids'] as List)?.map((e) => e as int)?.toList(),
      subject: json['subject'] as String,
      description: json['description'] as String,
      lastComment: json['last_comment'] == null
          ? null
          : ZdkComment.fromJson(json['last_comment'] as Map));
}

Map<String, dynamic> _$ZdkRequestToJson(ZdkRequest instance) =>
    <String, dynamic>{
      'created_at': instance.createdAt,
      'comment_count': instance.commentCount,
      'updated_at': instance.updatedAt,
      'public_updated_at': instance.publicUpdatedAt,
      'id': instance.id,
      'requester_id': instance.requesterId,
      'collaborator_ids': instance.collaboratorIds,
      'subject': instance.subject,
      'description': instance.description,
      'last_comment': instance.lastComment?.toJson()
    };