import 'package:app_movie/domain/movie/entities/movie.dart';

abstract class HotState {}

class HotMoviesLoading extends HotState {}

class HotMoviesLoaded extends HotState {
  final List<MovieEntity> movies;
  HotMoviesLoaded({required this.movies});
}

class FailureLoadHotMovies extends HotState {
  final String errorMessage;
  FailureLoadHotMovies({required this.errorMessage});
}
