import 'package:app_movie/domain/movie/usecases/get_hot_movies.dart';
import 'package:app_movie/presentation/home/bloc/hot_state.dart';
import 'package:app_movie/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotCubit extends Cubit<HotState> {
  HotCubit() : super(HotMoviesLoading());
  int _page = 1;

  void getHotMovies({bool loadMore = false}) async {
    if (!loadMore) emit(HotMoviesLoading());
    var moviesData = await sl<GetHotMoviesUseCase>().call(params: _page);
    moviesData.fold(
      (error) {
        emit(FailureLoadHotMovies(errorMessage: error.toString()));
      },
      (data) {
        if (loadMore && state is HotMoviesLoaded) {
          final current = (state as HotMoviesLoaded).movies;
          emit(HotMoviesLoaded(movies: [...current, ...data]));
        } else {
          emit(HotMoviesLoaded(movies: data));
        }
        _page++;
      },
    );
  }
}

