import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:apiconnectapp/models/article.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: "https://newsapi.org/v2")
abstract class NewsApiService {
  factory NewsApiService(Dio dio, {String baseUrl}) = _NewsApiService;

  @GET("/top-headlines")
  Future<NewsResponse> getTopHeadlines(
    @Query("country") String country,
    @Query("apiKey") String apiKey,
  );
}
