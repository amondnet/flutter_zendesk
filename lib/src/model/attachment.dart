import 'package:json_annotation/json_annotation.dart';

part 'attachment.g.dart';

@JsonSerializable(anyMap: true)
class Attachment {
  final int id;
  @JsonKey(name: "file_name")
  final String fileName;
  @JsonKey(name: "content_url")
  final String contentUrl;
  @JsonKey(name: "content_type")
  final String contentType;
  final int size;
  final List<Photo> thumbnails;
  final bool inline;
  final bool deleted;

  Attachment(this.id, this.fileName, this.contentUrl, this.contentType,
      this.size, this.thumbnails, this.inline, this.deleted);

  factory Attachment.fromJson(Map json) => _$AttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}

@JsonSerializable(anyMap: true)
class Photo extends Attachment {
  Photo(int id, String fileName, String contentUrl, String contentType,
      int size, List<Photo> thumbnails, bool inline, bool deleted)
      : super(id, fileName, contentUrl, contentType, size, null, inline,
            deleted);

  factory Photo.fromJson(Map json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
