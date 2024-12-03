import 'package:equatable/equatable.dart';

sealed class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

final class FetchSimilarMovies extends MovieDetailEvent {
  final int id;

  const FetchSimilarMovies({required this.id});

  @override
  List<Object?> get props => [id];
}
