import 'package:awesome_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:awesome_app/blocs/movie_bloc/movie_event.dart';
import 'package:awesome_app/presentation/home/page/home_page.dart';
import 'package:awesome_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_app/di/injection.dart' as di;
import 'package:get_it/get_it.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        create: (_) => GetIt.instance<MovieBloc>()..add(MovieGrid()),
        child: const HomePage(),
      ),
    );
  }
}
