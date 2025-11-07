import 'package:app_movie/domain/movie/usecases/get_banner_movies.dart';
import 'package:app_movie/presentation/home/bloc/banner_state.dart';
import 'package:app_movie/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit() : super(BannerMoviesLoading());

  int _page = 1;

  void getBannerMovies({bool loadMore = false}) async {
    if (!loadMore) emit(BannerMoviesLoading());
    var moviesData = await sl<GetBannerMoviesUseCase>().call(params: _page);
    moviesData.fold(
      (error) => emit(FailureLoadBannerMovies(errorMessage: error.toString())),
      (data) {
        if (loadMore && state is BannerMoviesLoaded) {
          final current = (state as BannerMoviesLoaded).movies;
          emit(BannerMoviesLoaded(movies: [...current, ...data]));
        } else {
          emit(BannerMoviesLoaded(movies: data));
        }
        _page++;
      },
    );
  }
}
