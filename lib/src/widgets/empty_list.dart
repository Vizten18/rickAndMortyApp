import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rick_and_morty_app/core/helpers/custom_effects.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ).animate(
            effects: CustomEffects.comingDown(delay: 150),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ).animate(
            effects: CustomEffects.comingDown(delay: 250),
          ),
        ],
      ),
    );
  }
}
