
import 'package:app_movie/presentation/home/widget/banner_movies.dart';
import 'package:app_movie/presentation/home/widget/hot_movie.dart';
import 'package:app_movie/presentation/home/widget/list_movie.dart';
import 'package:app_movie/presentation/home/widget/recommend_movies.dart';
import 'package:flutter/material.dart';
import 'package:app_movie/core/configs/theme/app_colors.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Movie',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              TextSpan(
                text: 'Zone',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BannerMovies(),
            HotMovies(),
            RecommendMovies(),
            ListMovie()
          ],
        ),
      ),
    );
  }
}
