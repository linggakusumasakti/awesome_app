import 'dart:io';

import 'package:awesome_app/data/api/movie_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/movie_repository.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  int page = 1;

  MovieBloc({required this.movieRepository}) : super(MovieInitial()) {
    on<MovieGrid>((event, emit) async {
      if (state is MovieListSuccess) {
        final currentState = state as MovieListSuccess;
        emit(MovieGridSuccess(movies: List.of(currentState.movies)));
        return;
      }
      try {
        page = 1;
        emit(MovieLoading());
        final movies = await movieRepository.getMovies(page: page);
        emit(MovieGridSuccess(movies: movies));
      } on MovieException catch (e) {
        emit(MovieError(text: e.message));
      } on SocketException {
        emit(const MovieError(text: 'No Internet connection'));
      }
    });

    on<MovieList>((event, emit) async {
      if (state is MovieGridSuccess) {
        final currentState = state as MovieGridSuccess;
        emit(MovieListSuccess(movies: List.of(currentState.movies)));
        return;
      }
      try {
        page = 1;
        emit(MovieLoading());
        final movies = await movieRepository.getMovies(page: page);
        emit(MovieListSuccess(movies: movies));
      } catch (e) {
        emit(MovieError(text: e.toString()));
      }
    });

    on<LoadMoreMovieGrid>((event, emit) async {
      final currentState = state as MovieGridSuccess;
      try {
        page++;
        final movies = await movieRepository.getMovies(page: page);
        emit(currentState.copyWith(
            movies: List.of(currentState.movies)..addAll(movies)));
      } catch (e) {
        emit(MovieError(text: e.toString()));
      }
    });

    on<LoadMoreListMovie>((event, emit) async {
      final currentState = state as MovieListSuccess;
      try {
        page++;
        final movies = await movieRepository.getMovies(page: page);
        emit(currentState.copyWith(
            movies: List.of(currentState.movies)..addAll(movies)));
      } catch (e) {
        emit(MovieError(text: e.toString()));
      }
    });
  }
}
