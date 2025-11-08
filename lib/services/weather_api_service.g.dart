// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_api_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) =>
    WeatherResponse(
      main: WeatherMain.fromJson(json['main'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => WeatherCondition.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$WeatherResponseToJson(WeatherResponse instance) =>
    <String, dynamic>{
      'main': instance.main,
      'weather': instance.weather,
      'name': instance.name,
    };

WeatherMain _$WeatherMainFromJson(Map<String, dynamic> json) => WeatherMain(
  temp: (json['temp'] as num).toDouble(),
  feelsLike: (json['feels_like'] as num).toDouble(),
  tempMin: (json['temp_min'] as num).toDouble(),
  tempMax: (json['temp_max'] as num).toDouble(),
  pressure: (json['pressure'] as num).toInt(),
  humidity: (json['humidity'] as num).toInt(),
);

Map<String, dynamic> _$WeatherMainToJson(WeatherMain instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
    };

WeatherCondition _$WeatherConditionFromJson(Map<String, dynamic> json) =>
    WeatherCondition(
      id: (json['id'] as num).toInt(),
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$WeatherConditionToJson(WeatherCondition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };
