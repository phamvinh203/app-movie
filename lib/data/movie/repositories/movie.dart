import 'package:app_movie/common/mapper/movie_mapper.dart';
import 'package:app_movie/data/movie/models/movie.dart';
import 'package:app_movie/data/movie/sources/movie.dart';
import 'package:app_movie/domain/movie/repositories/movie.dart';
import 'package:app_movie/service_locator.dart';
import 'package:dartz/dartz.dart';

class MovieRepositoryImpl extends MovieRepository {
  @override
  Future<Either> getBannerMovies({int page = 1}) async {
    var result = await sl<MovieService>().getBannerMovies(page: page);
    return result.fold((error) => Left(error), (data) {
      final movieModel = MovieModel.fromJson(data);
      // Map the model to entity
      final movie = MovieMapper.toEntity(movieModel);
      return Right([movie]);
    });
  }

  @override
  Future<Either> getHotMovies({int page = 1}) async {
    var result = await sl<MovieService>().getHotMovies(page: page);
    return result.fold((error) => Left(error), (data) {
      final movieModel = MovieModel.fromJson(data);
      // Map the model to entity
      final movie = MovieMapper.toEntity(movieModel);
      return Right([movie]);
    });
  }

  @override
  Future<Either> getMovies({int page = 1}) async {
    // Implementation for getting general movies
    var result = await sl<MovieService>().getMovies(page: page);
    return result.fold((error) => Left(error), (data) {
      final movieModel = MovieModel.fromJson(data);
      // Map the model to entity
      final movie = MovieMapper.toEntity(movieModel);
      return Right([movie]);
    });
  }

  @override
  Future<Either> getMoviesByType({
    required String typeList,
    int page = 1,
  }) async {
    var result = await sl<MovieService>().getMoviesByType(
      typeList: typeList,
      page: page,
    );
    return result.fold((error) => Left(error), (data) {
      final responseData = data['data'] ?? data;

      // Parse items từ data
      final items = responseData['items'] ?? [];

      final movieData = {
        'items': items,
      };

      final movieModel = MovieModel.fromJson(movieData);
      // Map the model to entity
      final movie = MovieMapper.toEntity(movieModel);
      return Right([movie]);
    });
  }
}
