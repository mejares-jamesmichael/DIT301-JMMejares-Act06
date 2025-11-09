import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:apiconnectapp/viewmodels/news_viewmodel.dart';
import 'package:apiconnectapp/widgets/article_tile.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch news when the screen is first loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsViewModel>(context, listen: false).fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (viewModel.errorMessage != null) {
          return Center(child: Text(viewModel.errorMessage!));
        }
        if (viewModel.articles.isEmpty) {
          return const Center(child: Text('No news available.'));
        }
        return ListView.builder(
          itemCount: viewModel.articles.length,
          itemBuilder: (context, index) {
            return ArticleTile(article: viewModel.articles[index]);
          },
        );
      },
    );
  }
}
