import 'package:app_movie/core/constants/api_url.dart';
import 'package:app_movie/core/network/dio_client.dart';
import 'package:app_movie/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class MovieService {
  Future<Either> getBannerMovies({int page = 1});
  Future<Either> getHotMovies({int page = 1});
  Future<Either> getMovies({int page = 1});
  Future<Either> getMoviesByType({required String typeList, int page = 1});
}

class MovieApiServiceImpl extends MovieService {
  @override
  Future<Either> getBannerMovies({int page = 1}) async {
    try {
      final response = await sl<DioClient>().get(
        '${ApiUrl.bannerMovies}?page=$page',
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either> getHotMovies({int page = 1}) async {
    try {
      final response = await sl<DioClient>().get(
        '${ApiUrl.hotMovies}?page=$page',
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either> getMovies({int page = 1}) async {
    try {
      final response = await sl<DioClient>().get(
        '${ApiUrl.latestMovies}?page=$page',
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either> getMoviesByType({
    required String typeList,
    int page = 1,
  }) async {
    try {
      final url = ApiUrl.movieList.replaceFirst('{type_list}', typeList);
      final response = await sl<DioClient>().get('$url?page=$page');
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.message);
    }
  }
}
