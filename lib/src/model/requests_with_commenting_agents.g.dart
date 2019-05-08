// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests_with_commenting_agents.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZdkRequestsWithCommentingAgents _$ZdkRequestsWithCommentingAgentsFromJson(
    Map json) {
  return ZdkRequestsWithCommentingAgents(
      commentingAgents: (json['commenting_agents'] as List)
              ?.map((e) => e == null ? null : ZdkSupportUser.fromJson(e as Map))
              ?.toList() ??
          [],
      requests: (json['requests'] as List)
              ?.map((e) => e == null ? null : ZdkRequest.fromJson(e as Map))
              ?.toList() ??
          []);
}

Map<String, dynamic> _$ZdkRequestsWithCommentingAgentsToJson(
        ZdkRequestsWithCommentingAgents instance) =>
    <String, dynamic>{
      'commenting_agents':
          instance.commentingAgents?.map((e) => e?.toJson())?.toList(),
      'requests': instance.requests?.map((e) => e?.toJson())?.toList()
    };
