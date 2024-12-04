import 'package:awesome_app/blocs/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:awesome_app/blocs/movie_detail_bloc/movie_detail_state.dart';
import 'package:awesome_app/utils/ext/string.dart';
import 'package:awesome_app/utils/style/my_text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/movie_detail_bloc/movie_detail_event.dart';
import '../../../data/models/movie.dart';
import '../../../utils/constants.dart';
import '../../../utils/widgets/grid_loading.dart';
import '../../home/widgets/grid_movie_section.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    context.read<MovieDetailBloc>().add(FetchSimilarMovies(id: movie.id ?? 0));
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 250,
            floating: false,
            pinned: true,
            title: Text(
              movie.originalTitle ?? '',
              style: MyTextStyle.title,
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: '$baseImageUrl${movie.backdropPath}',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white54, Colors.transparent],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              movie.originalTitle ?? '',
                              style: MyTextStyle.title.copyWith(fontSize: 24),
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.star,
                            size: 35,
                            color: Colors.orange,
                          ),
                          Text(
                            movie.voteAverage.toString(),
                            style: MyTextStyle.body.copyWith(fontSize: 22),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Overview',
                        style: MyTextStyle.title,
                      ),
                      Text(
                        movie.overview ?? 'No overview',
                        style: MyTextStyle.body,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Relase Date',
                        style: MyTextStyle.body
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        movie.releaseDate?.formatDate() ?? 'No release date',
                        style: MyTextStyle.body,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Similar Movies',
                        style: MyTextStyle.body
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      BlocBuilder<MovieDetailBloc, MovieDetailState>(
                          builder: (context, state) {
                        return switch (state) {
                          MoviesSimilarLoading() => const GridLoading(
                              isSimilar: true,
                            ),
                          MoviesSimilarSuccess() => GridMovieSection(
                              movies: state.movies,
                              isSimilar: true,
                            ),
                          MoviesSimilarError() => Text(state.text),
                          _ => const SizedBox()
                        };
                      })
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
