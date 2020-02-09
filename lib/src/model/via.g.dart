// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'via.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Via _$ViaFromJson(Map json) {
  return Via(
    json['channel'] as String,
    json['source'] == null ? null : Source.fromJson(json['source'] as Map),
  );
}

Map<String, dynamic> _$ViaToJson(Via instance) => <String, dynamic>{
      'channel': instance.channel,
      'source': instance.source?.toJson(),
    };

Source _$SourceFromJson(Map json) {
  return Source(
    json['rel'] as String,
  );
}

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
      'rel': instance.rel,
    };
