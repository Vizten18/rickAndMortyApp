import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rick_and_morty_app/core/constants.dart';
import 'package:rick_and_morty_app/core/helpers/custom_effects.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';
import 'package:rick_and_morty_app/src/widgets/widgets.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({
    required this.character,
    super.key,
  });
  final Character character;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Constants.margin),
      child: Material(
        borderRadius: BorderRadius.circular(Constants.defaultRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(Constants.defaultRadius),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.padding * 7,
              vertical: Constants.padding * 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  child: EasyImage(imageUrl: character.image),
                ),
                const SizedBox(height: Constants.padding),
                Text(
                  character.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate(
                  effects: CustomEffects.comingDown(delay: 150),
                ),
                CharacterStatusTextBuilder(status: character.status),
                Row(
                  children: [
                    Visibility(
                      visible: character.type.isNotEmpty,
                      child: Expanded(
                        child: AutoSizeText(
                          'Type: ${character.type}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ).animate(
                          effects: CustomEffects.comingDown(delay: 350),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
