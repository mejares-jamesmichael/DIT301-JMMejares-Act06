import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:apiconnectapp/screens/weather_screen.dart';
import 'package:apiconnectapp/viewmodels/weather_viewmodel.dart';
import '../viewmodels/mocks.mocks.dart';

void main() {
  late MockWeatherApi mockWeatherApi;

  setUp(() {
    mockWeatherApi = MockWeatherApi();
  });

  testWidgets('WeatherScreen shows initial state', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) =>
            WeatherViewModel(weatherApi: mockWeatherApi, apiKey: 'test-key'),
        child: const MaterialApp(home: Scaffold(body: WeatherScreen())),
      ),
    );

    // Initially, show "Please enter a city"
    expect(find.text('Please enter a city'), findsOneWidget);
    expect(find.text('Get Weather'), findsOneWidget);
  });

  testWidgets('WeatherScreen shows error message when fetch fails', (
    WidgetTester tester,
  ) async {
    when(
      mockWeatherApi.getWeather(any, any, any),
    ).thenThrow(Exception('Network error'));

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) =>
            WeatherViewModel(weatherApi: mockWeatherApi, apiKey: 'test-key'),
        child: const MaterialApp(home: Scaffold(body: WeatherScreen())),
      ),
    );

    // Enter text and tap the button
    await tester.enterText(find.byType(TextField), 'London');
    await tester.tap(find.text('Get Weather'));
    await tester.pump();

    // Wait for error to be displayed
    await tester.pump();

    expect(
      find.text('Failed to load weather: Exception: Network error'),
      findsOneWidget,
    );
  });
}
