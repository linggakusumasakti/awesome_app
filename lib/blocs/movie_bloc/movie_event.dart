import 'package:equatable/equatable.dart';

sealed class MovieEvent extends Equatable {
  const MovieEvent();
}

final class MovieGrid extends MovieEvent {
  @override
  List<Object?> get props => [];
}

final class MovieList extends MovieEvent {
  @override
  List<Object?> get props => [];
}

final class LoadMoreMovieGrid extends MovieEvent {
  @override
  List<Object?> get props => [];
}

final class LoadMoreListMovie extends MovieEvent {
  @override
  List<Object?> get props => [];
}
