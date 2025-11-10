import 'package:app_movie/domain/movie/entities/movie.dart';

class MovieHelper {
  // ==================== PRIVATE HELPERS ====================
  
  /// Tính điểm hot (rating × số vote)
  static double _hotScore(MovieItemEntity movie) {
    return (movie.voteAverage ?? 0) * (movie.voteCount ?? 0);
  }

  /// Gộp phim từ nhiều trang
  static List<MovieItemEntity> mergeMovies(List<MovieEntity> pages) {
    return pages.expand((page) => page.items).toList();
  }

  // ==================== PUBLIC METHODS ====================

  /// Lấy phim cho Banner
  /// - Ưu tiên phim mới cập nhật gần đây
  /// - Ưu tiên rating cao
  static List<MovieItemEntity> getBannerMovies(
    List<MovieEntity> pages, {
    int limit = 5,
  }) {
    final allMovies = mergeMovies(pages);
    
    allMovies.sort((a, b) {
      final dateA = a.modified?.time ?? DateTime(1970);
      final dateB = b.modified?.time ?? DateTime(1970);

      final compareDate = dateB.compareTo(dateA);
      if (compareDate != 0) return compareDate;

      return (b.voteAverage ?? 0).compareTo(a.voteAverage ?? 0);
    });
    
    return allMovies.take(limit).toList();
  }

  /// Lấy danh sách phim hot
  /// - Sắp xếp theo hotScore giảm dần
  /// - Ưu tiên phim cập nhật gần đây hơn khi hotScore bằng nhau
  static List<MovieItemEntity> getHotMovies(
    List<MovieEntity> pages, {
    int limit = 10,
  }) {
    final allMovies = mergeMovies(pages);

    allMovies.sort((a, b) {
      final hotA = _hotScore(a);
      final hotB = _hotScore(b);

      final cmp = hotB.compareTo(hotA);
      if (cmp != 0) return cmp;

      final dateA = a.modified?.time ?? DateTime(1970);
      final dateB = b.modified?.time ?? DateTime(1970);

      return dateB.compareTo(dateA);
    });

    return allMovies.take(limit).toList();
  }

  /// Lấy danh sách phim đề xuất
  /// - Giới hạn số lượng kết quả
  static List<MovieItemEntity> getRecommendMovies(
    List<MovieItemEntity> movies, {
    int limit = 10,
  }) {
    return movies.take(limit).toList();
  }

  /// Lấy danh sách phim theo typelist
  /// - Giới hạn số lượng kết quả
  static List<MovieItemEntity> getMoviesByType(
    List<MovieItemEntity> movies,
    String typeList, {
    int limit = 10,
  }) {
    return movies.take(limit).toList();
  }
}