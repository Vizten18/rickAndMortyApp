import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/routes/shell_branches.dart';
import 'package:rick_and_morty_app/src/presentation/splash/bloc/bloc.dart';
import 'package:rick_and_morty_app/src/presentation/splash/widgets/splash_body.dart';

/// {@template splash_page}
/// A description for SplashPage
/// {@endtemplate}
class SplashPage extends StatelessWidget {
  /// {@macro splash_page}
  const SplashPage({super.key});

  /// The path name of SplashPage. Use for navigation.
  static const path = '/$routeName';

  /// The route name of SplashPage. Use to navigate
  /// with named routes.
  static const routeName = 'splash';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(),
      child: const Scaffold(
        body: SplashView(),
      ),
    );
  }
}

// NOTE: Declare all BlocListeners of Splash here to handle navigation, showing dialogs, etc.
/// {@template splash_view}
/// Displays the Body of SplashView
/// {@endtemplate}
///
class SplashView extends StatelessWidget {
  /// {@macro splash_view}
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      context.pushReplacement(AppShellBranch.home.path);
    });

    return const SplashBody();
  }
}
