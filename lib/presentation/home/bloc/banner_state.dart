import 'package:app_movie/domain/movie/entities/movie.dart';

abstract class BannerState {}

class BannerMoviesLoading extends BannerState {}

class BannerMoviesLoaded extends BannerState {
  final List<MovieEntity> movies;
  BannerMoviesLoaded({required this.movies});
}

class FailureLoadBannerMovies extends BannerState {
  final String errorMessage;
  FailureLoadBannerMovies({required this.errorMessage});
}