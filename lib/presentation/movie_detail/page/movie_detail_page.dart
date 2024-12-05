import 'package:awesome_app/blocs/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:awesome_app/presentation/movie_detail/widgets/movie_detail_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/movie_detail_bloc/movie_detail_event.dart';
import '../../../data/models/movie.dart';
import '../../../data/repositories/movie_repository.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MovieDetailBloc(movieRepository: MovieRepository())
          ..add(FetchSimilarMovies(id: movie.id ?? 0)),
        child: MovieDetailSection(movie: movie));
  }
}
