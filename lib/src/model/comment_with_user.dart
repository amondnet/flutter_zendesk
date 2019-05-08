import 'package:flutter_zendesk/src/model/comment.dart';
import 'package:flutter_zendesk/src/model/support_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_with_user.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class CommentWithUser {
  final ZdkSupportUser user;

  final ZdkComment comment;

  CommentWithUser({this.user, this.comment});

  factory CommentWithUser.fromJson(Map json) => _$CommentWithUserFromJson(json);

  Map<String, dynamic> toJson() => _$CommentWithUserToJson(this);
}
