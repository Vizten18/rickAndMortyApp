import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';
import 'package:rick_and_morty_app/src/presentation/search/search.dart';
import 'package:rick_and_morty_app/src/widgets/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchList extends StatelessWidget {
  const SearchList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.paginationStatus != current.paginationStatus,
      builder: (context, state) {
        return Expanded(
          child: Skeletonizer(
            enabled: state.status.isLoading,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (state.canPaginate(scrollInfo)) {
                  context
                      .read<SearchBloc>()
                      .add(const SearchOnScrollEndReached());
                }
                return false;
              },
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<SearchBloc>().add(const SearchOnRefresh());
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      state.status.isLoading ? 5 : state.characters.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == state.characters.length) {
                      if (state.pageInfo?.nextPage == null ||
                          state.characters.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return state.paginationStatus.isLoading
                          ? const CharacterCard(character: Character.empty())
                          : const SizedBox.shrink();
                    }
                    final character = state.status.isLoading
                        ? const Character.empty()
                        : state.characters[index];
                    return CharacterCard(
                      character: character,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
