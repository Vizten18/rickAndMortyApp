import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';
import 'package:rick_and_morty_app/src/presentation/home/home.dart';
import 'package:rick_and_morty_app/src/widgets/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CharacterList extends StatelessWidget {
  const CharacterList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.paginationStatus != current.paginationStatus,
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.status.isLoading,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (state.canPaginate(scrollInfo)) {
                context.read<HomeBloc>().add(const HomeOnScrollEndReached());
              }
              return false;
            },
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(const HomeOnRefresh());
              },
              child: ListView.builder(
                shrinkWrap: true,
                itemCount:
                    state.status.isLoading ? 5 : state.characters.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == state.characters.length) {
                    return const CharacterCard(character: Character.empty());
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
        );
      },
    );
  }
}
