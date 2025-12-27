import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/data/data_source/dio_service.dart';
import 'package:news_app/data/models/news_model.dart';

part 'news_list_state.dart';

class NewsListCubit extends Cubit<NewsListState> {
  NewsListCubit() : super(NewsListInitial());

  Future<void> getNewFromApi({required String searchedItem}) async {
    emit(NewsListLoading());

    try {
      final List<NewsModel> newsResponse = await DioService().getNews(
        searchedItem: searchedItem,
      );

      emit(NewsListSuccess(newsResponse));
    } catch (error) {
      emit(NewsListError());
    }
  }
}
