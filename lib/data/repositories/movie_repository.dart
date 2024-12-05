import 'package:awesome_app/data/api/movie_api_client.dart';
import 'package:awesome_app/data/models/movie.dart';

class MovieRepository {
  MovieRepository({required this.movieApiClient});

  final MovieApiClient movieApiClient;

  Future<List<Movie>> getMovies({int? page}) async {
    return movieApiClient.getMovies(page: page);
  }

  Future<List<Movie>> getSimilarMovies(int id) async {
    return movieApiClient.getSimilarMovies(id);
  }
}
