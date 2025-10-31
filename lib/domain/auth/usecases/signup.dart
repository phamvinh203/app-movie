import 'package:app_movie/core/usecase/usecase.dart';
import 'package:app_movie/data/auth/models/signup_req_params.dart';
import 'package:app_movie/domain/auth/repositories/auth.dart';
import 'package:app_movie/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:app_movie/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupUseCase extends UseCase<Either<Failure, User>, SignupReqParams> {
  @override
  Future<Either<Failure, User>> call({SignupReqParams? params}) async {
    return await sl<AuthRepository>().signUp(params!);
  }
}
