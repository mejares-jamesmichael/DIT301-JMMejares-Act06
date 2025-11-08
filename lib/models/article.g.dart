// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
  author: json['author'] as String?,
  title: json['title'] as String,
  description: json['description'] as String?,
  url: json['url'] as String?,
  urlToImage: json['urlToImage'] as String?,
  publishedAt: json['publishedAt'] as String?,
  content: json['content'] as String?,
);

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
  'author': instance.author,
  'title': instance.title,
  'description': instance.description,
  'url': instance.url,
  'urlToImage': instance.urlToImage,
  'publishedAt': instance.publishedAt,
  'content': instance.content,
};

NewsResponse _$NewsResponseFromJson(Map<String, dynamic> json) => NewsResponse(
  status: json['status'] as String,
  totalResults: (json['totalResults'] as num).toInt(),
  articles: (json['articles'] as List<dynamic>)
      .map((e) => Article.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$NewsResponseToJson(NewsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles.map((e) => e.toJson()).toList(),
    };
