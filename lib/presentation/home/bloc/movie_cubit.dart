import 'package:app_movie/domain/movie/entities/movie.dart';
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
        // Extract MovieItemEntity từ List<MovieEntity>
        final List<MovieEntity> movieEntities = data;
        final List<MovieItemEntity> movieItems = movieEntities
            .expand((page) => page.items)
            .toList();

        if (loadMore && state is MoviesLoaded) {
          final current = (state as MoviesLoaded).movies;
          emit(MoviesLoaded(movies: [...current, ...movieItems]));
        } else {
          emit(MoviesLoaded(movies: movieItems));
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
    final moviesData = await sl<GetMoviesByTypeUseCase>().call(
      params: GetMoviesByTypeParams(typeList: typeList, page: page),
    );
    moviesData.fold(
      (error) => emit(FailureLoadMovies(errorMessage: error.toString())),
      (data) {
        // Extract MovieItemEntity từ List<MovieEntity>
        final List<MovieEntity> movieEntities = data;
        final List<MovieItemEntity> movieItems = movieEntities
            .expand((page) => page.items)
            .toList();

        if (loadMore && state is MoviesLoaded) {
          final current = (state as MoviesLoaded).movies;
          emit(MoviesLoaded(movies: [...current, ...movieItems]));
        } else {
          emit(MoviesLoaded(movies: movieItems));
        }
      },
    );
  }
}
