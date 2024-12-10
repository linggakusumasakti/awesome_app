import 'package:awesome_app/data/api/movie_api_client.dart';
import 'package:awesome_app/data/api/movie_exception.dart';
import 'package:awesome_app/data/models/movie.dart';
import 'package:awesome_app/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('get movies', () {
    late http.Client httpClient;
    late MovieApiClient movieApiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });
    setUp(() {
      httpClient = MockHttpClient();
      movieApiClient = MovieApiClient(httpClient: httpClient);
    });

    test('makes correct http request', () async {
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn('{}');
      when(() => httpClient.get(any())).thenAnswer((_) async => response);
      try {
        await movieApiClient.getMovies();
      } catch (_) {}
      verify(
        () => httpClient.get(
          headers: any(named: 'headers'),
          Uri.https(
            baseUrl,
            '/3/movie/now_playing',
            {
              'page': '1',
            },
          ),
        ),
      ).called(1);
    });

    test('throws movies failure on non-200 response', () async {
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(400);
      when(() => response.body).thenReturn('{"status_message": "Invalid API key: You must be granted a valid key."}');
      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);
      expect(
        () async => movieApiClient.getMovies(),
        throwsA(isA<MovieException>()),
      );
    });

    test('return list movies valid response', () async {
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn(
        '''
{
  "results": [
        {
            "adult": false,
            "backdrop_path": "/tElnmtQ6yz1PjN1kePNl8yMSb59.jpg",
            "genre_ids": [
                16,
                12,
                10751,
                35
            ],
            "id": 1241982,
            "original_language": "en",
            "original_title": "Moana 2",
            "overview": "After receiving an unexpected call from her wayfinding ancestors, Moana journeys alongside Maui and a new crew to the far seas of Oceania and into dangerous, long-lost waters for an adventure unlike anything she's ever faced.",
            "popularity": 6106.764,
            "poster_path": "/yh64qw9mgXBvlaWDi7Q9tpUBAvH.jpg",
            "release_date": "2024-11-27",
            "title": "Moana 2",
            "video": false,
            "vote_average": 7.0,
            "vote_count": 273
        }]
}''',
      );
      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);
      final movies = await movieApiClient.getMovies();
      expect(movies, isA<List<Movie>>());
    });
  });
}
