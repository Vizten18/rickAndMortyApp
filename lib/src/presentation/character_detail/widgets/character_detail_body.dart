import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rick_and_morty_app/core/constants.dart';
import 'package:rick_and_morty_app/core/extensions.dart';
import 'package:rick_and_morty_app/core/helpers/custom_effects.dart';
import 'package:rick_and_morty_app/src/presentation/character_detail/bloc/bloc.dart';
import 'package:rick_and_morty_app/src/widgets/widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';

// NOTE: Declare all the UI widgets here, including BlocBuilders.
/// {@template character_detail_body}
/// Body of the CharacterDetailPage.
/// {@endtemplate}
class CharacterDetailBody extends StatelessWidget {
  /// {@macro character_detail_body}
  const CharacterDetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterDetailBloc, CharacterDetailState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.character.liked != current.character.liked,
      builder: (context, state) {
        if (state.status.isFailure) {
          return CharacterErrorBuilder(
            errorType: state.error!.characterErrorType,
          );
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: state.characterId,
                    child: EasyImage(
                      height: context.mediaQuery.size.height * 0.5,
                      imageUrl: state.characterImage,
                    ),
                  ),
                  const Positioned(
                    top: 50,
                    left: 20,
                    child: GoBackButton(),
                  ),
                ],
              ),
              const SizedBox(height: Constants.padding * 2),
              Skeletonizer(
                enabled: state.status.isLoading,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.margin,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: AutoSizeText(
                              state.character.name,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                            ).animate(
                              effects: CustomEffects.slideInFromLeft(),
                            ),
                          ),
                          const Spacer(),
                          LikedButton(
                            isLiked: state.character.liked,
                            onPressed: () {
                              context.read<CharacterDetailBloc>().add(
                                    const CharacterDetailOnLikePressed(),
                                  );
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CharacterStatusTextBuilder(
                            status: state.character.status,
                            fontSize: 20,
                          ),
                          const SizedBox(width: Constants.padding),
                          GenderWidgetBuilder(gender: state.character.gender),
                        ],
                      ),
                      Visibility(
                        visible: state.character.type.isNotEmpty,
                        child: AutoSizeText(
                          'Type: ${state.character.type}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ).animate(
                          effects: CustomEffects.comingDown(delay: 350),
                        ),
                      ),
                      const SizedBox(height: Constants.padding),
                      const Text(
                        Constants.loremIpsum,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ).animate(
                        effects: CustomEffects.comingDown(
                          delay: 300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
