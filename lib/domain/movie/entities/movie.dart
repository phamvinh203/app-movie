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
  final ModifiedEntity? modified;
  final String? episodeCurrent;
  final String? quality;
  final String? lang;
  final List<CategoryEntity> category;
  final List<CategoryEntity> country;

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
    this.modified,
    this.episodeCurrent,
    this.quality,
    this.lang,
    this.category = const [],
    this.country = const [],
  });
}

class CategoryEntity {
  final String? id;
  final String? name;
  final String? slug;

  CategoryEntity({required this.id, required this.name, required this.slug});
}

class ModifiedEntity {
  final DateTime? time;

  ModifiedEntity({required this.time});
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
