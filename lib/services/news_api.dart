import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:apiconnectapp/models/article.dart';

part 'news_api.g.dart';

@RestApi(baseUrl: "https://newsapi.org/v2")
abstract class NewsApi {
  factory NewsApi(Dio dio, {String baseUrl}) = _NewsApi;

  @GET("/top-headlines")
  Future<NewsResponse> getTopHeadlines(
    @Query("country") String country,
    @Query("apiKey") String apiKey,
  );
}
