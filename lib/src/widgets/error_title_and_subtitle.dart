import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rick_and_morty_app/core/constants.dart';
import 'package:rick_and_morty_app/core/helpers/custom_effects.dart';

class ErrorTitleAndSubtitle extends StatelessWidget {
  const ErrorTitleAndSubtitle({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constants.margin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ).animate(
            effects: CustomEffects.comingDown(delay: 250),
          ),
          const SizedBox(height: Constants.padding),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
            ),
          ).animate(
            effects: CustomEffects.comingDown(delay: 350),
          ),
        ],
      ),
    );
  }
}
