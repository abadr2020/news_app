import 'package:flutter/foundation.dart';

class NewsModel {
  NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.source,
    required this.publishedAt,
    required this.author,
  });

  final String author;
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String source;
  final String publishedAt;

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['source']['id'] ?? "no id",
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      imageUrl: json['urlToImage'] ?? 'https://via.placeholder.com/150',
      source: json['source']['name'] ?? 'Unknown Source',
      publishedAt: json['publishedAt'] ?? "2024-01-01T00:00:00Z",

      author: json['author'] ?? 'Unknown Author',
    );
  }
}
