import 'package:awesome_app/data/models/movie.dart';
import 'package:awesome_app/presentation/home/page/home_page.dart';
import 'package:awesome_app/presentation/movie_detail/page/movie_detail_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const movieDetail = '/movieDetail';

  static Route<dynamic> route(RouteSettings settings) {
    return switch (settings.name) {
      movieDetail => MaterialPageRoute(
          builder: (_) => MovieDetailPage(
                movie: settings.arguments as Movie,
              )),
      _ => MaterialPageRoute(builder: (_) => const HomePage())
    };
  }
}
