import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either> getBannerMovies({int page = 1});
  Future<Either> getHotMovies({int page = 1});
  Future<Either> getMovies({int page = 1});
  Future<Either> getMoviesByType({required String typeList, int page = 1});
}
