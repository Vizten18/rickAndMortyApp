import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rick_and_morty_app/core/app_assets.dart';
import 'package:rick_and_morty_app/core/errors/character_error.dart';
import 'package:rick_and_morty_app/core/helpers/custom_effects.dart';
import 'package:rick_and_morty_app/l10n/l10n.dart';
import 'package:rick_and_morty_app/src/widgets/widgets.dart';

class CharacterErrorBuilder extends StatelessWidget {
  const CharacterErrorBuilder({
    required this.errorType,
    super.key,
  });

  final CharacterErrorType errorType;

  @override
  Widget build(BuildContext context) {
    switch (errorType) {
      case CharacterErrorType.network:
        return CustomErrorWidget(
          image: AppAssets.morty1,
          title: context.l10n.internetConnectionLostTitle,
          subtitle: context.l10n.internetConnectionLostSubtitle,
        );
      case CharacterErrorType.notFound:
        return CustomErrorWidget(
          image: AppAssets.spaceShip,
          title: context.l10n.notFoundTitle,
          subtitle: context.l10n.notFoundSubtitle,
          animate: true,
        );
      case CharacterErrorType.unknown:
      case CharacterErrorType.server:
      case CharacterErrorType.client:
        return CustomErrorWidget(
          image: AppAssets.morty2,
          title: context.l10n.unexpectedErrorTitle,
          subtitle: context.l10n.unexpectedErrorSubtitle,
        );
    }
  }
}

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    required this.image,
    required this.title,
    required this.subtitle,
    this.animate = false,
    super.key,
  });

  final String image;
  final String title;
  final String subtitle;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (animate)
          Image.asset(image).animate(
            onPlay: (controller) => controller.repeat(reverse: true),
            effects: CustomEffects.floatingEffect(),
          )
        else
          Image.asset(image),
        ErrorTitleAndSubtitle(
          title: title,
          subtitle: subtitle,
        ),
      ],
    );
  }
}
