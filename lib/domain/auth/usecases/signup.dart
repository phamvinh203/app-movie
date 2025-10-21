import 'package:app_movie/core/usecase/usecase.dart';
import 'package:app_movie/data/auth/models/signup_req_params.dart';
import 'package:app_movie/domain/auth/repositories/auth.dart';
import 'package:app_movie/service_locator.dart';
import 'package:dartz/dartz.dart';


class SignupUseCase extends UseCase<Either,SignupReqParams> {
  
  @override
  Future<Either> call({SignupReqParams? params}) async {
    return await sl<AuthRepository>().signUp(params!);
  }
  
}