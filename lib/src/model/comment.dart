import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ZdkComment {
  final String body;
  final int id;
  @JsonKey(name: 'author_id')
  final int authorId;
  @JsonKey(name: 'request_id')
  final String requestId;
  @JsonKey(name: 'html_body')
  final String htmlBody;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'last_commenting_agents_ids')
  final List<int> lastCommentingAgentsIds;
  @JsonKey(name: 'first_comment')
  final ZdkComment firstComment;

  ZdkComment(this.body, this.id, this.authorId, this.requestId, this.htmlBody,
      this.createdAt, this.lastCommentingAgentsIds, this.firstComment);

  factory ZdkComment.fromJson(Map json) => _$ZdkCommentFromJson(json);

  Map<String, dynamic> toJson() => _$ZdkCommentToJson(this);
}
