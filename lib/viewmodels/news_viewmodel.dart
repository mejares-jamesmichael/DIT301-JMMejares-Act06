import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:apiconnectapp/models/article.dart';
import 'package:apiconnectapp/services/api_client.dart';
import 'package:apiconnectapp/services/news_api.dart';
import 'package:apiconnectapp/services/connectivity_service.dart';

class NewsViewModel extends ChangeNotifier {
  List<Article> _articles = [];
  List<Article> get articles => _articles;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  late NewsApi _newsApi;
  String? _apiKey;
  late ConnectivityService _connectivityService;

  NewsViewModel({
    NewsApi? newsApi,
    String? apiKey,
    ConnectivityService? connectivityService,
  }) {
    _newsApi = newsApi ?? NewsApi(ApiClient.dio);
    _apiKey = apiKey;
    _connectivityService = connectivityService ?? ConnectivityService();
  }

  Future<void> fetchNews() async {
    // Check internet connectivity
    final hasInternet = await _connectivityService.hasInternetConnection();
    if (!hasInternet) {
      _errorMessage = 'No internet connection. Please check your network.';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final apiKey = _apiKey ?? dotenv.env['NEWS_API_KEY'];
      if (apiKey == null) {
        throw Exception('NEWS_API_KEY not found in .env file');
      }
      final newsResponse = await _newsApi.getTopHeadlines(
        'us', // country
        apiKey,
      );

      // Check if articles array is empty
      if (newsResponse.articles.isEmpty) {
        _errorMessage = 'No news articles available at this time.';
      } else {
        _articles = newsResponse.articles;
      }
    } on DioException catch (e) {
      _errorMessage = e.message ?? 'Failed to load news data.';
      // Keep existing articles on error
    } catch (e) {
      _errorMessage = 'Failed to load news: $e';
      // Keep existing articles on error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
