import 'package:app_movie/domain/movie/entities/movie.dart';

abstract class MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<MovieEntity> movies;
  MoviesLoaded({required this.movies});
}

class FailureLoadMovies extends MoviesState {
  final String errorMessage;
  FailureLoadMovies({required this.errorMessage});
}
