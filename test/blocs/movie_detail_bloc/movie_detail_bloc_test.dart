import 'package:awesome_app/blocs/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:awesome_app/blocs/movie_detail_bloc/movie_detail_event.dart';
import 'package:awesome_app/blocs/movie_detail_bloc/movie_detail_state.dart';
import 'package:awesome_app/data/models/movie.dart';
import 'package:awesome_app/data/repositories/movie_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  group('movie bloc', () {
    late MovieDetailBloc movieDetailBloc;
    late MockMovieRepository mockMovieRepository;

    setUp(() {
      mockMovieRepository = MockMovieRepository();
      movieDetailBloc = MovieDetailBloc(movieRepository: mockMovieRepository);
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
    blocTest<MovieDetailBloc, MovieDetailState>(
        'emits [MovieLoading, MovieGridSuccess] when FetchSimilarMovies event is added',
        build: () {
          when(() => mockMovieRepository.getSimilarMovies(1241982))
              .thenAnswer((_) async => mockMovies);
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchSimilarMovies(id: 1241982)),
        expect: () =>
            [MoviesSimilarLoading(), MoviesSimilarSuccess(movies: mockMovies)],
        verify: (_) {
          verify(() => mockMovieRepository.getSimilarMovies(1241982)).called(1);
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits [MoviesSimilarError] when MovieGrid event fails',
      build: () {
        when(() => mockMovieRepository.getSimilarMovies(1241982))
            .thenThrow(Exception('Failed to fetch movies'));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchSimilarMovies(id: 1241982)),
      expect: () => [
        MoviesSimilarLoading(),
        const MoviesSimilarError(text: 'Exception: Failed to fetch movies'),
      ],
      verify: (_) {
        verify(() => mockMovieRepository.getSimilarMovies(1241982)).called(1);
      },
    );
  });
}
