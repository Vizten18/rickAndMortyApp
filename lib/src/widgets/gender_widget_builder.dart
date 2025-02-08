// ignore_for_file: no_default_cases

import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/domain/entities/entities.dart';

class GenderWidgetBuilder extends StatelessWidget {
  const GenderWidgetBuilder({
    required this.gender,
    super.key,
  });
  final GenderType gender;

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color iconColor;

    switch (gender) {
      case GenderType.male:
        iconData = Icons.male;
        iconColor = Colors.blue;
      case GenderType.female:
        iconData = Icons.female;
        iconColor = Colors.pink;
      default:
        iconData = Icons.help_outline;
        iconColor = Colors.grey;
    }

    return Icon(
      iconData,
      color: iconColor,
      size: 28,
    );
  }
}
