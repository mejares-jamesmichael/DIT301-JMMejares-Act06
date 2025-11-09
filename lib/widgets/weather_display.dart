import 'package:flutter/material.dart';
import 'package:apiconnectapp/models/weather.dart';

class WeatherDisplay extends StatelessWidget {
  final Weather weather;

  const WeatherDisplay({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          weather.name,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Image.network(
          'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
        ),
        const SizedBox(height: 16),
        Text(
          '${weather.temperature.toStringAsFixed(1)}°C',
          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(weather.description, style: const TextStyle(fontSize: 24)),
      ],
    );
  }
}
