// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_with_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentWithUser _$CommentWithUserFromJson(Map json) {
  return CommentWithUser(
    user: json['user'] == null
        ? null
        : ZdkSupportUser.fromJson(json['user'] as Map),
    comment: json['comment'] == null
        ? null
        : ZdkComment.fromJson(json['comment'] as Map),
  );
}

Map<String, dynamic> _$CommentWithUserToJson(CommentWithUser instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'comment': instance.comment?.toJson(),
    };
