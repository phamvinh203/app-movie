import 'package:app_movie/core/usecase/usecase.dart';
import 'package:app_movie/data/auth/models/signin_req_params.dart';
import 'package:app_movie/domain/auth/repositories/auth.dart';
import 'package:app_movie/service_locator.dart';
import 'package:dartz/dartz.dart';


class SigninUseCase extends UseCase<Either,SigninReqParams> {
  
  @override
  Future<Either> call({SigninReqParams? params}) async {
    return await sl<AuthRepository>().signIn(params!);
  }
  
}