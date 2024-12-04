import 'package:awesome_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:awesome_app/blocs/movie_bloc/movie_event.dart';
import 'package:awesome_app/blocs/movie_bloc/movie_state.dart';
import 'package:awesome_app/data/models/movie.dart';
import 'package:awesome_app/presentation/home/page/home_page.dart';
import 'package:awesome_app/presentation/home/widgets/grid_movie_section.dart';
import 'package:awesome_app/presentation/home/widgets/list_movie_section.dart';
import 'package:awesome_app/utils/widgets/grid_loading.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements MovieBloc {}

void main() {
  Widget wrapWithBloc(Widget child, MovieBloc bloc) {
    return BlocProvider.value(
      value: bloc,
      child: MaterialApp(home: child),
    );
  }

  late MovieBloc movieBloc;

  setUp(() {
    movieBloc = MockMovieBloc();
  });

  testWidgets('should display grid loading', (WidgetTester tester) async {
    when(() => movieBloc.state).thenReturn(MovieLoading());
    final gridLoading = find.byType(GridLoading);
    await tester.pumpWidget(wrapWithBloc(const HomePage(), movieBloc));
    expect(gridLoading, findsOneWidget);
  });

  testWidgets('should display movie grid', (WidgetTester tester) async {
    when(() => movieBloc.state)
        .thenReturn(const MovieGridSuccess(movies: <Movie>[]));
    final gridMovie = find.byType(GridMovieSection);
    await tester.pumpWidget(wrapWithBloc(const HomePage(), movieBloc));
    expect(gridMovie, findsOneWidget);
  });

  testWidgets('should display movie list', (WidgetTester tester) async {
    when(() => movieBloc.state)
        .thenReturn(const MovieListSuccess(movies: <Movie>[]));
    final listMovie = find.byType(ListMovieSection);
    await tester.pumpWidget(wrapWithBloc(const HomePage(), movieBloc));
    expect(listMovie, findsOneWidget);
  });

  testWidgets('should display error', (WidgetTester tester) async {
    when(() => movieBloc.state)
        .thenReturn(const MovieError(text: 'Fail loaded movies'));
    final error = find.text('Fail loaded movies');
    await tester.pumpWidget(wrapWithBloc(const HomePage(), movieBloc));
    expect(error, findsOneWidget);
  });
}
