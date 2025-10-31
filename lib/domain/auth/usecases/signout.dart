import 'package:app_movie/core/usecase/usecase.dart';
import 'package:app_movie/domain/auth/repositories/auth.dart';
import 'package:app_movie/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:app_movie/core/error/failure.dart';

class SignOutUseCase extends UseCase<Either<Failure, String>, dynamic> {
  @override
  Future<Either<Failure, String>> call({params}) async {
    return await sl<AuthRepository>().signOut();
  }
}
