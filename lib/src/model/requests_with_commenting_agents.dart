import 'package:flutter_zendesk/src/model/request.dart';
import 'package:flutter_zendesk/src/model/support_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'requests_with_commenting_agents.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class ZdkRequestsWithCommentingAgents {
  @JsonKey(name: "commenting_agents", defaultValue: [], includeIfNull: false)
  final List<ZdkSupportUser> commentingAgents;
  @JsonKey(name: "requests", defaultValue: [], includeIfNull: false)
  final List<ZdkRequest> requests;

  ZdkRequestsWithCommentingAgents({this.commentingAgents, this.requests});

  factory ZdkRequestsWithCommentingAgents.fromJson(Map json) =>
      _$ZdkRequestsWithCommentingAgentsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ZdkRequestsWithCommentingAgentsToJson(this);
}
