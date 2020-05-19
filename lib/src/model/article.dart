import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable(anyMap: true)
class Article {
  int identifier;
  @JsonKey(name: 'section_id')
  int sectionId;
  String title;
  String body;
  @JsonKey(name: 'author_name')
  String authorName;
  @JsonKey(name: 'author_id')
  int authorId;
  @JsonKey(name: 'article_details')
  String articleDetails;
  @JsonKey(name: 'article_parents')
  String articleParents;
  @JsonKey(name: 'created_at')
  double createdAt;
  int position;
  bool outdated;
  int voteSum;
  @JsonKey(name: 'label_names')
  List<String> labelNames;
  @JsonKey(name: 'html_url')
  String htmlUrl;

  Article(
      {this.identifier,
      this.sectionId,
      this.title,
      this.body,
      this.authorName,
      this.authorId,
      this.articleDetails,
      this.articleParents,
      this.createdAt,
      this.position,
      this.outdated,
      this.voteSum,
      this.labelNames,
      this.htmlUrl});

  factory Article.fromJson(Map json) => _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
