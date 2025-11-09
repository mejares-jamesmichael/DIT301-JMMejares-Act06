import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:apiconnectapp/screens/news_screen.dart';
import 'package:apiconnectapp/viewmodels/news_viewmodel.dart';
import 'package:apiconnectapp/models/article.dart';
import '../viewmodels/mocks.mocks.dart';

void main() {
  late MockNewsApi mockNewsApi;

  setUp(() {
    mockNewsApi = MockNewsApi();
  });

  testWidgets('NewsScreen shows error message when fetch fails', (
    WidgetTester tester,
  ) async {
    // Mock the API to throw an error
    when(
      mockNewsApi.getTopHeadlines(any, any),
    ).thenThrow(Exception('Network error'));

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => NewsViewModel(newsApi: mockNewsApi, apiKey: 'test-key'),
        child: const MaterialApp(home: Scaffold(body: NewsScreen())),
      ),
    );

    // Wait for the initial loading
    await tester.pump();

    // Wait for the error to be displayed
    await tester.pump();

    expect(
      find.text('Failed to load news: Exception: Network error'),
      findsOneWidget,
    );
  });

  testWidgets('NewsScreen shows "No news available" when articles are empty', (
    WidgetTester tester,
  ) async {
    // Mock the API to return empty news
    when(mockNewsApi.getTopHeadlines(any, any)).thenAnswer(
      (_) async => NewsResponse(status: 'ok', totalResults: 0, articles: []),
    );

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => NewsViewModel(newsApi: mockNewsApi, apiKey: 'test-key'),
        child: const MaterialApp(home: Scaffold(body: NewsScreen())),
      ),
    );

    // Wait for the fetch to complete
    await tester.pumpAndSettle();

    expect(find.text('No news available.'), findsOneWidget);
  });
}
