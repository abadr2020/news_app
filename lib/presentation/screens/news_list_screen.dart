import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubits/news_list_cubit/news_list_cubit.dart';
import 'package:news_app/data/data_source/dio_service.dart';
import 'package:news_app/data/models/news_model.dart';
import '../widgets/news_card.dart';
import 'news_detail_screen.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  var _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<NewsListCubit>().getNewFromApi(searchedItem: 'Egypt');
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return BlocListener<NewsListCubit, NewsListState>(
      listener: (context, state) {
        if (state is NewsListSuccess) {
          _searchController.clear();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text('Top News'),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hint: Text(
                      'Type to search..',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    suffix: IconButton(
                      icon: Icon(Icons.search),
                      iconSize: 32,
                      onPressed: () {
                        context.read<NewsListCubit>().getNewFromApi(
                          searchedItem: _searchController.text,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: BlocBuilder<NewsListCubit, NewsListState>(
          builder: (context, state) {
            if (state is NewsListInitial) {
              return Center(
                child: Text(
                  'Welcome to news app, please click "Get news" to see todays news',
                ),
              );
            } else if (state is NewsListLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is NewsListSuccess) {
              List<NewsModel> newsList = state.newsList;

              return newsList.isEmpty
                  ? Center(
                      child: Text(
                        'No news available. Tap "Get News" to fetch articles.',
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: newsList.length,
                        itemBuilder: (context, index) {
                          return NewsCard(
                            id: newsList[index].id,
                            title: newsList[index].title,
                            description: newsList[index].description,
                            imageUrl: newsList[index].imageUrl,
                            source: newsList[index].source,
                            publishedAt: DateTime.parse(
                              newsList[index].publishedAt,
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration: const Duration(
                                    milliseconds: 400,
                                  ),
                                  pageBuilder: (_, __, ___) => NewsDetailScreen(
                                    article: newsList[index],
                                  ),
                                  transitionsBuilder: (_, anim, __, child) =>
                                      FadeTransition(
                                        opacity: anim,
                                        child: child,
                                      ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
            } else {
              return Center(
                child: Text('Error fetching news. Please try again.'),
              );
            }
          },
        ),
      ),
    );
  }
}

//Mention some arctictural patterns used in flutter app development:
// Bloc Pattern
// RiverPod pattern
// MVVM
// MVP
// MVC
// Clean Architecture

/// Why to use BLOC (Business Logic Component) architectural pattern ?
/// 1. Separation of Concerns: BLoC separates business logic from UI, making the codebase cleaner and easier to maintain, test, scale and expand.
/// 2. State management, controles the rebuilt widgets (which to rebuild and which not).


// BLOC :
// 1- Bloc :states - events - bloc
// 2- Cubit : states - functions - cubit


// Cubit.(states(states) - cubit(functions))
// 1- simpler than BLOC
// 2- only states and functions no events
// 3- less boilerplate code
// 4- easier to learn and implement




