import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rick_and_morty_app/core/helpers/custom_effects.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';

class CharacterStatusTextBuilder extends StatelessWidget {
  const CharacterStatusTextBuilder({
    required this.status,
    this.fontSize = 14,
    super.key,
  });

  final CharacterStatus status;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      status.name,
      style: TextStyle(
        fontSize: fontSize,
        color: status.color,
      ),
    ).animate(
      effects: CustomEffects.comingDown(delay: 250),
    );
  }
}
