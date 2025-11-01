import 'package:app_movie/presentation/home/bloc/trending_cubit.dart';
import 'package:app_movie/presentation/home/bloc/trending_state.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrendingMovies extends StatelessWidget {
  const TrendingMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrendingCubit()..getTrendingMovies(),
      child: BlocBuilder<TrendingCubit, TrendingState>(
        builder: (context, state) {
          if (state is TrendingMoviesLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is TrendingMoviesLoaded) {
            final imageLinks = state.movies
                .expand((movie) => movie.items)
                .map((item) => item.posterUrl ?? '')
                .where((url) => url.isNotEmpty) // loại bỏ link rỗng
                .toList();

            if (imageLinks.isEmpty) {
              return const Center(child: Text('Không có hình ảnh nào.'));
            }

            return FanCarouselImageSlider.sliderType1(
              imagesLink: imageLinks,
              isAssets: false,
              autoPlay: true,
              sliderHeight: 400,
              showIndicator: true,
            );
          }

          if (state is FailureLoadTrendingMovies) {
            return Text('Error: ${state.errorMessage}');
          }

          return Container();
        },
      ),
    );
  }
}
