import 'package:awesome_app/presentation/home/widgets/item_list_movie.dart';
import 'package:flutter/material.dart';

import '../../../data/models/movie.dart';
import '../../../routes/app_routes.dart';

class ListMovieSection extends StatelessWidget {
  const ListMovieSection(
      {super.key, required this.movies, required this.controller});

  final List<Movie> movies;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      shrinkWrap: true,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.movieDetail,
                arguments: movie,
              );
            },
            child: ItemListMovie(movie: movie));
      },
    );
  }
}
