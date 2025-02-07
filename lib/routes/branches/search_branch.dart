import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/routes/branches/base_branch.dart';
import 'package:rick_and_morty_app/routes/indexes/search_index.dart';
import 'package:rick_and_morty_app/routes/shell_branches.dart';

class SearchShellBranch implements AppBaseShellBranch {
  SearchShellBranch() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  StatefulShellBranch get branch => StatefulShellBranch(
        initialLocation: AppShellBranch.search.path,
        navigatorKey: navigatorKey,
        routes: routes,
      );

  @override
  GlobalKey<NavigatorState> navigatorKey;

  @override
  List<RouteBase> get routes => <RouteBase>[
        GoRoute(
          name: AppShellBranch.search.routeName,
          path: AppShellBranch.search.path,
          pageBuilder: (_, __) => const NoTransitionPage(child: IndexSearch()),
        ),
      ];

  @override
  List<RouteBase> rootRoutes(GlobalKey<NavigatorState> rootNavigatorKey) {
    // TODO: implement getRootRoutes
    throw UnimplementedError();
  }
}
