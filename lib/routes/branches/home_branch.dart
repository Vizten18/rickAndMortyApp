import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/routes/branches/base_branch.dart';
import 'package:rick_and_morty_app/routes/indexes/home_index.dart';
import 'package:rick_and_morty_app/routes/shell_branches.dart';

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
          pageBuilder: (_, __) => const NoTransitionPage(child: IndexHome()),
        ),
      ];

  @override
  List<RouteBase> rootRoutes(GlobalKey<NavigatorState> rootNavigatorKey) {
    // TODO: implement getRootRoutes
    throw UnimplementedError();
  }
}
