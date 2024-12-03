import 'package:equatable/equatable.dart';

import '../../data/models/movie.dart';

sealed class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object?> get props => [];
}

final class MovieInitial extends MovieState {
  @override
  List<Object> get props => [];
}

final class MovieLoading extends MovieState {
  @override
  List<Object?> get props => [];
}

final class MovieError extends MovieState {
  const MovieError({required this.text});

  final String text;

  @override
  List<Object?> get props => [text];
}

final class MovieGridSuccess extends MovieState {
  const MovieGridSuccess({required this.movies});

  final List<Movie> movies;

  MovieGridSuccess copyWith({required List<Movie> movies}) {
    return MovieGridSuccess(movies: movies);
  }

  @override
  List<Object> get props => [movies];
}

final class MovieListSuccess extends MovieState {
  const MovieListSuccess({required this.movies});

  final List<Movie> movies;

  MovieListSuccess copyWith({required List<Movie> movies}) {
    return MovieListSuccess(movies: movies);
  }

  @override
  List<Object> get props => [movies];
}
