import 'package:app_movie/core/usecase/usecase.dart';
import 'package:app_movie/domain/movie/repositories/movie.dart';
import 'package:app_movie/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetTrendingMoviesUseCase extends UseCase<Either, dynamic>{

  @override
  Future<Either> call({params}) async {
    return await sl<MovieRepository>().getTrendingMovies();
  }
}