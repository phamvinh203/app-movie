import 'package:app_movie/core/usecase/usecase.dart';
import 'package:app_movie/domain/movie/repositories/movie.dart';
import 'package:app_movie/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetMoviesUseCase extends UseCase<Either, int>{

  @override
  Future<Either> call({int? params}) async {
    final page = params ?? 1;
    return await sl<MovieRepository>().getMovies(page: page);
  }
}

