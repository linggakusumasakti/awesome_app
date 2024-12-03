import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/movie_repository.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieRepository movieRepository;

  MovieDetailBloc({required this.movieRepository})
      : super(MoviesSimilarInitial()) {
    on<FetchSimilarMovies>((event, emit) async {
      try {
        emit(MoviesSimilarLoading());
        final movies = await movieRepository.getSimilarMovies(event.id);
        emit(MoviesSimilarSuccess(movies: movies));
      } catch (e) {
        emit(MoviesSimilarError(text: e.toString()));
      }
    });
  }
}
