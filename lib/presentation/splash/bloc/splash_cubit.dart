import 'package:app_movie/domain/auth/usecases/is_logged_in.dart';
import 'package:app_movie/presentation/splash/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  void appStarted() async {
    await Future.delayed(const Duration(seconds: 2));

    try {
      var isLoggedIn = await IsLoggedInUseCase().call();

      if (isLoggedIn) {
        emit(Authenticated());
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(UnAuthenticated());
    }
  }
}
