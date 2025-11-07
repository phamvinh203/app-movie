import 'package:app_movie/domain/movie/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final MovieItemEntity movie;
  final VoidCallback? onTap;
  final double width;
  final double height;

  const MovieCard({
    super.key,
    required this.movie,
    this.onTap,
    this.width = 160,
    this.height = 320,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🖼️ Poster với các badges overlay
            _buildPosterWithBadges(),

            const SizedBox(height: 6),

            // Phần thông tin bên dưới - sử dụng Expanded để tránh overflow
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 📝 Tên phim (Tiếng Việt) - maxLines: 1 với ellipsis
                  _buildMovieName(),

                  const SizedBox(height: 3),

                  // 🌍 Tên gốc - maxLines: 1 với ellipsis
                  if (movie.originName != null && movie.originName!.isNotEmpty)
                    _buildOriginName(),

                  const SizedBox(height: 3),

                  // 📅 Year + 🎬 Lang - cùng 1 dòng với ellipsis
                  _buildYearAndLang(),

                  const SizedBox(height: 4),

                  // 🏷️ Thể loại
                  if (movie.category.isNotEmpty) _buildCategories(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🖼️ Poster với badges overlay
  Widget _buildPosterWithBadges() {
    // Tính poster height: tổng height - khoảng 100px cho thông tin bên dưới
    final posterHeight = height - 110;

    return Stack(
      children: [
        // Poster image
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            movie.posterUrl ?? '',
            width: width,
            height: posterHeight,
            fit: BoxFit.cover,
            errorBuilder: (context, _, __) => Container(
              width: width,
              height: posterHeight,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.broken_image,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),

        // Quality badge (góc trên trái)
        if (movie.quality != null && movie.quality!.isNotEmpty)
          Positioned(
            top: 8,
            left: 8,
            child: _buildBadge(
              text: movie.quality!,
              backgroundColor: Colors.black.withOpacity(0.7),
              textColor: Colors.amber,
              fontSize: 11,
            ),
          ),

        // Episode badge (góc trên phải)
        if (movie.episodeCurrent != null && movie.episodeCurrent!.isNotEmpty)
          Positioned(
            top: 8,
            right: 8,
            child: _buildBadge(
              text: movie.episodeCurrent!,
              backgroundColor: Colors.redAccent.withOpacity(0.9),
              textColor: Colors.white,
              fontSize: 10,
              maxLines: 1,
            ),
          ),
      ],
    );
  }

  /// 📝 Tên phim Tiếng Việt (1 dòng với ellipsis)
  Widget _buildMovieName() {
    return Text(
      movie.name ?? 'No title',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14,
        height: 1.2,
      ),
    );
  }

  /// 🌍 Tên gốc (1 dòng với ellipsis)
  Widget _buildOriginName() {
    return Text(
      movie.originName!,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 12,
        color: Colors.grey[500],
        fontStyle: FontStyle.italic,
      ),
    );
  }

  /// 📅 Year + 🎬 Lang (cùng 1 dòng với ellipsis)
  Widget _buildYearAndLang() {
    final yearText = movie.year != null ? '${movie.year}' : '';
    final langText = movie.lang ?? '';

    // Nếu không có year và lang thì return empty
    if (yearText.isEmpty && langText.isEmpty) {
      return const SizedBox.shrink();
    }

    // Nối year và lang
    final displayText = yearText.isNotEmpty && langText.isNotEmpty
        ? '$yearText • $langText'
        : yearText.isNotEmpty
        ? yearText
        : langText;

    return Text(
      displayText,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 11,
        color: Colors.grey[400],
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// 🏷️ Thể loại tags
  Widget _buildCategories() {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: movie.category
          .take(2) // Chỉ hiển thị tối đa 2 thể loại
          .map(
            (cat) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Colors.blue.withOpacity(0.4),
                  width: 0.5,
                ),
              ),
              child: Text(
                cat.name ?? '',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.blue[300],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  /// 🎨 Helper: Tạo badge
  Widget _buildBadge({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    double fontSize = 11,
    int maxLines = 1,
    TextAlign textAlign = TextAlign.left,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
