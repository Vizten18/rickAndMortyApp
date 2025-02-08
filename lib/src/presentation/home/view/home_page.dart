import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/domain/use_cases/use_cases.dart';
import 'package:rick_and_morty_app/src/presentation/home/bloc/bloc.dart';
import 'package:rick_and_morty_app/src/presentation/home/widgets/home_body.dart';

/// {@template home_page}
/// A description for HomePage
/// {@endtemplate}
class HomePage extends StatelessWidget {
  /// {@macro home_page}
  const HomePage({super.key});

  /// The path name of HomePage. Use for navigation.
  static const path = '/$routeName';

  /// The route name of HomePage. Use to navigate
  /// with named routes.
  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        getCharacters: GetCharacters(characterRepository: context.read()),
      ),
      child: const SafeArea(
        child: Scaffold(
          body: HomeView(),
        ),
      ),
    );
  }
}

// NOTE: Declare all BlocListeners of Home here to handle navigation, showing dialogs, etc.
/// {@template home_view}
/// Displays the Body of HomeView
/// {@endtemplate}
///
class HomeView extends StatelessWidget {
  /// {@macro home_view}
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeBody();
  }
}
