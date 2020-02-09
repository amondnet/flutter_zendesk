// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map json) {
  return Article(
    identifier: json['identifier'] as int,
    sectionId: json['section_id'] as int,
    title: json['title'] as String,
    body: json['body'] as String,
    authorName: json['author_name'] as String,
    authorId: json['authorId'] as int,
    articleDetails: json['article_details'] as String,
    articleParents: json['article_parents'] as String,
    createdAt: (json['created_at'] as num)?.toDouble(),
    position: json['position'] as int,
    outdated: json['outdated'] as bool,
    voteSum: json['voteSum'] as int,
    labelNames:
        (json['label_names'] as List)?.map((e) => e as String)?.toList(),
    htmlUrl: json['html_url'] as String,
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'identifier': instance.identifier,
      'section_id': instance.sectionId,
      'title': instance.title,
      'body': instance.body,
      'author_name': instance.authorName,
      'authorId': instance.authorId,
      'article_details': instance.articleDetails,
      'article_parents': instance.articleParents,
      'created_at': instance.createdAt,
      'position': instance.position,
      'outdated': instance.outdated,
      'voteSum': instance.voteSum,
      'label_names': instance.labelNames,
      'html_url': instance.htmlUrl,
    };
