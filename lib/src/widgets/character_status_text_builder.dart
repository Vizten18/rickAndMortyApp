import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rick_and_morty_app/core/helpers/custom_effects.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';

class CharacterStatusTextBuilder extends StatelessWidget {
  const CharacterStatusTextBuilder({
    required this.status,
    super.key,
  });

  final CharacterStatus status;

  @override
  Widget build(BuildContext context) {
    return Text(
      status.name,
      style: TextStyle(
        fontSize: 14,
        color: status.color,
      ),
    ).animate(
      effects: CustomEffects.comingDown(delay: 250),
    );
  }
}
