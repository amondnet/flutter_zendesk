import 'package:flutter_zendesk/src/model/custom_field.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_request.g.dart';

@JsonSerializable(anyMap: true)
class ZdkCreateRequest {
  final List<String> tags;

  final String subject;

  @JsonKey(name: 'request_description')
  final String requestDescription;
  @JsonKey(ignore: true)
  // TODO
  final List attachments;
  @JsonKey(defaultValue: [])
  final List<ZdkCustomField> customTicketFields;

  ZdkCreateRequest(
    this.requestDescription, {
    this.tags,
    this.subject,
    this.attachments,
    this.customTicketFields = const [],
  });

  factory ZdkCreateRequest.fromJson(Map json) =>
      _$ZdkCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ZdkCreateRequestToJson(this);
}
