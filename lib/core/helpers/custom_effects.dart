import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomEffects {
  CustomEffects();

  /// Fade in effect for lists. Fades in each item subsequently.
  static List<Effect<dynamic>> listDominoesFadeIn(int index) => [
        FadeEffect(
          begin: 0,
          end: 1,
          delay: 05.ms * index,
        ),
      ];

  static List<Effect<dynamic>> fadeInSlideOutX({
    bool reversed = false,
    int delay = 0,
  }) =>
      [
        FadeEffect(
          begin: 0,
          end: 1,
          delay: Duration(milliseconds: delay),
        ),
        SlideEffect(
          begin: reversed ? const Offset(0.5, 0) : const Offset(-0.5, 0),
          end: Offset.zero,
          curve: Curves.easeOutCubic,
          delay: Duration(milliseconds: delay),
        ),
      ];

  static List<Effect<dynamic>> comingDown({
    int delay = 0,
  }) =>
      [
        SlideEffect(
          begin: const Offset(0, 0.25),
          end: Offset.zero,
          curve: Curves.easeOutCubic,
          duration: const Duration(milliseconds: 550),
          delay: Duration(milliseconds: delay),
        ),
        FadeEffect(
          begin: 0,
          end: 1,
          delay: Duration(milliseconds: delay),
          duration: const Duration(milliseconds: 550),
        ),
      ];

  static List<Effect<dynamic>> floatingEffect() => [
        const MoveEffect(
          begin: Offset(0, -8),
          end: Offset(0, 8),
          duration: Duration(seconds: 2),
          curve: Curves.easeInOut,
        ),
      ];

  static List<Effect<dynamic>> slideInFromLeft() => [
        const SlideEffect(
          begin: Offset(-1, 0),
          end: Offset.zero,
          curve: Curves.easeOutCubic,
          duration: Duration(milliseconds: 550),
        ),
        const FadeEffect(
          begin: 0,
          end: 1,
          duration: Duration(milliseconds: 550),
        ),
      ];

  static List<Effect<dynamic>> slideInFromRight() => [
        const SlideEffect(
          begin: Offset(1, 0),
          end: Offset.zero,
          curve: Curves.easeOutCubic,
          duration: Duration(milliseconds: 550),
        ),
        const FadeEffect(
          begin: 0,
          end: 1,
          duration: Duration(milliseconds: 550),
        ),
      ];
}
