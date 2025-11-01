import 'package:app_movie/domain/movie/usecases/get_trending_movies.dart';
import 'package:app_movie/presentation/home/bloc/trending_state.dart';
import 'package:app_movie/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrendingCubit extends Cubit<TrendingState> {
  TrendingCubit() : super(TrendingMoviesLoading());

  void getTrendingMovies() async {
    var moviesData = await sl<GetTrendingMoviesUseCase>().call();
    moviesData.fold(
      (error) {
        emit(FailureLoadTrendingMovies(errorMessage: error.toString()));
      },
      (data) {
        emit(TrendingMoviesLoaded(movies: data));
      },
    );
  }
}
