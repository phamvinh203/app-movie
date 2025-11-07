import 'package:app_movie/common/helper/movie_helper.dart';
import 'package:app_movie/domain/movie/entities/movie.dart';
import 'package:app_movie/presentation/home/bloc/banner_cubit.dart';
import 'package:app_movie/presentation/home/bloc/banner_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerMovies extends StatefulWidget {
  const BannerMovies({super.key});

  @override
  State<BannerMovies> createState() => _BannerMoviesState();
}

class _BannerMoviesState extends State<BannerMovies> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9, initialPage: 0);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted && _pageController.hasClients) {
        final nextPage = (_currentPage + 1);
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _startAutoScroll();
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
            return const SizedBox(
              height: 380,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            );
          }

          if (state is BannerMoviesLoaded) {
            final bannerMovies = MovieHelper.getBannerMovies(
              state.movies,
              limit: 5,
            );

            if (bannerMovies.isEmpty) {
              return const Center(child: Text('Không có phim nào.'));
            }

            return Column(
              children: [
                // 🎬 PageView Banner
                SizedBox(
                  height: 420,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index % bannerMovies.length;
                      });
                    },
                    itemBuilder: (context, index) {
                      final movie = bannerMovies[index % bannerMovies.length];
                      return _buildBannerItem(movie);
                    },
                  ),
                ),

                const SizedBox(height: 12),

                // Dots Indicator
                _buildDotsIndicator(bannerMovies.length),

                const SizedBox(height: 8),
              ],
            );
          }

          if (state is FailureLoadBannerMovies) {
            return Center(child: Text('Lỗi: ${state.errorMessage}'));
          }

          return Container();
        },
      ),
    );
  }

  /// Banner Item Widget
  Widget _buildBannerItem(MovieItemEntity movie) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: GestureDetector(
        onTap: () {
          debugPrint('Tapped on banner: ${movie.name}');
          // TODO: Navigate to movie detail
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                //  Background Image
                Image.network(
                  movie.posterUrl ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[800],
                      child: const Icon(
                        Icons.broken_image,
                        size: 60,
                        color: Colors.white,
                      ),
                    );
                  },
                ),

                //  Gradient Overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                      stops: const [0.5, 1.0],
                    ),
                  ),
                ),

                //  Movie Info
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Quality + Year badges
                        Row(
                          children: [
                            if (movie.quality != null &&
                                movie.quality!.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  movie.quality!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            const SizedBox(width: 8),
                            if (movie.year != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '${movie.year}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // Movie Name
                        Text(
                          movie.name ?? 'No title',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(0, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 6),

                        // Origin Name + Lang
                        if (movie.originName != null || movie.lang != null)
                          Text(
                            [
                              if (movie.originName != null) movie.originName,
                              if (movie.lang != null) movie.lang,
                            ].where((e) => e != null).join(' • '),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 13,
                            ),
                          ),

                        const SizedBox(height: 8),

                        // Categories
                        if (movie.category.isNotEmpty)
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: movie.category
                                .take(3)
                                .map(
                                  (cat) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                    ),
                                    child: Text(
                                      cat.name ?? '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Dots Indicator
  Widget _buildDotsIndicator(int itemCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? Colors.redAccent : Colors.grey[600],
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
