// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/extensions.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({
    this.onPressed,
    super.key,
  });
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.black.withOpacity(0.5),
      child: IconButton(
        icon: Icon(
          context.isIOS ? Icons.arrow_back_ios_new : Icons.arrow_back,
        ),
        iconSize: 20,
        color: Colors.white,
        onPressed: onPressed ?? () => Navigator.of(context).pop(),
      ),
    );
  }
}
