import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/constants.dart';
import 'package:rick_and_morty_app/core/extensions.dart';

class ModalContainer extends StatelessWidget {
  const ModalContainer({
    super.key,
    this.child,
    this.height,
  });
  final Widget? child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final height = this.height ?? context.mediaQuery.size.height * 0.8;
    return Container(
      width: double.infinity,
      height: height,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Constants.defaultRadius * 3),
          topRight: Radius.circular(Constants.defaultRadius * 3),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Constants.margin,
          vertical: Constants.padding,
        ),
        child: child,
      ),
    );
  }
}
