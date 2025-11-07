import 'package:app_movie/domain/movie/entities/movie.dart';

class MovieHelper {
  /// 🔹 Tính điểm hot cho phim (voteAverage * voteCount)
  static double _calculateHotScore(MovieItemEntity item) {
    final rating = item.voteAverage ?? 0;
    final count = item.voteCount ?? 0;
    return rating * count;
  }

  /// 🔹 Gộp phim từ nhiều trang
  static List<MovieItemEntity> mergeMovies(List<MovieEntity> pages) {
    return pages.expand((page) => page.items).toList();
  }

  /// 🎬 Lấy phim cho Banner
  /// - Lọc phim có poster
  /// - Ưu tiên phim mới cập nhật gần đây
  /// - Ưu tiên rating cao
  static List<MovieItemEntity> getBannerMovies(
    List<MovieEntity> pages, {
    int limit = 5,
  }) {
    final allMovies = mergeMovies(pages);

    // Lọc phim hợp lệ
    final filtered = allMovies.where((m) {
      return (m.posterUrl?.isNotEmpty ?? false) &&
          (m.name?.isNotEmpty ?? false);
    }).toList();

    // Sắp xếp theo: thời gian cập nhật -> voteAverage giảm dần
    filtered.sort((a, b) {
      final dateA = a.modified?.time ?? DateTime(1970);
      final dateB = b.modified?.time ?? DateTime(1970);

      // Mới cập nhật hơn lên đầu, nếu bằng thì so rating
      final compareDate = dateB.compareTo(dateA);
      if (compareDate != 0) return compareDate;

      return (b.voteAverage ?? 0).compareTo(a.voteAverage ?? 0);
    });

    return filtered.take(limit).toList();
  }

  /// 🔥 Lấy danh sách phim hot
  /// - Gộp phim từ nhiều trang
  /// - Sắp xếp theo hotScore giảm dần
  /// - Ưu tiên phim cập nhật gần đây hơn khi hotScore bằng nhau
  static List<MovieItemEntity> getHotMovies(
    List<MovieEntity> pages, {
    int limit = 10,
  }) {
    final allMovies = mergeMovies(pages);

    allMovies.sort((a, b) {
      final hotA = _calculateHotScore(a);
      final hotB = _calculateHotScore(b);

      final cmp = hotB.compareTo(hotA);
      if (cmp != 0) return cmp;

      final dateA = a.modified?.time ?? DateTime(1970);
      final dateB = b.modified?.time ?? DateTime(1970);

      return dateB.compareTo(dateA);
    });

    return allMovies.take(limit).toList();
  }
}
