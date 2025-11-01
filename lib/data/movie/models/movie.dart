class MovieModel {
  final bool? status;
  final String? msg;
  final List<MovieItem> items;
  final Pagination? pagination;

  MovieModel({
    required this.status,
    required this.msg,
    required this.items,
    required this.pagination,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      status: json["status"],
      msg: json["msg"],
      items: (json["items"] as List?)
              ?.map((x) => MovieItem.fromJson(x))
              .toList() ??
          [],
      pagination: json["pagination"] == null
          ? null
          : Pagination.fromJson(json["pagination"]),
    );
  }
}

class MovieItem {
  final Tmdb? tmdb;
  final Imdb? imdb;
  final Modified? modified;
  final String? id;
  final String? name;
  final String? slug;
  final String? originName;
  final String? posterUrl;
  final String? thumbUrl;
  final int? year;

  MovieItem({
    required this.tmdb,
    required this.imdb,
    required this.modified,
    required this.id,
    required this.name,
    required this.slug,
    required this.originName,
    required this.posterUrl,
    required this.thumbUrl,
    required this.year,
  });

  factory MovieItem.fromJson(Map<String, dynamic> json) {
    return MovieItem(
      tmdb: json["tmdb"] == null ? null : Tmdb.fromJson(json["tmdb"]),
      imdb: json["imdb"] == null ? null : Imdb.fromJson(json["imdb"]),
      modified:
          json["modified"] == null ? null : Modified.fromJson(json["modified"]),
      id: json["_id"],
      name: json["name"],
      slug: json["slug"],
      originName: json["origin_name"],
      posterUrl: json["poster_url"],
      thumbUrl: json["thumb_url"],
      year: (json["year"] is int)
          ? json["year"]
          : int.tryParse(json["year"].toString()),
    );
  }
}

class Imdb {
  final dynamic id;

  Imdb({required this.id});

  factory Imdb.fromJson(Map<String, dynamic> json) {
    return Imdb(id: json["id"]);
  }
}

class Modified {
  final DateTime? time;

  Modified({required this.time});

  factory Modified.fromJson(Map<String, dynamic> json) {
    return Modified(
      time: DateTime.tryParse(json["time"] ?? ""),
    );
  }
}

class Tmdb {
  final String? type;
  final String? id;
  final int? season;
  final double? voteAverage;
  final int? voteCount;

  Tmdb({
    required this.type,
    required this.id,
    required this.season,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Tmdb.fromJson(Map<String, dynamic> json) {
    return Tmdb(
      type: json["type"],
      id: json["id"],
      season: json["season"] == null
          ? null
          : (json["season"] is int
              ? json["season"]
              : int.tryParse(json["season"].toString())),
      voteAverage: (json["vote_average"] is num)
          ? (json["vote_average"] as num).toDouble()
          : double.tryParse(json["vote_average"].toString()),
      voteCount: json["vote_count"],
    );
  }
}

class Pagination {
  final int? totalItems;
  final int? totalItemsPerPage;
  final int? currentPage;
  final int? totalPages;

  Pagination({
    required this.totalItems,
    required this.totalItemsPerPage,
    required this.currentPage,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalItems: json["totalItems"],
      totalItemsPerPage: json["totalItemsPerPage"],
      currentPage: json["currentPage"],
      totalPages: json["totalPages"],
    );
  }
}
