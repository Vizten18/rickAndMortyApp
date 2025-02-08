import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/routes/branches/favorites_branch.dart';
import 'package:rick_and_morty_app/routes/branches/home_branch.dart';
import 'package:rick_and_morty_app/routes/index.dart';
import 'package:rick_and_morty_app/routes/shell_branches.dart';

/// {@template app_router}
/// The root router for the app. Call [AppRouter.router] to get the router.
/// {@endtemplate}
class AppRouter {
  /// The root navigator key for the app. Use this to navigate from the root
  /// of the router (i.e. out of the bottom navigation bar).
  static final rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root_navigator');

  static final rootScaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'root_scaffold');

  /// The root router for the app. Set [debug] to true to enable debug logging
  /// diagnostics.
  static GoRouter router({bool debug = false}) => GoRouter(
        navigatorKey: rootNavigatorKey,
        debugLogDiagnostics: debug,
        initialLocation: AppShellBranch.values.first.path,
        routes: [
          /// StatefulShellRoute.indexedStack handles the stack of routes of
          /// the bottom navigation bar.
          StatefulShellRoute.indexedStack(
            parentNavigatorKey: rootNavigatorKey,
            branches: AppStatefulShellBranches.branches,
            builder: (_, routerState, child) {
              return IndexNavigationPage(
                routerState: routerState,
                child: child,
              );
            },
          ),
          ...HomeShellBranch().rootRoutes(rootNavigatorKey),
          ...FavoritesShellBranch().rootRoutes(rootNavigatorKey),

          // Add other root routes here.
        ],
      );
}
