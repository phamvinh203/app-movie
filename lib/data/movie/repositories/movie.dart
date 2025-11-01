import 'package:app_movie/common/mapper/movie_mapper.dart';
import 'package:app_movie/data/movie/models/movie.dart';
import 'package:app_movie/data/movie/sources/movie.dart';
import 'package:app_movie/domain/movie/repositories/movie.dart';
import 'package:app_movie/service_locator.dart';
import 'package:dartz/dartz.dart';

class MovieRepositoryImpl extends MovieRepository {
  @override
  Future<Either> getTrendingMovies() async {
    var result = await sl<MovieService>().getTrendingMovies();
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) {
        // Parse the entire API response (status, msg, items, pagination) into MovieModel
        var movieModel = MovieModel.fromJson(data);
        // Map the model to entity
        var movie = MovieMapper.toEntity(movieModel);
        // Return a list containing the single movie entity (because TrendingState expects List<MovieEntity>)
        return Right([movie]);
      },
    );
  }
}
