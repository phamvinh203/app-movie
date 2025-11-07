import 'package:app_movie/common/helper/movie_helper.dart';
import 'package:app_movie/presentation/home/bloc/hot_cubit.dart';
import 'package:app_movie/presentation/home/bloc/hot_state.dart';
import 'package:app_movie/presentation/home/widget/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotMovies extends StatelessWidget {
  const HotMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HotCubit()..getHotMovies(),
      child: BlocBuilder<HotCubit, HotState>(
        builder: (context, state) {
          if (state is HotMoviesLoading) {
            return const SizedBox(
              height: 250,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            );
          }

          if (state is HotMoviesLoaded) {
            final hotMovies = MovieHelper.getHotMovies(state.movies, limit: 10);

            if (hotMovies.isEmpty) {
              return const Center(child: Text("Không có phim nổi bật."));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔥 Tiêu đề
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.local_fire_department,
                            color: Colors.redAccent,
                            size: 26,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Đề xuất Hot',
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
                        child: const Text(
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

                // Danh sách phim
                SizedBox(
                  height: 350,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: hotMovies.length,
                    itemBuilder: (context, index) {
                      final item = hotMovies[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: MovieCard(
                          movie: item,
                          width: 160,
                          height: 350,
                          onTap: () {
                            // 👉 Sau này bạn có thể mở modal chi tiết phim ở đây
                            debugPrint('Tapped on: ${item.name}');
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          if (state is FailureLoadHotMovies) {
            return Center(child: Text('Lỗi: ${state.errorMessage}'));
          }

          return Container();
        },
      ),
    );
  }
}
