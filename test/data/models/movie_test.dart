import 'package:awesome_app/data/models/movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns correct movie object', () {
    expect(
        Movie.fromJson(const <String, dynamic>{
          'id': 1241982,
          'original_title': 'Moana 2',
          'overview':
              'After receiving an unexpected call from her wayfinding ancestors, Moana journeys alongside Maui and a new crew to the far seas of Oceania and into dangerous, long-lost waters for an adventure unlike anything she\'s ever faced.',
          'poster_path': '/yh64qw9mgXBvlaWDi7Q9tpUBAvH.jpg',
          'backdrop_path': '/tElnmtQ6yz1PjN1kePNl8yMSb59.jpg',
          'vote_average': 7.041,
          'release_date': '2024-11-27'
        }),
        isA<Movie>()
            .having((movie) => movie.id, 'id', 1241982)
            .having((movie) => movie.originalTitle, 'original_title', 'Moana 2')
            .having((movie) => movie.overview, 'overview',
                'After receiving an unexpected call from her wayfinding ancestors, Moana journeys alongside Maui and a new crew to the far seas of Oceania and into dangerous, long-lost waters for an adventure unlike anything she\'s ever faced.')
            .having((movie) => movie.posterPath, 'poster_path',
                '/yh64qw9mgXBvlaWDi7Q9tpUBAvH.jpg')
            .having((movie) => movie.backdropPath, 'backdrop_path',
                '/tElnmtQ6yz1PjN1kePNl8yMSb59.jpg')
            .having((movie) => movie.voteAverage, 'vote_average', 7.041)
            .having(
                (movie) => movie.releaseDate, 'release_date', '2024-11-27'));
  });
}
