import 'package:app_movie/core/usecase/usecase.dart';
import 'package:app_movie/domain/movie/repositories/movie.dart';
import 'package:app_movie/service_locator.dart';
import 'package:dartz/dartz.dart';

class GetMoviesByTypeParams {
  final String typeList;
  final int page;

  GetMoviesByTypeParams({required this.typeList, this.page = 1});
}

class GetMoviesByTypeUseCase extends UseCase<Either, GetMoviesByTypeParams> {
  @override
  Future<Either> call({GetMoviesByTypeParams? params}) async {
    final typeList = params?.typeList ?? '';
    final page = params?.page ?? 1;
    return await sl<MovieRepository>().getMoviesByType(
      typeList: typeList,
      page: page,
    );
  }
}
