import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:apiconnectapp/models/article.dart';
import 'package:apiconnectapp/viewmodels/news_viewmodel.dart';

import 'mocks.mocks.dart';

void main() {
  group('NewsViewModel', () {
    late NewsViewModel newsViewModel;
    late MockNewsApi mockNewsApi;
    late MockConnectivityService mockConnectivityService;

    setUp(() {
      mockNewsApi = MockNewsApi();
      mockConnectivityService = MockConnectivityService();
      newsViewModel = NewsViewModel(
        newsApi: mockNewsApi,
        apiKey: 'test-key',
        connectivityService: mockConnectivityService,
      );
    });

    test('fetchNews updates articles and loading state on success', () async {
      final mockNewsResponse = NewsResponse(
        status: 'ok',
        totalResults: 1,
        articles: [
          Article(
            title: 'Test Article',
            author: 'John Doe',
            description: 'This is a test article.',
            url: 'http://example.com',
            urlToImage: 'http://example.com/image.jpg',
            publishedAt: '2023-01-01T12:00:00Z',
            content: 'Some content here.',
          ),
        ],
      );

      when(
        mockConnectivityService.hasInternetConnection(),
      ).thenAnswer((_) async => true);
      when(
        mockNewsApi.getTopHeadlines('us', 'test-key'),
      ).thenAnswer((_) async => mockNewsResponse);

      expect(newsViewModel.isLoading, false);
      expect(newsViewModel.articles, isEmpty);

      await newsViewModel.fetchNews();

      expect(newsViewModel.isLoading, false);
      expect(newsViewModel.articles, isNotEmpty);
      expect(newsViewModel.articles.length, 1);
      expect(newsViewModel.articles[0].title, 'Test Article');
      expect(newsViewModel.errorMessage, null);
    });

    test('fetchNews sets error message on failure', () async {
      when(
        mockConnectivityService.hasInternetConnection(),
      ).thenAnswer((_) async => true);
      when(
        mockNewsApi.getTopHeadlines('us', 'test-key'),
      ).thenThrow(Exception('Failed to fetch data'));

      expect(newsViewModel.isLoading, false);
      expect(newsViewModel.errorMessage, null);

      await newsViewModel.fetchNews();

      expect(newsViewModel.isLoading, false);
      expect(newsViewModel.articles, isEmpty);
      expect(
        newsViewModel.errorMessage,
        'Failed to load news: Exception: Failed to fetch data',
      );
    });

    test('fetchNews sets error message when no internet connection', () async {
      when(
        mockConnectivityService.hasInternetConnection(),
      ).thenAnswer((_) async => false);

      await newsViewModel.fetchNews();

      expect(
        newsViewModel.errorMessage,
        'No internet connection. Please check your network.',
      );
      verifyNever(mockNewsApi.getTopHeadlines(any, any));
    });

    test('fetchNews sets error message when articles array is empty', () async {
      final mockNewsResponse = NewsResponse(
        status: 'ok',
        totalResults: 0,
        articles: [],
      );

      when(
        mockConnectivityService.hasInternetConnection(),
      ).thenAnswer((_) async => true);
      when(
        mockNewsApi.getTopHeadlines('us', 'test-key'),
      ).thenAnswer((_) async => mockNewsResponse);

      await newsViewModel.fetchNews();

      expect(
        newsViewModel.errorMessage,
        'No news articles available at this time.',
      );
      expect(newsViewModel.articles, isEmpty);
    });
  });
}
