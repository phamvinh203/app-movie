import 'package:app_movie/common/helper/movie_helper.dart';
import 'package:app_movie/presentation/home/bloc/movie_cubit.dart';
import 'package:app_movie/presentation/home/bloc/movie_state.dart';
import 'package:app_movie/presentation/home/widget/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendMovies extends StatelessWidget {
  const RecommendMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesCubit()..getMovies(),
      child: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoading) {
            return const SizedBox(
              height: 250,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            );
          }

          if (state is MoviesLoaded) {
            // Sử dụng helper để lọc & xử lý dữ liệu
            final recommendMovies = MovieHelper.getRecommendMovies(
              state.movies,
              limit: 10,
            );

            if (recommendMovies.isEmpty) {
              return const Center(child: Text("Không có phim đề xuất."));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🎬 Tiêu đề
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.recommend,
                            color: Colors.blueAccent,
                            size: 26,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Đề xuất cho bạn',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // 👉 Nút "Xem thêm" bên phải
                      GestureDetector(
                        onTap: () {
                          debugPrint('Xem thêm phim hot');
                          // TODO: điều hướng tới màn hình danh sách phim hot
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

                //  Danh sách phim đề xuất
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: recommendMovies.length,
                    itemBuilder: (context, index) {
                      final movie = recommendMovies[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: MovieCard(
                          movie: movie,
                          index: index,
                          width: 140,
                          height: 250,
                          onTap: () {
                            debugPrint('Tapped on: ${movie.name}');
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Đã xảy ra lỗi khi tải phim đề xuất."),
            );
          }
        },
      ),
    );
  }
}
