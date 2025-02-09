import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rick_and_morty_app/core/app_assets.dart';
import 'package:rick_and_morty_app/core/constants.dart';
import 'package:rick_and_morty_app/core/helpers/custom_effects.dart';
import 'package:rick_and_morty_app/src/presentation/splash/bloc/bloc.dart';

// NOTE: Declare all the UI widgets here, including BlocBuilders.
/// {@template splash_body}
/// Body of the SplashPage.
/// {@endtemplate}
class SplashBody extends StatelessWidget {
  /// {@macro splash_body}
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1E2838),
                Color(0xFF0E131A),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.rickAndMortyLogo,
              ).animate(
                effects: CustomEffects.comingDown(delay: 150),
              ),
              const SizedBox(height: Constants.padding),
              const Text(
                'Created By: Vicente Herrera (Vizten18)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ).animate(
                effects: CustomEffects.comingDown(delay: 250),
              ),
            ],
          ),
        );
      },
    );
  }
}
