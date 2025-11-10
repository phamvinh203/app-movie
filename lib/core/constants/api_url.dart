class ApiUrl {
  static const baseURL = 'https://phimapi.com/';

  // ==================== CDN ====================
  /// CDN cho hình ảnh (poster, thumb)
  static const imageCDN = 'https://phimimg.com/';

  // ==================== DANH SÁCH PHIM ====================
  /// GET https://phimapi.com/danh-sach/phim-moi-cap-nhat-v3?page={page}
  static const movie = 'danh-sach/phim-moi-cap-nhat-v3';

  // Legacy support
  static const bannerMovies = movie;
  static const hotMovies = movie;
  static const latestMovies = movie;

  // ==================== PHIM & TẬP PHIM ====================
  /// Thông tin Phim & Danh sách tập phim
  /// GET https://phimapi.com/phim/{slug}
  static const movieDetail = 'phim/{slug}';

  /// Thông tin dựa theo TMDB ID
  /// GET https://phimapi.com/tmdb/{type}/{id}
  /// type = tv (phim bộ, hoạt hình, tv shows) hoặc movie
  static const tmdbInfo = 'tmdb/{type}/{id}';

  // ==================== DANH SÁCH TỔNG HỢP ====================
  /// Tổng hợp danh sách phim
  /// GET https://phimapi.com/v1/api/danh-sach/{type_list}
  /// Params: page, sort_field, sort_type, sort_lang, category, country, year, limit
  /// type_list: phim-bo, phim-le, tv-shows, hoat-hinh, phim-vietsub, phim-thuyet-minh, phim-long-tieng
  static const movieList = 'v1/api/danh-sach/{type_list}';

  // ==================== TÌM KIẾM ====================
  /// Tìm kiếm phim
  /// GET https://phimapi.com/v1/api/tim-kiem
  /// Params: keyword, page, sort_field, sort_type, sort_lang, category, country, year, limit
  static const search = 'v1/api/tim-kiem';

  // ==================== THỂ LOẠI ====================
  /// Danh sách thể loại
  /// GET https://phimapi.com/the-loai
  static const categories = 'the-loai';

  /// Chi tiết thể loại
  /// GET https://phimapi.com/v1/api/the-loai/{type_list}
  /// Params: page, sort_field, sort_type, sort_lang, country, year, limit
  static const categoryDetail = 'v1/api/the-loai/{type_list}';

  // ==================== QUỐC GIA ====================
  /// Danh sách quốc gia
  /// GET https://phimapi.com/quoc-gia
  static const countries = 'quoc-gia';

  /// Chi tiết quốc gia
  /// GET https://phimapi.com/v1/api/quoc-gia/{type_list}
  /// Params: page, sort_field, sort_type, sort_lang, category, year, limit
  static const countryDetail = 'v1/api/quoc-gia/{type_list}';

  // ==================== NĂM ====================
  /// Lọc theo năm
  /// GET https://phimapi.com/v1/api/nam/{type_list}
  /// Params: page, sort_field, sort_type, sort_lang, category, country, limit
  /// type_list: Năm phát hành (1970 - hiện tại)
  static const yearFilter = 'v1/api/nam/{type_list}';

  // ==================== KHÁC ====================
  static const trailerBase = 'https://www.youtube.com/watch?v=';

  // ==================== QUERY PARAMS CONSTANTS ====================
  /// Sort field options
  static const sortFieldModifiedTime = 'modified.time';
  static const sortFieldId = '_id';
  static const sortFieldYear = 'year';

  /// Sort type options
  static const sortTypeDesc = 'desc';
  static const sortTypeAsc = 'asc';

  /// Sort lang options
  static const sortLangVietsub = 'vietsub';
  static const sortLangThuyetMinh = 'thuyet-minh';
  static const sortLangLongTieng = 'long-tieng';

  /// Movie type list options
  static const typePhimBo = 'phim-bo';
  static const typePhimLe = 'phim-le';
  static const typeTvShows = 'tv-shows';
  static const typeHoatHinh = 'hoat-hinh';
  static const typePhimVietsub = 'phim-vietsub';
  static const typePhimThuyetMinh = 'phim-thuyet-minh';
  static const typePhimLongTieng = 'phim-long-tieng';

  /// TMDB type options
  static const tmdbTypeTv = 'tv';
  static const tmdbTypeMovie = 'movie';

  /// Limit max
  static const maxLimit = 64;

  // ==================== HELPER METHODS ====================
  /// Build full image URL từ relative path
  static String getImageUrl(String? relativePath) {
    if (relativePath == null || relativePath.isEmpty) return '';
    if (relativePath.startsWith('http')) return relativePath;
    return '$imageCDN$relativePath';
  }
}
