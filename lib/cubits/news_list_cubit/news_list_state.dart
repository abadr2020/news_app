part of 'news_list_cubit.dart';

@immutable
sealed class NewsListState {}

final class NewsListInitial extends NewsListState {}

final class NewsListLoading extends NewsListState {}

final class NewsListSuccess extends NewsListState {
  final List<NewsModel> newsList;
  NewsListSuccess(this.newsList);
}

final class NewsListError extends NewsListState {}
