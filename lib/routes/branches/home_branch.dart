import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/core/helpers/navigation_animation.dart';
import 'package:rick_and_morty_app/routes/branches/base_branch.dart';
import 'package:rick_and_morty_app/routes/indexes/home_index.dart';
import 'package:rick_and_morty_app/routes/shell_branches.dart';
import 'package:rick_and_morty_app/src/presentation/character_detail/character_detail.dart';

class HomeShellBranch implements AppBaseShellBranch {
  HomeShellBranch() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  StatefulShellBranch get branch => StatefulShellBranch(
        initialLocation: AppShellBranch.home.path,
        navigatorKey: navigatorKey,
        routes: routes,
      );

  @override
  GlobalKey<NavigatorState> navigatorKey;

  @override
  List<RouteBase> get routes => <RouteBase>[
        GoRoute(
          name: AppShellBranch.home.routeName,
          path: AppShellBranch.home.path,
          pageBuilder: (context, state) {
            return buildPageWithFadeTransition<CustomTransitionPage<dynamic>>(
              context: context,
              state: state,
              child: const IndexHome(),
            );
          },
        ),
      ];

  @override
  List<RouteBase> rootRoutes(GlobalKey<NavigatorState> rootNavigatorKey) {
    return [
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '${AppShellBranch.home.path}/${CharacterDetailPage.routeName}',
        builder: (context, state) {
          final queryParameters = state.uri.queryParameters;
          final params = CharacterDetailParams.fromMap(queryParameters);

          return CharacterDetailPage(params: params);
        },
      ),
    ];
  }
}
