import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/routes/branches/base_branch.dart';
import 'package:rick_and_morty_app/routes/indexes/favorites_index.dart';
import 'package:rick_and_morty_app/routes/shell_branches.dart';
import 'package:rick_and_morty_app/src/presentation/character_detail/character_detail.dart';

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
    return [
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '${AppShellBranch.favorites.path}/${CharacterDetailPage.routeName}',
        builder: (context, state) {
          final queryParameters = state.uri.queryParameters;
          final params = CharacterDetailParams.fromMap(queryParameters);

          return CharacterDetailPage(params: params);
        },
      ),
    ];
  }
}
