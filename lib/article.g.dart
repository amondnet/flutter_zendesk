// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
      identifier: json['identifier'] as int,
      sectionId: json['section_id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      authorName: json['authorName'] as String,
      authorId: json['authorId'] as int,
      articleDetails: json['articleDetails'] as String,
      articleParents: json['articleParents'] as String,
      createdAt: (json['createdAt'] as num)?.toDouble(),
      position: json['position'] as int,
      outdated: json['outdated'] as bool,
      voteSum: json['voteSum'] as int,
      labelNames:
          (json['labelNames'] as List)?.map((e) => e as String)?.toList(),
      htmlUrl: json['htmlUrl'] as String);
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'identifier': instance.identifier,
      'section_id': instance.sectionId,
      'title': instance.title,
      'body': instance.body,
      'authorName': instance.authorName,
      'authorId': instance.authorId,
      'articleDetails': instance.articleDetails,
      'articleParents': instance.articleParents,
      'createdAt': instance.createdAt,
      'position': instance.position,
      'outdated': instance.outdated,
      'voteSum': instance.voteSum,
      'labelNames': instance.labelNames,
      'htmlUrl': instance.htmlUrl
    };
