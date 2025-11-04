import 'package:app_movie/domain/movie/usecases/get_banner_movies.dart';
import 'package:app_movie/presentation/home/bloc/banner_state.dart';
import 'package:app_movie/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit() : super(BannerMoviesLoading());

  void getBannerMovies() async {
    var moviesData = await sl<GetBannerMoviesUseCase>().call();
    moviesData.fold(
      (error) {
        emit(FailureLoadBannerMovies(errorMessage: error.toString()));
      },
      (data) {
        emit(BannerMoviesLoaded(movies: data));
      },
    );
  }
}
