import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:news_app/data/data_source/network_constants.dart';
import 'package:news_app/data/models/news_model.dart';

class DioService {
  final dio = Dio();

  Future<List<NewsModel>> getNews({required String searchedItem}) async {
    final response = await dio.get(
      '$baseUrl$newsEndpoint?q=$searchedItem&from=2025-12-22&sortBy=publishedAt&apiKey=7c07f0c86d484b30a5af1289c531cff1',
    );

    return (response.data['articles'] as List).map((articleJson) {
      return NewsModel.fromJson(articleJson);
    }).toList();
  }
}



/* 
[


{
'title': 'Sample News Title',
'description': 'This is a sample news description.',
'imageUrl': 'https://via.placeholder.com/150',
},
{},
{},
{},
{},
{},
{},
{},

]

*/