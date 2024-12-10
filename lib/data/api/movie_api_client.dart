import 'dart:convert';

import 'package:awesome_app/data/api/movie_exception.dart';
import 'package:awesome_app/data/models/movie.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants.dart';

class MovieApiClient {
  MovieApiClient({required this.httpClient});

  final http.Client httpClient;

  final headers = {
    'Authorization': apiKey,
    'Content-Type': 'application/json',
  };

  Future<List<Movie>> getMovies({int? page = 1}) async {
    final url = Uri.https(baseUrl, '/3/movie/now_playing', {'page': '$page'});
    final response = await httpClient.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw MovieException(
          message: json.decode(response.body)['status_message']);
    }
  }

  Future<List<Movie>> getSimilarMovies(int id) async {
    final url = Uri.https(baseUrl, '/3/movie/$id/similar');
    final response = await httpClient.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }
}
