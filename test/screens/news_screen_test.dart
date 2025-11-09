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
  late MockConnectivityService mockConnectivityService;

  setUp(() {
    mockNewsApi = MockNewsApi();
    mockConnectivityService = MockConnectivityService();
  });

  testWidgets('NewsScreen handles error and shows empty state', (
    WidgetTester tester,
  ) async {
    // Mock the API to throw an error
    when(
      mockConnectivityService.hasInternetConnection(),
    ).thenAnswer((_) async => true);
    when(
      mockNewsApi.getTopHeadlines(any, any),
    ).thenThrow(Exception('Network error'));

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => NewsViewModel(
          newsApi: mockNewsApi,
          apiKey: 'test-key',
          connectivityService: mockConnectivityService,
        ),
        child: const MaterialApp(home: Scaffold(body: NewsScreen())),
      ),
    );

    // Wait for the initial loading
    await tester.pump();

    // Wait for the error to be processed
    await tester.pump();

    // Should show empty state (error is shown in snackbar, not in-screen)
    expect(find.text('No news available.'), findsOneWidget);
  });

  testWidgets('NewsScreen shows "No news available" when articles are empty', (
    WidgetTester tester,
  ) async {
    // Mock the API to return empty news
    when(
      mockConnectivityService.hasInternetConnection(),
    ).thenAnswer((_) async => true);
    when(mockNewsApi.getTopHeadlines(any, any)).thenAnswer(
      (_) async => NewsResponse(status: 'ok', totalResults: 0, articles: []),
    );

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => NewsViewModel(
          newsApi: mockNewsApi,
          apiKey: 'test-key',
          connectivityService: mockConnectivityService,
        ),
        child: const MaterialApp(home: Scaffold(body: NewsScreen())),
      ),
    );

    // Wait for the fetch to complete
    await tester.pumpAndSettle();

    expect(find.text('No news available.'), findsOneWidget);
  });
}
