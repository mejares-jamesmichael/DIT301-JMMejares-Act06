import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // TODO: Add WeatherViewModelProvider
        // TODO: Add NewsViewModelProvider
      ],
      child: MaterialApp(
        title: 'APIConnectApp',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const Text(
          'Hello APIConnectApp!',
        ), // TODO: Replace with HomeScreen
      ),
    );
  }
}
