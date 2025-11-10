import 'package:app_movie/core/constants/api_url.dart';

/// 🎬 Cấu hình danh sách loại phim
class MovieTypeConfig {
  final String title;
  final String typeList;

  const MovieTypeConfig({required this.title, required this.typeList});
}

/// 📺 Danh sách tất cả các loại phim
final List<MovieTypeConfig> movieTypesList = [
  MovieTypeConfig(title: 'Phim Bộ', typeList: ApiUrl.typePhimBo),
  MovieTypeConfig(title: 'Phim Lẻ', typeList: ApiUrl.typePhimLe),
  MovieTypeConfig(title: 'TV Shows', typeList: ApiUrl.typeTvShows),
  MovieTypeConfig(title: 'Hoạt Hình', typeList: ApiUrl.typeHoatHinh),
  MovieTypeConfig(title: 'Phim Vietsub', typeList: ApiUrl.typePhimVietsub),
  MovieTypeConfig(
    title: 'Phim Thuyết Minh',
    typeList: ApiUrl.typePhimThuyetMinh,
  ),
  MovieTypeConfig(title: 'Phim Lồng Tiếng', typeList: ApiUrl.typePhimLongTieng),
];
