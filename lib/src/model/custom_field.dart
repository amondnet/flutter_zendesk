import 'package:json_annotation/json_annotation.dart';

part 'custom_field.g.dart';

@JsonSerializable(anyMap: true)
class ZdkCustomField {
  final int id;
  final String value;

  ZdkCustomField(this.id, this.value);

  factory ZdkCustomField.fromJson(Map json) => _$ZdkCustomFieldFromJson(json);

  Map<String, dynamic> toJson() => _$ZdkCustomFieldToJson(this);
}
