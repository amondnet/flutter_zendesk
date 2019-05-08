// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZdkSupportUser _$ZdkSupportUserFromJson(Map json) {
  return ZdkSupportUser(
      tags: json['tags'] as String,
      name: json['name'] as String,
      id: json['id'] as int,
      agent: json['agent'] as bool,
      userFields: (json['user_fields'] as Map)?.map(
        (k, e) => MapEntry(k as String, e),
      ),
      avatarUrl: json['avatar_url'] as String);
}

Map<String, dynamic> _$ZdkSupportUserToJson(ZdkSupportUser instance) =>
    <String, dynamic>{
      'tags': instance.tags,
      'name': instance.name,
      'id': instance.id,
      'agent': instance.agent,
      'avatar_url': instance.avatarUrl,
      'user_fields': instance.userFields
    };
