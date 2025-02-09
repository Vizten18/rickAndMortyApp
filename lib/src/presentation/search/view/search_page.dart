import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/domain/use_cases/use_cases.dart';
import 'package:rick_and_morty_app/src/presentation/search/bloc/bloc.dart';
import 'package:rick_and_morty_app/src/presentation/search/widgets/widgets.dart';

/// {@template search_page}
/// A description for SearchPage
/// {@endtemplate}
class SearchPage extends StatelessWidget {
  /// {@macro search_page}
  const SearchPage({super.key});

  /// The path name of SearchPage. Use for navigation.
  static const path = '/$routeName';

  /// The route name of SearchPage. Use to navigate
  /// with named routes.
  static const routeName = 'search';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(
        searchCharacter: SearchCharacter(
          characterRepository: context.read(),
        ),
      ),
      child: const Scaffold(
        body: SearchView(),
      ),
    );
  }
}

// NOTE: Declare all BlocListeners of Search here to handle navigation, showing dialogs, etc.
/// {@template search_view}
/// Displays the Body of SearchView
/// {@endtemplate}
///
class SearchView extends StatelessWidget {
  /// {@macro search_view}
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listenWhen: (previous, current) =>
          previous.modalFilterStatus != current.modalFilterStatus,
      listener: (context, state) {
        if (state.modalFilterStatus.isShow) {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (innerContext) {
              return BlocProvider.value(
                value: context.read<SearchBloc>(),
                child: const SearchFilterModal(),
              );
            },
          ).whenComplete(() {
            if (context.mounted) {
              context.read<SearchBloc>().add(
                    const SearchOnCloseModalFilter(),
                  );
            }
          });
        }
      },
      child: const SearchBody(),
    );
  }
}
