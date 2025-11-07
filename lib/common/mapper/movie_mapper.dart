import 'package:app_movie/data/movie/models/movie.dart';
import 'package:app_movie/domain/movie/entities/movie.dart';

class MovieMapper {
  static MovieEntity toEntity(MovieModel movie) {
    return MovieEntity(
      status: movie.status,
      msg: movie.msg,
      items: movie.items.map((item) => _mapMovieItem(item)).toList(),
      pagination: movie.pagination != null
          ? _mapPagination(movie.pagination!)
          : null,
    );
  }

  static MovieItemEntity _mapMovieItem(MovieItem item) {
    return MovieItemEntity(
      id: item.id,
      name: item.name,
      slug: item.slug,
      originName: item.originName,
      posterUrl: item.posterUrl,
      thumbUrl: item.thumbUrl,
      year: item.year,
      type: item.tmdb?.type,
      voteAverage: item.tmdb?.voteAverage,
      voteCount: item.tmdb?.voteCount,
      modified: item.modified != null
          ? ModifiedEntity(time: item.modified!.time)
          : null,
      episodeCurrent: item.episodeCurrent,
      quality: item.quality,
      lang: item.lang,
      category: item.category.map((cat) => _mapCategory(cat)).toList(),
      country: item.country.map((country) => _mapCategory(country)).toList(),
    );
  }

  static CategoryEntity _mapCategory(Category category) {
    return CategoryEntity(
      id: category.id,
      name: category.name,
      slug: category.slug,
    );
  }

  static PaginationEntity _mapPagination(Pagination pagination) {
    return PaginationEntity(
      totalItems: pagination.totalItems,
      totalItemsPerPage: pagination.totalItemsPerPage,
      currentPage: pagination.currentPage,
      totalPages: pagination.totalPages,
    );
  }
}
