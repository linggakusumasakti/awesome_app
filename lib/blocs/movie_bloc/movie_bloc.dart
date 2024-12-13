import 'dart:io';

import 'package:awesome_app/data/api/movie_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/movie_repository.dart';
import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  int page = 1;

  MovieBloc({required this.movieRepository}) : super(MovieState.initial()) {
    on<MovieGrid>((event, emit) async {
      if (state.movieStatus == MovieStatus.listLoaded) {
        emit(state.copyWith(
            movies: List.of(state.movies),
            movieStatus: MovieStatus.gridLoaded));
        return;
      }
      try {
        page = 1;
        emit(state.copyWith(movieStatus: MovieStatus.loading));
        final movies = await movieRepository.getMovies(page: page);
        emit(state.copyWith(
            movieStatus: MovieStatus.gridLoaded, movies: movies));
      } on MovieException catch (e) {
        emit(state.copyWith(
            movieStatus: MovieStatus.error, errorMessage: e.message));
      } on SocketException {
        emit(state.copyWith(
            movieStatus: MovieStatus.error,
            errorMessage: 'No Internet connection'));
      }
    });

    on<MovieList>((event, emit) async {
      if (state.movieStatus == MovieStatus.gridLoaded) {
        emit(state.copyWith(
            movies: List.of(state.movies),
            movieStatus: MovieStatus.listLoaded));
        return;
      }
      try {
        page = 1;
        emit(state.copyWith(movieStatus: MovieStatus.loading));
        final movies = await movieRepository.getMovies(page: page);
        emit(state.copyWith(
            movieStatus: MovieStatus.listLoaded, movies: movies));
      } on MovieException catch (e) {
        emit(state.copyWith(
            movieStatus: MovieStatus.error, errorMessage: e.message));
      } on SocketException {
        emit(state.copyWith(
            movieStatus: MovieStatus.error,
            errorMessage: 'No Internet connection'));
      }
    });

    on<LoadMoreMovieGrid>((event, emit) async {
      try {
        page++;
        final movies = await movieRepository.getMovies(page: page);
        emit(state.copyWith(movies: List.of(state.movies)..addAll(movies)));
      } catch (e) {
        emit(state.copyWith(
            errorMessage: e.toString(), movieStatus: MovieStatus.error));
      }
    });

    on<LoadMoreListMovie>((event, emit) async {
      try {
        page++;
        final movies = await movieRepository.getMovies(page: page);
        emit(state.copyWith(movies: List.of(state.movies)..addAll(movies)));
      } catch (e) {
        emit(state.copyWith(
            errorMessage: e.toString(), movieStatus: MovieStatus.error));
      }
    });
  }
}
