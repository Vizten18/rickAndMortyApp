import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/routes/shell_branches.dart';

class NavigationUtils {
  static String getCurrentPathPrefix(BuildContext context) {
    final router = GoRouter.of(context);
    final location = router.routerDelegate.currentConfiguration.uri.toString();
    if (location.startsWith(AppShellBranch.home.path)) {
      return AppShellBranch.home.path;
    } else if (location.startsWith(AppShellBranch.search.path)) {
      return AppShellBranch.search.path;
    } else if (location.startsWith(AppShellBranch.favorites.path)) {
      return AppShellBranch.favorites.path;
    }
    return '';
  }
}
