import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:apiconnectapp/screens/home_screen.dart';
import 'package:apiconnectapp/viewmodels/news_viewmodel.dart';
import 'package:apiconnectapp/viewmodels/weather_viewmodel.dart';

void main() {
  testWidgets('HomeScreen has a title and bottom navigation bar', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => WeatherViewModel()),
          ChangeNotifierProvider(create: (_) => NewsViewModel()),
        ],
        child: const MaterialApp(home: HomeScreen()),
      ),
    );

    expect(find.text('APIConnectApp'), findsOneWidget);
    expect(find.byIcon(Icons.wb_sunny), findsOneWidget);
    expect(find.byIcon(Icons.article), findsOneWidget);
  });
}
