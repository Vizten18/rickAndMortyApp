import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/domain/use_cases/use_cases.dart';
import 'package:rick_and_morty_app/src/presentation/favorites/bloc/bloc.dart';
import 'package:rick_and_morty_app/src/presentation/favorites/widgets/favorites_body.dart';

/// {@template favorites_page}
/// A description for FavoritesPage
/// {@endtemplate}
class FavoritesPage extends StatelessWidget {
  /// {@macro favorites_page}
  const FavoritesPage({super.key});

  /// The path name of FavoritesPage. Use for navigation.
  static const path = '/$routeName';

  /// The route name of FavoritesPage. Use to navigate
  /// with named routes.
  static const routeName = 'favorites';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesBloc(
        getFavorites: GetFavorites(
          characterRepository: context.read(),
        ),
        dislikeCharacter: DislikeCharacter(
          characterRepository: context.read(),
        ),
      ),
      child: const Scaffold(
        body: FavoritesView(),
      ),
    );
  }
}

// NOTE: Declare all BlocListeners of Favorites here to handle navigation, showing dialogs, etc.
/// {@template favorites_view}
/// Displays the Body of FavoritesView
/// {@endtemplate}
///
class FavoritesView extends StatelessWidget {
  /// {@macro favorites_view}
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const FavoritesBody();
  }
}
