import 'package:awesome_app/blocs/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:awesome_app/presentation/movie_detail/widgets/movie_detail_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../blocs/movie_detail_bloc/movie_detail_event.dart';
import '../../../data/models/movie.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => GetIt.instance<MovieDetailBloc>()
          ..add(FetchSimilarMovies(id: movie.id ?? 0)),
        child: MovieDetailSection(movie: movie));
  }
}
