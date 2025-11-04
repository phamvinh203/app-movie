import 'package:app_movie/common/mapper/movie_mapper.dart';
import 'package:app_movie/data/movie/models/movie.dart';
import 'package:app_movie/data/movie/sources/movie.dart';
import 'package:app_movie/domain/movie/repositories/movie.dart';
import 'package:app_movie/service_locator.dart';
import 'package:dartz/dartz.dart';

class MovieRepositoryImpl extends MovieRepository {
  @override
  Future<Either> getBannerMovies() async {
    var result = await sl<MovieService>().getBannerMovies();
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) {

        var movieModel = MovieModel.fromJson(data);
        // Map the model to entity
        var movie = MovieMapper.toEntity(movieModel);
        return Right([movie]);
      },
    );
  }
  
  
}
