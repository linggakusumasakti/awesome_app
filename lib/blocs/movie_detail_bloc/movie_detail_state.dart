import 'package:awesome_app/data/models/movie.dart';
import 'package:equatable/equatable.dart';

sealed class MovieDetailState extends Equatable {
  const MovieDetailState();
}

class MoviesSimilarInitial extends MovieDetailState {
  @override
  List<Object> get props => [];
}

class MoviesSimilarLoading extends MovieDetailState {
  @override
  List<Object?> get props => [];
}

class MoviesSimilarError extends MovieDetailState {
  const MoviesSimilarError({required this.text});

  final String text;

  @override
  List<Object?> get props => [text];
}

class MoviesSimilarSuccess extends MovieDetailState {
  final List<Movie> movies;

  const MoviesSimilarSuccess({required this.movies});

  @override
  List<Object?> get props => [movies];
}
