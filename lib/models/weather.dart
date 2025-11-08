import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  final String name;
  final double temperature;
  final String description;
  final String icon;

  Weather({
    required this.name,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}
