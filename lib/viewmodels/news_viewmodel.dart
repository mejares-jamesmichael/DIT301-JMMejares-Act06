import 'package:flutter/material.dart';
import 'package:apiconnectapp/models/article.dart';
import 'package:apiconnectapp/services/api_client.dart';
import 'package:apiconnectapp/services/news_api_service.dart';

class NewsViewModel extends ChangeNotifier {
  List<Article> _articles = [];
  List<Article> get articles => _articles;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final NewsApiService _newsApiService = NewsApiService(ApiClient.dio);

  Future<void> fetchNews() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newsResponse = await _newsApiService.getTopHeadlines(
        'us', // country
        'YOUR_NEWSAPI_API_KEY', // TODO: Replace with actual API key
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
