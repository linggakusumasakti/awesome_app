import 'package:awesome_app/data/api/movie_api_client.dart';
import 'package:awesome_app/data/models/movie.dart';

class MovieRepository {
  MovieRepository({MovieApiClient? movieApiClient})
      : _movieApiClient = movieApiClient ?? MovieApiClient();

  final MovieApiClient _movieApiClient;

  Future<List<Movie>> getMovies({int? page}) async {
    return _movieApiClient.getMovies(page: page);
  }

  Future<List<Movie>> getSimilarMovies(int id) async {
    return _movieApiClient.getSimilarMovies(id);
  }
}
