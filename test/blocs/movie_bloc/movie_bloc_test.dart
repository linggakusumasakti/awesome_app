import 'package:awesome_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:awesome_app/blocs/movie_bloc/movie_event.dart';
import 'package:awesome_app/blocs/movie_bloc/movie_state.dart';
import 'package:awesome_app/data/api/movie_exception.dart';
import 'package:awesome_app/data/models/movie.dart';
import 'package:awesome_app/data/repositories/movie_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  group('movie bloc', () {
    late MovieBloc movieBloc;
    late MockMovieRepository mockMovieRepository;

    setUp(() {
      mockMovieRepository = MockMovieRepository();
      movieBloc = MovieBloc(movieRepository: mockMovieRepository);
    });
    final mockMovies = [
      const Movie(
          id: 1241982,
          originalTitle: 'Moana 2',
          overview:
              'After receiving an unexpected call from her wayfinding ancestors, Moana journeys alongside Maui and a new crew to the far seas of Oceania and into dangerous, long-lost waters for an adventure unlike anything she\'s ever faced.',
          posterPath: '/yh64qw9mgXBvlaWDi7Q9tpUBAvH.jpg',
          backdropPath: '/tElnmtQ6yz1PjN1kePNl8yMSb59.jpg',
          voteAverage: 7.041,
          releaseDate: '2024-11-27')
    ];
    blocTest<MovieBloc, MovieState>(
        'emits loading, gridLoaded when MovieGrid event is added',
        build: () {
          when(() => mockMovieRepository.getMovies(page: 1))
              .thenAnswer((_) async => mockMovies);
          return movieBloc;
        },
        act: (bloc) => bloc.add(MovieGrid()),
        expect: () => [
              const MovieState(
                  movieStatus: MovieStatus.loading,
                  movies: [],
                  errorMessage: ''),
              MovieState(
                  movieStatus: MovieStatus.gridLoaded,
                  movies: mockMovies,
                  errorMessage: ''),
            ],
        verify: (_) {
          verify(() => mockMovieRepository.getMovies(page: 1)).called(1);
        });

    blocTest<MovieBloc, MovieState>(
      'emits error when MovieGrid event fails',
      build: () {
        when(() => mockMovieRepository.getMovies(page: 1))
            .thenThrow(const MovieException(message: 'Failed to fetch movies'));
        return movieBloc;
      },
      act: (bloc) => bloc.add(MovieGrid()),
      expect: () => [
        const MovieState(
            movieStatus: MovieStatus.loading,
            movies: [],
            errorMessage: ''),
        const MovieState(movieStatus: MovieStatus.error, movies: [], errorMessage: 'Failed to fetch movies'),
      ],
      verify: (_) {
        verify(() => mockMovieRepository.getMovies(page: 1)).called(1);
      },
    );
  });
}
