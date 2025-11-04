class MovieEntity {
  final bool? status;
  final String? msg;
  final List<MovieItemEntity> items;
  final PaginationEntity? pagination;

  MovieEntity({
    required this.status,
    required this.msg,
    this.items = const [],
    this.pagination,
  });
}

class MovieItemEntity {
  final String? id;
  final String? name;
  final String? slug;
  final String? originName;
  final String? posterUrl;
  final String? thumbUrl;
  final int? year;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  MovieItemEntity({
    required this.id,
    required this.name,
    this.slug,
    required this.originName,
    required this.posterUrl,
    required this.thumbUrl,
    required this.year,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });
}

class PaginationEntity {
  final int? totalItems;
  final int? totalItemsPerPage;
  final int? currentPage;
  final int? totalPages;

  PaginationEntity({
    required this.totalItems,
    required this.totalItemsPerPage,
    required this.currentPage,
    required this.totalPages,
  });
}
