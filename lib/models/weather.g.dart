// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
  name: json['name'] as String,
  temperature: (json['temperature'] as num).toDouble(),
  description: json['description'] as String,
  icon: json['icon'] as String,
);

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
  'name': instance.name,
  'temperature': instance.temperature,
  'description': instance.description,
  'icon': instance.icon,
};
