import 'package:awesome_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:awesome_app/blocs/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:awesome_app/data/api/movie_api_client.dart';
import 'package:awesome_app/data/repositories/movie_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  locator
      .registerFactory<MovieBloc>(() => MovieBloc(movieRepository: locator()));
  locator.registerFactory<MovieDetailBloc>(
      () => MovieDetailBloc(movieRepository: locator()));

  locator.registerLazySingleton<MovieRepository>(
      () => MovieRepository(movieApiClient: locator()));

  locator.registerLazySingleton<MovieApiClient>(
      () => MovieApiClient(httpClient: http.Client()));
}
