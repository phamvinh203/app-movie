import 'package:flutter/material.dart';

class NowPlayingMovieText extends StatelessWidget {
  const NowPlayingMovieText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: const Text(
        'Phim đang chiếu',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
