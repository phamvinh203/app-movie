import 'package:app_movie/data/auth/models/signin_req_params.dart';
import 'package:app_movie/data/auth/models/signup_req_params.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either> signUp(SignupReqParams params);
  Future<Either> signIn(SigninReqParams params);
  Future<bool> isLoggedIn();
  Future<Either> signOut();
}