import 'package:awesome_app/data/api/movie_api_client.dart';
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
    final headers = {
      'Authorization': apiKey,
      'Content-Type': 'application/json',
    };

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
          headers: headers,
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
  });
}
