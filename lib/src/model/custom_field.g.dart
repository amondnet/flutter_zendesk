// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomField _$CustomFieldFromJson(Map json) {
  return CustomField(
    json['fieldId'] as int,
    json['value'] as String,
  );
}

Map<String, dynamic> _$CustomFieldToJson(CustomField instance) =>
    <String, dynamic>{
      'fieldId': instance.fieldId,
      'value': instance.value,
    };
