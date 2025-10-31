import 'package:app_movie/data/auth/models/signin_req_params.dart';
import 'package:app_movie/data/auth/models/signup_req_params.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_movie/core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signUp(SignupReqParams params);
  Future<Either<Failure, User>> signIn(SigninReqParams params);
  Future<bool> isLoggedIn();
  Future<Either<Failure, String>> signOut();
}
