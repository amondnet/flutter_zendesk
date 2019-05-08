import 'package:json_annotation/json_annotation.dart';

part 'support_user.g.dart';

@JsonSerializable(anyMap: true)
class ZdkSupportUser {
  //@JsonKey(defaultValue: [])
  final String tags;
  final String name;
  final int id;
  final bool agent;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  @JsonKey(name: 'user_fields')
  final Map<String, dynamic> userFields;

  ZdkSupportUser(
      {this.tags,
      this.name,
      this.id,
      this.agent,
      this.userFields,
      this.avatarUrl});

  factory ZdkSupportUser.fromJson(Map json) => _$ZdkSupportUserFromJson(json);

  Map<String, dynamic> toJson() => _$ZdkSupportUserToJson(this);
}
