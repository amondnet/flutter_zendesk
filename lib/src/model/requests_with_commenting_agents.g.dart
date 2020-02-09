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
        [],
  );
}

Map<String, dynamic> _$ZdkRequestsWithCommentingAgentsToJson(
    ZdkRequestsWithCommentingAgents instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commenting_agents',
      instance.commentingAgents?.map((e) => e?.toJson())?.toList());
  writeNotNull(
      'requests', instance.requests?.map((e) => e?.toJson())?.toList());
  return val;
}
