import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';
import 'package:rick_and_morty_app/src/presentation/home/bloc/bloc.dart';
import 'package:rick_and_morty_app/src/widgets/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == HomeStatus.failure) {
          return const Center(
            child: Text('Failed to load characters'),
          );
        }

        return Skeletonizer(
          enabled: state.status.isLoading,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent &&
                  !state.status.isLoading &&
                  state.pageInfo?.nextPage != null) {
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
                itemCount: state.status == HomeStatus.loading
                    ? 5
                    : state.characters.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == state.characters.length) {
                    return const CharacterCard(character: Character.empty());
                  }
                  final character = state.status == HomeStatus.loading
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
