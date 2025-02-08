import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/core/constants.dart';
import 'package:rick_and_morty_app/core/helpers/custom_effects.dart';
import 'package:rick_and_morty_app/core/utils/navigation_path_helper.dart';
import 'package:rick_and_morty_app/l10n/l10n.dart';
import 'package:rick_and_morty_app/src/presentation/character_detail/view/character_detail_page.dart';
import 'package:rick_and_morty_app/src/presentation/favorites/bloc/bloc.dart';
import 'package:rick_and_morty_app/src/widgets/widgets.dart';

// NOTE: Declare all the UI widgets here, including BlocBuilders.
/// {@template favorites_body}
/// Body of the FavoritesPage.
/// {@endtemplate}
class FavoritesBody extends StatelessWidget {
  /// {@macro favorites_body}
  const FavoritesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      buildWhen: (previous, current) =>
          previous.characters != current.characters,
      builder: (context, state) {
        if (state.characters.isEmpty) {
          return Center(
            child: EmptyList(
              title: context.l10n.emptyListTitle,
              subtitle: context.l10n.emptyListSubtitle,
            ),
          );
        }

        return SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.characters.length,
                  itemBuilder: (BuildContext context, int index) {
                    final character = state.characters[index];
                    return Dismissible(
                      key: ValueKey(character.id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        context.read<FavoritesBloc>().add(
                              FavoritesOnDislike(character: character),
                            );
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          final pathPrefix =
                              NavigationUtils.getCurrentPathPrefix(context);
                          final params = CharacterDetailParams(
                            characterId: character.id,
                            characterImage: character.image,
                            pathPrefix: pathPrefix,
                          );
                          final path = CharacterDetailPage.generatePath(params);
                          context.push(path);
                        },
                        child: ListTile(
                          title: Text(
                            character.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: CharacterStatusTextBuilder(
                            status: character.status,
                          ),
                          leading: EasyImage(
                            imageUrl: character.image,
                            height: 50,
                            width: 50,
                            isCircle: true,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: Constants.padding),
                child: Text(
                  context.l10n.slideToDelete,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ).animate(
                  effects: CustomEffects.comingDown(delay: 250),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
