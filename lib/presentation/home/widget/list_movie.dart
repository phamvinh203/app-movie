import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_movie/common/helper/movie_helper.dart';
import 'package:app_movie/common/utils/movie_type.dart';
import 'package:app_movie/presentation/home/bloc/movie_cubit.dart';
import 'package:app_movie/presentation/home/bloc/movie_state.dart';
import 'package:app_movie/presentation/home/widget/movie_card.dart';

class ListMovie extends StatefulWidget {
  const ListMovie({super.key});

  @override
  State<ListMovie> createState() => _ListMovieState();
}

class _ListMovieState extends State<ListMovie> {
  late final Map<MovieTypeConfig, MoviesCubit> _movieCubits;

  @override
  void initState() {
    super.initState();
    // Khởi tạo Cubit cho mỗi loại phim
    _movieCubits = {
      for (var config in movieTypesList)
        config: MoviesCubit()
          ..getMoviesByType(typeList: config.typeList, page: 1),
    };
  }

  @override
  void dispose() {
    // Đóng tất cả Cubit
    for (var cubit in _movieCubits.values) {
      cubit.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...movieTypesList.map(
            (config) => _buildMovieSection(
              config: config,
              cubit: _movieCubits[config]!,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieSection({
    required MovieTypeConfig config,
    required MoviesCubit cubit,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header với tiêu đề
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                config.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to full list page
                  debugPrint('Xem thêm phim ${config.typeList}');
                },
                child: Text(
                  'Xem thêm',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Movie list
        BlocBuilder<MoviesCubit, MoviesState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is MoviesLoading) {
              return _buildLoadingShimmer();
            } else if (state is MoviesLoaded) {
              // Sử dụng helper để lọc & xử lý dữ liệu
              final movies = MovieHelper.getMoviesByType(
                state.movies,
                config.typeList,
                limit: 10,
              );

              if (movies.isEmpty) {
                return SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(
                      'Không có phim ${config.title}',
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                );
              }

              return SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: MovieCard(
                        movie: movies[index],
                        index: index,
                        onTap: () {
                          // TODO: Navigate to movie detail
                          debugPrint('Tapped on: ${movies[index].name}');
                        },
                        width: 150,
                        height: 280,
                      ),
                    );
                  },
                ),
              );
            } else if (state is FailureLoadMovies) {
              return SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Lỗi: ${state.errorMessage}',
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildLoadingShimmer() {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              width: 150,
              height: 280,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
      ),
    );
  }
}
