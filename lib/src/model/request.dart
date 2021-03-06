import 'package:flutter_zendesk/flutter_zendesk.dart';
import 'package:flutter_zendesk/src/model/comment.dart';
import 'package:flutter_zendesk/src/model/custom_field.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ZdkRequest {
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'comment_count')
  final int commentCount;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'public_updated_at')
  final String publicUpdatedAt;
  @JsonKey()
  final String id;
  @JsonKey(name: 'requester_id')
  final int requesterId;
  final String status;
  @JsonKey(name: 'collaborator_ids')
  final List<int> collaboratorIds;
  final String subject;
  final String description;
  @JsonKey(name: 'last_comment')
  final ZdkComment lastComment;

  @JsonKey(name: 'custom_fields', defaultValue: [])
  final List<CustomField> customFields;

  ZdkRequest(
      {this.createdAt,
      this.commentCount,
      this.updatedAt,
      this.publicUpdatedAt,
      this.id,
      this.requesterId,
      this.status,
      this.collaboratorIds,
      this.subject,
      this.description,
      this.lastComment,
      this.customFields = const []});

  factory ZdkRequest.fromJson(Map json) => _$ZdkRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ZdkRequestToJson(this);
}
