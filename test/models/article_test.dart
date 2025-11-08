import 'package:flutter_test/flutter_test.dart';
import 'package:apiconnectapp/models/article.dart';

void main() {
  group('Article', () {
    test('fromJson creates a valid Article object', () {
      final Map<String, dynamic> json = {
        'author': 'John Doe',
        'title': 'Test Article',
        'description': 'This is a test article.',
        'url': 'http://example.com',
        'urlToImage': 'http://example.com/image.jpg',
        'publishedAt': '2023-01-01T12:00:00Z',
        'content': 'Some content here.',
      };

      final article = Article.fromJson(json);

      expect(article.author, 'John Doe');
      expect(article.title, 'Test Article');
      expect(article.description, 'This is a test article.');
      expect(article.url, 'http://example.com');
      expect(article.urlToImage, 'http://example.com/image.jpg');
      expect(article.publishedAt, '2023-01-01T12:00:00Z');
      expect(article.content, 'Some content here.');
    });

    test('toJson converts an Article object to JSON', () {
      final article = Article(
        author: 'John Doe',
        title: 'Test Article',
        description: 'This is a test article.',
        url: 'http://example.com',
        urlToImage: 'http://example.com/image.jpg',
        publishedAt: '2023-01-01T12:00:00Z',
        content: 'Some content here.',
      );

      final json = article.toJson();

      expect(json['author'], 'John Doe');
      expect(json['title'], 'Test Article');
      expect(json['description'], 'This is a test article.');
      expect(json['url'], 'http://example.com');
      expect(json['urlToImage'], 'http://example.com/image.jpg');
      expect(json['publishedAt'], '2023-01-01T12:00:00Z');
      expect(json['content'], 'Some content here.');
    });
  });

  group('NewsResponse', () {
    test('fromJson creates a valid NewsResponse object', () {
      final Map<String, dynamic> json = {
        'status': 'ok',
        'totalResults': 1,
        'articles': [
          {
            'author': 'John Doe',
            'title': 'Test Article',
            'description': 'This is a test article.',
            'url': 'http://example.com',
            'urlToImage': 'http://example.com/image.jpg',
            'publishedAt': '2023-01-01T12:00:00Z',
            'content': 'Some content here.',
          },
        ],
      };

      final newsResponse = NewsResponse.fromJson(json);

      expect(newsResponse.status, 'ok');
      expect(newsResponse.totalResults, 1);
      expect(newsResponse.articles.length, 1);
      expect(newsResponse.articles[0].title, 'Test Article');
    });

    test('toJson converts a NewsResponse object to JSON', () {
      final newsResponse = NewsResponse(
        status: 'ok',
        totalResults: 1,
        articles: [
          Article(
            author: 'John Doe',
            title: 'Test Article',
            description: 'This is a test article.',
            url: 'http://example.com',
            urlToImage: 'http://example.com/image.jpg',
            publishedAt: '2023-01-01T12:00:00Z',
            content: 'Some content here.',
          ),
        ],
      );

      final json = newsResponse.toJson();

      expect(json['status'], 'ok');
      expect(json['totalResults'], 1);
      expect(json['articles'].length, 1);
      expect(json['articles'][0]['title'], 'Test Article');
    });
  });
}
