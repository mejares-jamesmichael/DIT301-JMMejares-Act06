import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:apiconnectapp/models/weather.dart';
import 'package:apiconnectapp/services/api_client.dart';
import 'package:apiconnectapp/services/weather_api.dart';

class WeatherViewModel extends ChangeNotifier {
  Weather? _weather;
  Weather? get weather => _weather;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  late WeatherApi _weatherApi;
  String? _apiKey;

  WeatherViewModel({WeatherApi? weatherApi, String? apiKey}) {
    _weatherApi = weatherApi ?? WeatherApi(ApiClient.dio);
    _apiKey = apiKey;
  }

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final apiKey = _apiKey ?? dotenv.env['OPENWEATHERMAP_API_KEY'];
      if (apiKey == null) {
        throw Exception('OPENWEATHERMAP_API_KEY not found in .env file');
      }
      final weatherResponse = await _weatherApi.getWeather(
        city,
        apiKey,
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
