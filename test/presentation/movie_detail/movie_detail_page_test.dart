import 'package:awesome_app/blocs/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:awesome_app/blocs/movie_detail_bloc/movie_detail_event.dart';
import 'package:awesome_app/blocs/movie_detail_bloc/movie_detail_state.dart';
import 'package:awesome_app/data/models/movie.dart';
import 'package:awesome_app/presentation/home/widgets/grid_movie_section.dart';
import 'package:awesome_app/presentation/movie_detail/widgets/movie_detail_section.dart';
import 'package:awesome_app/utils/widgets/grid_loading.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MockMovie extends Mock implements Movie {}

void main() {
  Widget wrapWithBloc(Widget child, MovieDetailBloc bloc) {
    return MaterialApp(
      home: BlocProvider<MovieDetailBloc>.value(
        value: bloc,
        child: child,
      ),
    );
  }

  late MovieDetailBloc movieDetailBloc;

  setUp(() {
    movieDetailBloc = MockMovieDetailBloc();
  });

  testWidgets('should display grid loading', (WidgetTester tester) async {
    when(() => movieDetailBloc.state).thenReturn(MoviesSimilarLoading());
    await tester.pumpWidget(
        wrapWithBloc(MovieDetailSection(movie: MockMovie()), movieDetailBloc));
    final gridLoading = find.byType(GridLoading);
    expect(gridLoading, findsOneWidget);
  });

  testWidgets('should display movie grid', (WidgetTester tester) async {
    when(() => movieDetailBloc.state)
        .thenReturn(const MoviesSimilarSuccess(movies: <Movie>[]));
    final gridMovie = find.byType(GridMovieSection);
    await tester.pumpWidget(
        wrapWithBloc(MovieDetailSection(movie: MockMovie()), movieDetailBloc));
    expect(gridMovie, findsOneWidget);
  });

  testWidgets('should display error', (WidgetTester tester) async {
    when(() => movieDetailBloc.state)
        .thenReturn(const MoviesSimilarError(text: 'Fail loaded movies'));
    final error = find.text('Fail loaded movies');
    await tester.pumpWidget(
        wrapWithBloc(MovieDetailSection(movie: MockMovie()), movieDetailBloc));
    expect(error, findsOneWidget);
  });
}
