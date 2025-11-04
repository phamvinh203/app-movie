import 'package:app_movie/presentation/home/bloc/banner_cubit.dart';
import 'package:app_movie/presentation/home/bloc/banner_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';

class BannerMovies extends StatefulWidget {
  const BannerMovies({super.key});

  @override
  State<BannerMovies> createState() => _BannerMoviesState();
}

class _BannerMoviesState extends State<BannerMovies> {
  late PageController _pageController;


  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.95);
    _autoScroll();
  }

  void _autoScroll() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted && _pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
        _autoScroll();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BannerCubit()..getBannerMovies(),
      child: BlocBuilder<BannerCubit, BannerState>(
        builder: (context, state) {
          if (state is BannerMoviesLoading) {
            return SizedBox(
              height: 380,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            );
          }

          
          if (state is BannerMoviesLoaded) {
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
          return Container();
        },
      ),
    );
  }
}
