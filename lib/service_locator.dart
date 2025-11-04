import 'package:app_movie/core/network/dio_client.dart';
import 'package:app_movie/data/auth/repositories/auth.dart';
import 'package:app_movie/data/auth/sources/auth_api_service.dart';
import 'package:app_movie/data/movie/repositories/movie.dart';
import 'package:app_movie/data/movie/sources/movie.dart';
import 'package:app_movie/domain/auth/repositories/auth.dart';
import 'package:app_movie/domain/movie/repositories/movie.dart';
import 'package:app_movie/domain/movie/usecases/get_banner_movies.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Network
  sl.registerSingleton<DioClient>(DioClient());

  // Auth Services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<MovieService>(MovieApiServiceImpl());

  // Auth Repository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<MovieRepository>(MovieRepositoryImpl());

  // Use Cases
  sl.registerSingleton<GetBannerMoviesUseCase>(GetBannerMoviesUseCase());

}
