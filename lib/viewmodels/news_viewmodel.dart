import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:apiconnectapp/models/article.dart';
import 'package:apiconnectapp/services/api_client.dart';
import 'package:apiconnectapp/services/news_api.dart';

class NewsViewModel extends ChangeNotifier {
  List<Article> _articles = [];
  List<Article> get articles => _articles;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  late NewsApi _newsApi;
  String? _apiKey;

  NewsViewModel({NewsApi? newsApi, String? apiKey}) {
    _newsApi = newsApi ?? NewsApi(ApiClient.dio);
    _apiKey = apiKey;
  }

  Future<void> fetchNews() async {
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
      _articles = newsResponse.articles;
    } catch (e) {
      _errorMessage = 'Failed to load news: $e';
      _articles = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
