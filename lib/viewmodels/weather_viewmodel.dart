import 'package:flutter/material.dart';
import 'package:apiconnectapp/models/weather.dart';
import 'package:apiconnectapp/services/api_client.dart';
import 'package:apiconnectapp/services/weather_api_service.dart';

class WeatherViewModel extends ChangeNotifier {
  Weather? _weather;
  Weather? get weather => _weather;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final WeatherApiService _weatherApiService = WeatherApiService(ApiClient.dio);

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final weatherResponse = await _weatherApiService.getWeather(
        city,
        'YOUR_OPENWEATHERMAP_API_KEY', // TODO: Replace with actual API key
        'metric',
      );

      _weather = Weather(
        name: weatherResponse.name,
        temperature: weatherResponse.main.temp,
        description: weatherResponse.weather[0].description,
        icon: weatherResponse.weather[0].icon,
      );
    } catch (e) {
      _errorMessage = 'Failed to load weather: $e';
      _weather = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
