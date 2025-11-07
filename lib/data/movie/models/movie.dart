class MovieModel {
  MovieModel({
    required this.status,
    required this.msg,
    required this.items,
    required this.pagination,
  });

  final bool? status;
  final String? msg;
  final List<MovieItem> items;
  final Pagination? pagination;

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      status: json["status"],
      msg: json["msg"],
      items: json["items"] == null
          ? []
          : List<MovieItem>.from(
              json["items"]!.map((x) => MovieItem.fromJson(x)),
            ),
      pagination: json["pagination"] == null
          ? null
          : Pagination.fromJson(json["pagination"]),
    );
  }
}

class MovieItem {
  MovieItem({
    required this.tmdb,
    required this.imdb,
    required this.modified,
    required this.id,
    required this.name,
    required this.slug,
    required this.originName,
    required this.type,
    required this.posterUrl,
    required this.thumbUrl,
    required this.subDocquyen,
    required this.time,
    required this.episodeCurrent,
    required this.quality,
    required this.lang,
    required this.year,
    required this.category,
    required this.country,
  });

  final Tmdb? tmdb;
  final Imdb? imdb;
  final Modified? modified;
  final String? id;
  final String? name;
  final String? slug;
  final String? originName;
  final String? type;
  final String? posterUrl;
  final String? thumbUrl;
  final bool? subDocquyen;
  final String? time;
  final String? episodeCurrent;
  final String? quality;
  final String? lang;
  final int? year;
  final List<Category> category;
  final List<Category> country;

  factory MovieItem.fromJson(Map<String, dynamic> json) {
    return MovieItem(
      tmdb: json["tmdb"] == null ? null : Tmdb.fromJson(json["tmdb"]),
      imdb: json["imdb"] == null ? null : Imdb.fromJson(json["imdb"]),
      modified: json["modified"] == null
          ? null
          : Modified.fromJson(json["modified"]),
      id: json["_id"],
      name: json["name"],
      slug: json["slug"],
      originName: json["origin_name"],
      type: json["type"],
      posterUrl: json["poster_url"],
      thumbUrl: json["thumb_url"],
      subDocquyen: json["sub_docquyen"],
      time: json["time"],
      episodeCurrent: json["episode_current"],
      quality: json["quality"],
      lang: json["lang"],
      year: json["year"],
      category: json["category"] == null
          ? []
          : List<Category>.from(
              json["category"]!.map((x) => Category.fromJson(x)),
            ),
      country: json["country"] == null
          ? []
          : List<Category>.from(
              json["country"]!.map((x) => Category.fromJson(x)),
            ),
    );
  }
}

class Category {
  Category({required this.id, required this.name, required this.slug});

  final String? id;
  final String? name;
  final String? slug;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json["id"], name: json["name"], slug: json["slug"]);
  }
}

class Imdb {
  Imdb({required this.id});

  final dynamic id;

  factory Imdb.fromJson(Map<String, dynamic> json) {
    return Imdb(id: json["id"]);
  }
}

class Modified {
  Modified({required this.time});

  final DateTime? time;

  factory Modified.fromJson(Map<String, dynamic> json) {
    return Modified(time: DateTime.tryParse(json["time"] ?? ""));
  }
}

class Tmdb {
  Tmdb({
    required this.type,
    required this.id,
    required this.season,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? type;
  final String? id;
  final int? season;
  final double? voteAverage;
  final int? voteCount;

  factory Tmdb.fromJson(Map<String, dynamic> json) {
    return Tmdb(
      type: json["type"],
      id: json["id"],
      season: json["season"],
      voteAverage: json["vote_average"] != null
          ? (json["vote_average"] as num).toDouble()
          : null,
      voteCount: json["vote_count"],
    );
  }
}

class Pagination {
  Pagination({
    required this.totalItems,
    required this.totalItemsPerPage,
    required this.currentPage,
    required this.totalPages,
    required this.updateToday,
  });

  final int? totalItems;
  final int? totalItemsPerPage;
  final int? currentPage;
  final int? totalPages;
  final int? updateToday;

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalItems: json["totalItems"],
      totalItemsPerPage: json["totalItemsPerPage"],
      currentPage: json["currentPage"],
      totalPages: json["totalPages"],
      updateToday: json["updateToday"],
    );
  }
}
