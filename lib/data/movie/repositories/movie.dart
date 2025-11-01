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
        var movies = List.from(data['items'])
            .map((item) => MovieMapper.toEntity(MovieModel.fromJson(item)))
            .toList();
        return Right(movies);
      },
    );
  }
}
