import 'package:awesome_app/data/api/movie_api_client.dart';
import 'package:awesome_app/data/models/movie.dart';
import 'package:awesome_app/data/repositories/movie_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieApiClient extends Mock implements MovieApiClient {}

class MockMovie extends Mock implements Movie {}

void main() {
  group('movie repository', () {
    late MovieApiClient movieApiClient;
    late MovieRepository movieRepository;

    setUp(() {
      movieApiClient = MockMovieApiClient();
      movieRepository = MovieRepository(movieApiClient: movieApiClient);
    });

    test('get movies', () async {
      try {
        await movieRepository.getMovies(page: 1);
      } catch (_) {}
      verify(() => movieApiClient.getMovies()).called(1);
    });

    test('throws when get movies fails', () async {
      final exception = Exception('Failed to load movies');
      when(() => movieApiClient.getMovies()).thenThrow(exception);
      expect(
        () async => movieRepository.getMovies(page: 1),
        throwsA(exception),
      );
    });
  });
}
