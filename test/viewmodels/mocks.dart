import 'package:mockito/annotations.dart';
import 'package:apiconnectapp/services/weather_api.dart';
import 'package:apiconnectapp/services/news_api.dart';
import 'package:apiconnectapp/services/connectivity_service.dart';

@GenerateMocks([WeatherApi, NewsApi, ConnectivityService])
void main() {}
