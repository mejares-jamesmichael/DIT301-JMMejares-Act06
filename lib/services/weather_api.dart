import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:apiconnectapp/services/weather_api_service.dart';

part 'weather_api.g.dart';

@RestApi(baseUrl: "https://api.openweathermap.org/data/2.5")
abstract class WeatherApi {
  factory WeatherApi(Dio dio, {String baseUrl}) = _WeatherApi;

  @GET("/weather")
  Future<WeatherResponse> getWeather(
    @Query("q") String cityName,
    @Query("appid") String apiKey,
    @Query("units") String units,
  );
}
