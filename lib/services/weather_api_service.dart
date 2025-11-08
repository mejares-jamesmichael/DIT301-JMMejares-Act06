import 'package:json_annotation/json_annotation.dart';

part 'weather_api_service.g.dart';

@JsonSerializable()
class WeatherResponse {
  final WeatherMain main;
  final List<WeatherCondition> weather;
  final String name;

  WeatherResponse({
    required this.main,
    required this.weather,
    required this.name,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}

@JsonSerializable()
class WeatherMain {
  @JsonKey(name: 'temp')
  final double temp;
  @JsonKey(name: 'feels_like')
  final double feelsLike;
  @JsonKey(name: 'temp_min')
  final double tempMin;
  @JsonKey(name: 'temp_max')
  final double tempMax;
  final int pressure;
  final int humidity;

  WeatherMain({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  factory WeatherMain.fromJson(Map<String, dynamic> json) =>
      _$WeatherMainFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherMainToJson(this);
}

@JsonSerializable()
class WeatherCondition {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherCondition({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) =>
      _$WeatherConditionFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherConditionToJson(this);
}
