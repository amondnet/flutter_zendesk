import 'package:json_annotation/json_annotation.dart';

part 'custom_field.g.dart';

@JsonSerializable(anyMap: true)
class CustomField {
  final int fieldId;
  final String value;

  CustomField(this.fieldId, this.value);

  factory CustomField.fromJson(Map json) => _$CustomFieldFromJson(json);

  Map<String, dynamic> toJson() => _$CustomFieldToJson(this);
}
