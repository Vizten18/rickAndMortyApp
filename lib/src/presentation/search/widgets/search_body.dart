import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/constants.dart';
import 'package:rick_and_morty_app/src/presentation/search/bloc/bloc.dart';
import 'package:rick_and_morty_app/src/presentation/search/widgets/widgets.dart';
import 'package:rick_and_morty_app/src/widgets/widgets.dart';

// NOTE: Declare all the UI widgets here, including BlocBuilders.
/// {@template search_body}
/// Body of the SearchPage.
/// {@endtemplate}
class SearchBody extends StatelessWidget {
  /// {@macro search_body}
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status.isFailure) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(Constants.margin),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SearchInput(),
                    CharacterErrorBuilder(
                      errorType: state.error!.characterErrorType,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(Constants.margin),
            child: Column(
              children: [
                SearchInput(),
                Expanded(child: SearchList()),
              ],
            ),
          ),
        );
      },
    );
  }
}
