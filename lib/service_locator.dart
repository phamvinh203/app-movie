import 'package:app_movie/core/network/dio_client.dart';
import 'package:app_movie/data/auth/repositories/auth.dart';
import 'package:app_movie/data/auth/sources/auth_api_service.dart';
import 'package:app_movie/domain/auth/repositories/auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Network
  sl.registerSingleton<DioClient>(DioClient());

  // Auth Services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());

  // Auth Repository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
}
