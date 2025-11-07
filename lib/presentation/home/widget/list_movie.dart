import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_movie/core/constants/api_url.dart';
import 'package:app_movie/presentation/home/bloc/movie_cubit.dart';
import 'package:app_movie/presentation/home/bloc/movie_state.dart';
import 'package:app_movie/presentation/home/widget/movie_card.dart';

class ListMovie extends StatefulWidget {
  const ListMovie({super.key});

  @override
  State<ListMovie> createState() => _ListMovieState();
}

class _ListMovieState extends State<ListMovie> {
  late final Map<String, _MovieTypeData> movieTypes;

  @override
  void initState() {
    super.initState();
    movieTypes = {
      'Phim Bộ': _MovieTypeData(
        typeList: ApiUrl.typePhimBo,
        cubit: MoviesCubit(),
      ),
      'Phim Lẻ': _MovieTypeData(
        typeList: ApiUrl.typePhimLe,
        cubit: MoviesCubit(),
      ),
      'TV Shows': _MovieTypeData(
        typeList: ApiUrl.typeTvShows,
        cubit: MoviesCubit(),
      ),
      'Hoạt Hình': _MovieTypeData(
        typeList: ApiUrl.typeHoatHinh,
        cubit: MoviesCubit(),
      ),
      'Phim Vietsub': _MovieTypeData(
        typeList: ApiUrl.typePhimVietsub,
        cubit: MoviesCubit(),
      ),
      'Phim Thuyết Minh': _MovieTypeData(
        typeList: ApiUrl.typePhimThuyetMinh,
        cubit: MoviesCubit(),
      ),
      'Phim Lồng Tiếng': _MovieTypeData(
        typeList: ApiUrl.typePhimLongTieng,
        cubit: MoviesCubit(),
      ),
    };

    // Load movies for each type
    for (var data in movieTypes.values) {
      _loadMoviesByType(data);
    }
  }

  void _loadMoviesByType(_MovieTypeData data) async {
    data.cubit.getMoviesByType(typeList: data.typeList, page: 1);
  }

  @override
  void dispose() {
    for (var data in movieTypes.values) {
      data.cubit.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...movieTypes.entries.map(
            (entry) => _buildMovieSection(
              title: entry.key,
              cubit: entry.value.cubit,
              typeList: entry.value.typeList,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieSection({
    required String title,
    required MoviesCubit cubit,
    required String typeList,
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
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Navigate to full list page
                  debugPrint('Xem thêm phim $typeList');
                },
                child: Text(
                  'Xem thêm',
                  style: TextStyle(
                    fontSize: 12,
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
              // Lấy danh sách phim từ state
              final movies = state.movies.isNotEmpty
                  ? state.movies.first.items.take(10).toList()
                  : [];

              if (movies.isEmpty) {
                return SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(
                      'Không có phim $title',
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

class _MovieTypeData {
  final String typeList;
  final MoviesCubit cubit;

  _MovieTypeData({required this.typeList, required this.cubit});
}
