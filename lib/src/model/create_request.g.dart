// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZdkCreateRequest _$ZdkCreateRequestFromJson(Map json) {
  return ZdkCreateRequest(json['request_description'] as String,
      tags: (json['tags'] as List)?.map((e) => e as String)?.toList(),
      subject: json['subject'] as String,
      customTicketFields: (json['customTicketFields'] as List)
              ?.map((e) => e == null ? null : ZdkCustomField.fromJson(e as Map))
              ?.toList() ??
          []);
}

Map<String, dynamic> _$ZdkCreateRequestToJson(ZdkCreateRequest instance) =>
    <String, dynamic>{
      'tags': instance.tags,
      'subject': instance.subject,
      'request_description': instance.requestDescription,
      'customTicketFields': instance.customTicketFields
    };
