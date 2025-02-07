import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/routes/branches/base_branch.dart';
import 'package:rick_and_morty_app/routes/indexes/favorites_index.dart';
import 'package:rick_and_morty_app/routes/shell_branches.dart';

class FavoritesShellBranch implements AppBaseShellBranch {
  FavoritesShellBranch() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  StatefulShellBranch get branch => StatefulShellBranch(
        initialLocation: AppShellBranch.favorites.path,
        navigatorKey: navigatorKey,
        routes: routes,
      );

  @override
  GlobalKey<NavigatorState> navigatorKey;

  @override
  List<RouteBase> get routes => <RouteBase>[
        GoRoute(
          name: AppShellBranch.favorites.routeName,
          path: AppShellBranch.favorites.path,
          pageBuilder: (_, __) =>
              const NoTransitionPage(child: IndexFavorites()),
        ),
      ];

  @override
  List<RouteBase> rootRoutes(GlobalKey<NavigatorState> rootNavigatorKey) {
    // TODO: implement getRootRoutes
    throw UnimplementedError();
  }
}
