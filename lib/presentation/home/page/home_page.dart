import 'package:awesome_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:awesome_app/blocs/movie_bloc/movie_event.dart';
import 'package:awesome_app/blocs/movie_bloc/movie_state.dart';
import 'package:awesome_app/presentation/home/widgets/grid_movie_section.dart';
import 'package:awesome_app/presentation/home/widgets/item_pop_up_menu.dart';
import 'package:awesome_app/presentation/home/widgets/list_movie_section.dart';
import 'package:awesome_app/utils/widgets/grid_loading.dart';
import 'package:awesome_app/utils/widgets/my_alert_dialog.dart';
import 'package:awesome_app/utils/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          (0.80 * scrollController.position.maxScrollExtent)) {
        if (context.read<MovieBloc>().state.movieStatus ==
            MovieStatus.gridLoaded) {
          context.read<MovieBloc>().add(LoadMoreMovieGrid());
        } else {
          context.read<MovieBloc>().add(LoadMoreListMovie());
        }
      }
    });
    return Scaffold(
      appBar: MyAppBar(
        title: 'Home',
        actions: [
          BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
            return PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'listView':
                    if (state.movieStatus == MovieStatus.gridLoaded) {
                      context.read<MovieBloc>().add(MovieList());
                    }
                    break;
                  case 'gridView':
                    if (state.movieStatus == MovieStatus.listLoaded) {
                      context.read<MovieBloc>().add(MovieGrid());
                    }
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'listView',
                  child: ItemPopUpMenu(icons: Icons.list, title: 'List View'),
                ),
                const PopupMenuItem(
                    value: 'gridView',
                    child: ItemPopUpMenu(
                        icons: Icons.grid_3x3, title: 'Grid View')),
              ],
            );
          })
        ],
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () {
          if (context.read<MovieBloc>().state.movieStatus ==
              MovieStatus.gridLoaded) {
            context.read<MovieBloc>().add(MovieGrid());
          } else {
            context.read<MovieBloc>().add(MovieList());
          }
          return Future.value();
        },
        child: BlocListener<MovieBloc, MovieState>(
          listener: (context, state) {
            if (state.movieStatus == MovieStatus.error) {
              showMyDialog(context, state.errorMessage, onPressed: () {
                context.read<MovieBloc>().add(MovieGrid());
                Navigator.of(context).pop();
              });
            }
          },
          child: BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
            return switch (state.movieStatus) {
              MovieStatus.loading => const GridLoading(),
              MovieStatus.gridLoaded => GridMovieSection(
                  controller: scrollController,
                  movies: state.movies,
                ),
              MovieStatus.listLoaded => ListMovieSection(
                  controller: scrollController,
                  movies: state.movies,
                ),
              _ => const SizedBox()
            };
          }),
        ),
      ),
    );
  }
}
