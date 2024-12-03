import 'package:awesome_app/data/models/movie.dart';
import 'package:awesome_app/presentation/home/widgets/item_grid_movie.dart';
import 'package:awesome_app/routes/app_routes.dart';
import 'package:flutter/material.dart';

class GridMovieSection extends StatelessWidget {
  const GridMovieSection(
      {super.key, required this.movies, this.controller, this.isSimilar});

  final List<Movie> movies;
  final ScrollController? controller;
  final bool? isSimilar;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: isSimilar ?? false,
      physics: (isSimilar ?? false)
          ? const NeverScrollableScrollPhysics()
          : const ScrollPhysics(),
      controller: controller,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.7),
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
            child: ItemGridMovie(movie: movie));
      },
    );
  }
}
