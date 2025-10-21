import 'package:app_movie/data/auth/models/signin_req_params.dart';
import 'package:app_movie/data/auth/models/signup_req_params.dart';
import 'package:app_movie/data/auth/sources/auth_api_service.dart';
import 'package:app_movie/domain/auth/repositories/auth.dart';
import 'package:app_movie/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signUp(SignupReqParams params) async {
    try {
      var user = await sl<AuthApiService>().signUp(
        params.email,
        params.password,
      );
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> signIn(SigninReqParams params) async {
    try {
      var user = await sl<AuthApiService>().signIn(
        params.email,
        params.password,
      );
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> signOut() async {
    try {
      await sl<AuthApiService>().signOut();
      return const Right('Signed out successfully');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      return user != null;
    } catch (e) {
      return false;
    }
  }
}
