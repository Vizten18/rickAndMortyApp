// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/core/app_assets.dart';
import 'package:rick_and_morty_app/routes/branches/base_branch.dart';

import 'package:rick_and_morty_app/routes/branches/favorites_branch.dart';
import 'package:rick_and_morty_app/routes/branches/home_branch.dart';
import 'package:rick_and_morty_app/routes/branches/search_branch.dart';

/// Defines all the branches for the app, including navigator keys for each
/// branch.
///
/// [AppStatefulShellBranches.branches] returns the [StatefulShellBranch] of
/// each [AppShellBranch] value.
///
/// To add a new branch (a new tab in the bottom navigation bar), you
/// must:
///
/// 1. Declare a new entry for [AppShellBranch].
/// 2. Create a implementation of [AppBaseShellBranch] for the new branch.
///
class AppStatefulShellBranches {
  /// The list of [AppShellBranch] for each [AppShellBranch] value.
  static List<StatefulShellBranch> get branches =>
      AppShellBranch.values.map(_branch).toList();

  static StatefulShellBranch _branch(AppShellBranch page) {
    final favorites = FavoritesShellBranch();
    final home = HomeShellBranch();
    final search = SearchShellBranch();

    switch (page) {
      case AppShellBranch.home:
        return home.branch;
      case AppShellBranch.search:
        return search.branch;
      case AppShellBranch.favorites:
        return favorites.branch;
    }
  }
}

/// {@template app_branches}
/// Defines all the branches for the app. This is used to build the bottom
/// navigation bar, and declares the route name for each branch, aswell as
/// the title and icon for each branch (tab) in the bottom navigation bar.
///
/// The order of each branch in this enum will be the same order it will be
/// displayed in the bottom navigation bar.
/// {@endtemplate}
enum AppShellBranch {
  home('home'),
  search('search'),
  favorites('favorites'),
  ;

  /// {@macro app_branches}
  const AppShellBranch(this.routeName);

  /// The name of this branch initial route. Used to set the [GoRoute.name]
  /// parameter.
  final String routeName;

  /// The path to this branch initial route. Used to set the [GoRoute.path]
  /// parameter, aswell as [StatefulShellBranch.initialLocation]
  ///
  /// This is the same as [routeName], but with a leading `/` i.e.:
  /// `/wallet`.
  String get path => '/$routeName';

  /// Returns the localized title for this branch.
  String title(BuildContext context) {
    // TODO: Localize titles.
    switch (this) {
      case AppShellBranch.home:
        return 'Home';
      case AppShellBranch.search:
        return 'Search';
      case AppShellBranch.favorites:
        return 'Favorites';
    }
  }

  /// Returns the icon for this branch.
  Widget icon() {
    switch (this) {
      case AppShellBranch.home:
        return SvgPicture.asset(
          AppAssets.homeIcon,
          colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
        );
      case AppShellBranch.search:
        return SvgPicture.asset(
          AppAssets.searchIcon,
          colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
        );
      case AppShellBranch.favorites:
        return SvgPicture.asset(
          AppAssets.favoriteIcon,
          colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
        );
    }
  }

  /// Returns the active icon for this branch that would be displayed when the
  /// branch is active or selected.
  Widget activeIcon() {
    switch (this) {
      case AppShellBranch.home:
        return SvgPicture.asset(
          AppAssets.homeIcon,
          colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
        );
      case AppShellBranch.search:
        return SvgPicture.asset(
          AppAssets.searchIcon,
          colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
        );
      case AppShellBranch.favorites:
        return SvgPicture.asset(
          AppAssets.favoriteIcon,
          colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
        );
    }
  }

  /// Returns the index of the given `name` from [AppShellBranch.values] list,
  /// by comparing it to the [routeName] of each branch.
  /// ---
  /// #### Note:
  /// `name` must not be a path, it must be the name of the route. For example,
  /// if you want to get the index of the `loans` branch, you must pass
  /// `loans` as the `name` parameter, not `/loans`.
  static int indexFromName(String name) {
    assert(!name.startsWith('/'), 'name cannot be a path');

    final index = AppShellBranch.values.indexWhere(
      (element) => element.routeName == name,
    );

    if (index == -1) {
      return 0;
    }

    return index;
  }
}
