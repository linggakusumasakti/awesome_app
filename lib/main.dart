import 'package:awesome_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:awesome_app/blocs/movie_bloc/movie_event.dart';
import 'package:awesome_app/data/repositories/movie_repository.dart';
import 'package:awesome_app/presentation/home/page/home_page.dart';
import 'package:awesome_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp(
    movieRepository: MovieRepository(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required MovieRepository movieRepository})
      : _movieRepository = movieRepository;

  final MovieRepository _movieRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awesome App',
      initialRoute: '/',
      onGenerateRoute: AppRoutes.route,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) =>
            MovieBloc(movieRepository: _movieRepository)..add(MovieGrid()),
        child: const HomePage(),
      ),
    );
  }
}
