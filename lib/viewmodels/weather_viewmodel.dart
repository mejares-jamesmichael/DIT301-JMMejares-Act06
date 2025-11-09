import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:apiconnectapp/models/weather.dart';
import 'package:apiconnectapp/services/api_client.dart';
import 'package:apiconnectapp/services/weather_api.dart';
import 'package:apiconnectapp/services/connectivity_service.dart';

class WeatherViewModel extends ChangeNotifier {
  Weather? _weather;
  Weather? get weather => _weather;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  late WeatherApi _weatherApi;
  String? _apiKey;
  late ConnectivityService _connectivityService;

  WeatherViewModel({
    WeatherApi? weatherApi,
    String? apiKey,
    ConnectivityService? connectivityService,
  }) {
    _weatherApi = weatherApi ?? WeatherApi(ApiClient.dio);
    _apiKey = apiKey;
    _connectivityService = connectivityService ?? ConnectivityService();
  }

  Future<void> fetchWeather(String city) async {
    // Validate city input
    if (city.trim().isEmpty) {
      _errorMessage = 'Please enter a city name.';
      notifyListeners();
      return;
    }

    // Check internet connectivity
    final hasInternet = await _connectivityService.hasInternetConnection();
    if (!hasInternet) {
      _errorMessage = 'No internet connection. Please check your network.';
      notifyListeners();
      return;
    }

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

      // Check if weather data is empty
      if (weatherResponse.weather.isEmpty) {
        _errorMessage = 'No weather data available for this city.';
        _weather = null;
      } else {
        _weather = Weather(
          name: weatherResponse.name,
          temperature: weatherResponse.main.temp,
          description: weatherResponse.weather[0].description,
          icon: weatherResponse.weather[0].icon,
        );
      }
    } on DioException catch (e) {
      _errorMessage = e.message ?? 'Failed to load weather data.';
      _weather = null;
    } catch (e) {
      _errorMessage = 'Failed to load weather: $e';
      _weather = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
