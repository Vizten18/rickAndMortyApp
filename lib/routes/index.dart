// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:rick_and_morty_app/routes/router.dart';
import 'package:rick_and_morty_app/routes/shell_branches.dart';
import 'package:rick_and_morty_app/src/widgets/widgets.dart';

/// {@template index_page}
/// The index page of the app. This page is responsible for displaying the
/// scaffold with the bottom navigation bar.
/// {@endtemplate}
class IndexNavigationPage extends StatelessWidget {
  /// {@macro index_page}
  const IndexNavigationPage({
    required this.child,
    required this.routerState,
    this.scaffoldKey,
    super.key,
  });

  final StatefulNavigationShell child;
  final GoRouterState routerState;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      key: AppRouter.rootScaffoldKey,
      appBar: const GlobalAppBar(),
      body: child,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
          selectedLabelStyle: Theme.of(context).textTheme.bodySmall,
          selectedItemColor: Colors.blue,
          onTap: onTap,
          currentIndex: child.currentIndex,
          items: AppShellBranch.values
              .map(
                (e) => BottomNavigationBarItem(
                  label: e.title(context),
                  icon: e.icon(),
                  activeIcon: e.activeIcon(),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void onTap(int i) {
    /// Get current index from current router path
    final currentIndex = AppShellBranch.indexFromName(
      routerState.fullPath?.split('/')[1] ?? '',
    );

    /// If the current index is the same as the tapped index,
    /// navigate back to the root of the current branch.
    ///
    /// This is the expected behavior from apps in both iOS and
    /// Android.
    if (currentIndex == i) {
      return child.goBranch(i, initialLocation: true);
    }

    return child.goBranch(i);
  }
}
