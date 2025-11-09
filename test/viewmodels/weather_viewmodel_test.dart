import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:apiconnectapp/models/weather.dart';
import 'package:apiconnectapp/services/weather_api_service.dart';
import 'package:apiconnectapp/viewmodels/weather_viewmodel.dart';

import 'mocks.mocks.dart';

void main() {
  group('WeatherViewModel', () {
    late WeatherViewModel weatherViewModel;
    late MockWeatherApi mockWeatherApi;
    late MockConnectivityService mockConnectivityService;

    setUp(() {
      mockWeatherApi = MockWeatherApi();
      mockConnectivityService = MockConnectivityService();
      weatherViewModel = WeatherViewModel(
        weatherApi: mockWeatherApi,
        apiKey: 'test-key',
        connectivityService: mockConnectivityService,
      );
    });

    test('fetchWeather updates weather and loading state on success', () async {
      final mockWeatherResponse = WeatherResponse(
        name: 'London',
        main: WeatherMain(
          temp: 15.0,
          feelsLike: 14.0,
          tempMin: 10.0,
          tempMax: 20.0,
          pressure: 1012,
          humidity: 70,
        ),
        weather: [
          WeatherCondition(
            id: 800,
            main: 'Clear',
            description: 'clear sky',
            icon: '01d',
          ),
        ],
      );

      when(
        mockConnectivityService.hasInternetConnection(),
      ).thenAnswer((_) async => true);
      when(
        mockWeatherApi.getWeather('London', 'test-key', 'metric'),
      ).thenAnswer((_) async => mockWeatherResponse);

      expect(weatherViewModel.isLoading, false);
      expect(weatherViewModel.weather, null);

      await weatherViewModel.fetchWeather('London');

      expect(weatherViewModel.isLoading, false);
      expect(weatherViewModel.weather, isA<Weather>());
      expect(weatherViewModel.weather!.name, 'London');
      expect(weatherViewModel.weather!.temperature, 15.0);
      expect(weatherViewModel.weather!.description, 'clear sky');
      expect(weatherViewModel.weather!.icon, '01d');
      expect(weatherViewModel.errorMessage, null);
    });

    test('fetchWeather sets error message on failure', () async {
      when(
        mockConnectivityService.hasInternetConnection(),
      ).thenAnswer((_) async => true);
      when(
        mockWeatherApi.getWeather('London', 'test-key', 'metric'),
      ).thenThrow(Exception('Failed to fetch data'));

      expect(weatherViewModel.isLoading, false);
      expect(weatherViewModel.errorMessage, null);

      await weatherViewModel.fetchWeather('London');

      expect(weatherViewModel.isLoading, false);
      expect(weatherViewModel.weather, null);
      expect(
        weatherViewModel.errorMessage,
        'Failed to load weather: Exception: Failed to fetch data',
      );
    });

    test(
      'fetchWeather sets error message when no internet connection',
      () async {
        when(
          mockConnectivityService.hasInternetConnection(),
        ).thenAnswer((_) async => false);

        await weatherViewModel.fetchWeather('London');

        expect(
          weatherViewModel.errorMessage,
          'No internet connection. Please check your network.',
        );
        expect(weatherViewModel.weather, null);
        verifyNever(mockWeatherApi.getWeather(any, any, any));
      },
    );

    test('fetchWeather sets error message when city is empty', () async {
      await weatherViewModel.fetchWeather('');

      expect(weatherViewModel.errorMessage, 'Please enter a city name.');
      expect(weatherViewModel.weather, null);
      verifyNever(mockConnectivityService.hasInternetConnection());
      verifyNever(mockWeatherApi.getWeather(any, any, any));
    });
  });
}
