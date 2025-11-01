import 'package:app_movie/core/constants/api_url.dart';
import 'package:app_movie/core/network/dio_client.dart';
import 'package:app_movie/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class MovieService {
  Future<Either> getTrendingMovies();
}

class MovieApiServiceImpl extends MovieService {
  @override
  Future<Either> getTrendingMovies() async{
    try {
      var response = await sl<DioClient>().get(
        ApiUrl.latestMovies,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.message);
    }
  }
}