import 'package:app_movie/domain/movie/usecases/get_movies.dart';
import 'package:app_movie/domain/movie/usecases/get_movies_by_type.dart';
import 'package:app_movie/presentation/home/bloc/movie_state.dart';
import 'package:app_movie/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(MoviesLoading());

  int _page = 1;

  void getMovies({bool loadMore = false}) async {
    if (!loadMore) emit(MoviesLoading());
    var moviesData = await sl<GetMoviesUseCase>().call(params: _page);
    moviesData.fold(
      (error) => emit(FailureLoadMovies(errorMessage: error.toString())),
      (data) {
        if (loadMore && state is MoviesLoaded) {
          final current = (state as MoviesLoaded).movies;
          emit(MoviesLoaded(movies: [...current, ...data]));
        } else {
          emit(MoviesLoaded(movies: data));
        }
        _page++;
      },
    );
  }

  void getMoviesByType({
    required String typeList,
    int page = 1,
    bool loadMore = false,
  }) async {
    if (!loadMore) emit(MoviesLoading());
    var moviesData = await sl<GetMoviesByTypeUseCase>().call(
      params: GetMoviesByTypeParams(typeList: typeList, page: page),
    );
    moviesData.fold(
      (error) => emit(FailureLoadMovies(errorMessage: error.toString())),
      (data) {
        if (loadMore && state is MoviesLoaded) {
          final current = (state as MoviesLoaded).movies;
          emit(MoviesLoaded(movies: [...current, ...data]));
        } else {
          emit(MoviesLoaded(movies: data));
        }
      },
    );
  }
}
