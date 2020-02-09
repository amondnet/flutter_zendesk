import 'package:json_annotation/json_annotation.dart';

part 'via.g.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class Via {
  final String channel;
  final Source source;

  Via(this.channel, this.source);
}

@JsonSerializable(anyMap: true, explicitToJson: true)
class Source {
  final String rel;

  Source(this.rel);
}