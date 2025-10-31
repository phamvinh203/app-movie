import 'package:app_movie/data/auth/models/signin_req_params.dart';
import 'package:app_movie/data/auth/models/signup_req_params.dart';
import 'package:app_movie/domain/auth/usecases/signin.dart';
import 'package:app_movie/domain/auth/usecases/signup.dart';
import 'package:app_movie/presentation/auth/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signUp(SignupReqParams params) async {
    emit(AuthLoading());

    // Validate password match
    if (params.password != params.confirmPassword) {
      emit(AuthFailure(errorMessage: 'Mật khẩu không khớp'));
      return;
    }

    // Validate password length
    if (params.password.length < 6) {
      emit(AuthFailure(errorMessage: 'Mật khẩu phải có ít nhất 6 ký tự'));
      return;
    }

    // Validate email
    if (!_isValidEmail(params.email)) {
      emit(AuthFailure(errorMessage: 'Vui lòng nhập địa chỉ email hợp lệ'));
      return;
    }

    try {
      var result = await SignupUseCase().call(params: params);

      result.fold(
        (error) {
          emit(AuthFailure(errorMessage: error.message));
        },
        (success) {
          emit(
            AuthSuccess(
              message: 'Tài khoản đã được tạo thành công! Vui lòng đăng nhập.',
            ),
          );
        },
      );
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  void signIn(SigninReqParams params) async {
    emit(AuthLoading());

    // Validate email
    if (!_isValidEmail(params.email)) {
      emit(AuthFailure(errorMessage: 'Vui lòng nhập địa chỉ email hợp lệ'));
      return;
    }

    // Validate password
    if (params.password.isEmpty) {
      emit(AuthFailure(errorMessage: 'Mật khẩu không được để trống'));
      return;
    }

    try {
      var result = await SigninUseCase().call(params: params);

      result.fold(
        (error) {
          emit(AuthFailure(errorMessage: error.message));
        },
        (success) {
          emit(AuthSuccess(message: 'Đăng nhập thành công!'));
        },
      );
    } catch (e) {
      emit(AuthFailure(errorMessage: e.toString()));
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
}
