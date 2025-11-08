import 'package:flutter_test/flutter_test.dart';
import 'package:apiconnectapp/models/weather.dart';

void main() {
  group('Weather', () {
    test('fromJson creates a valid Weather object', () {
      final Map<String, dynamic> json = {
        'name': 'London',
        'temperature': 10.5,
        'description': 'cloudy',
        'icon': '04d',
      };

      final weather = Weather.fromJson(json);

      expect(weather.name, 'London');
      expect(weather.temperature, 10.5);
      expect(weather.description, 'cloudy');
      expect(weather.icon, '04d');
    });

    test('toJson converts a Weather object to JSON', () {
      final weather = Weather(
        name: 'London',
        temperature: 10.5,
        description: 'cloudy',
        icon: '04d',
      );

      final json = weather.toJson();

      expect(json['name'], 'London');
      expect(json['temperature'], 10.5);
      expect(json['description'], 'cloudy');
      expect(json['icon'], '04d');
    });
  });
}
