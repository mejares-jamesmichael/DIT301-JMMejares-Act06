import 'package:flutter/material.dart';
import 'package:apiconnectapp/models/article.dart';

class ArticleTile extends StatelessWidget {
  final Article article;

  const ArticleTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(article.title),
      subtitle: Text(article.description ?? ''),
      leading: article.urlToImage != null
          ? Image.network(
              article.urlToImage!,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image_not_supported);
              },
            )
          : const Icon(Icons.image_not_supported),
    );
  }
}
