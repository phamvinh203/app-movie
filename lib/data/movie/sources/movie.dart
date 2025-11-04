import 'package:app_movie/core/constants/api_url.dart';
import 'package:app_movie/core/network/dio_client.dart';
import 'package:app_movie/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class MovieService {
  Future<Either> getBannerMovies();
}

class MovieApiServiceImpl extends MovieService {
  @override
  Future<Either> getBannerMovies() async {
    try {
      var response = await sl<DioClient>().get(ApiUrl.bannerMovies);
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.message);
    }
  }
  
  
}
