// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZdkCreateRequest _$ZdkCreateRequestFromJson(Map json) {
  return ZdkCreateRequest(json['requestDescription'] as String,
      tags: (json['tags'] as List)?.map((e) => e as String)?.toList(),
      subject: json['subject'] as String);
}

Map<String, dynamic> _$ZdkCreateRequestToJson(ZdkCreateRequest instance) =>
    <String, dynamic>{
      'tags': instance.tags,
      'subject': instance.subject,
      'requestDescription': instance.requestDescription
    };