import 'package:equatable/equatable.dart';

import '../../data/models/movie.dart';

enum MovieStatus {
  initial,
  loading,
  gridLoaded,
  listLoaded,
  error,
}

class MovieState extends Equatable {
  final MovieStatus movieStatus;
  final List<Movie> movies;
  final String errorMessage;

  const MovieState(
      {required this.movieStatus,
      required this.movies,
      required this.errorMessage});

  static MovieState initial() => const MovieState(
      movieStatus: MovieStatus.initial, movies: [], errorMessage: '');

  MovieState copyWith(
      {MovieStatus? movieStatus, List<Movie>? movies, String? errorMessage}) {
    return MovieState(
        movieStatus: movieStatus ?? this.movieStatus,
        movies: movies ?? this.movies,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [movieStatus, movies];
}
