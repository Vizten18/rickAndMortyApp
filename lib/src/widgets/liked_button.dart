import 'package:flutter/material.dart';

class LikedButton extends StatelessWidget {
  const LikedButton({
    required this.isLiked,
    required this.onPressed,
    super.key,
  });

  final bool isLiked;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Icon(
          size: 30,
          isLiked ? Icons.favorite : Icons.favorite_border,
          key: ValueKey<bool>(isLiked),
          color: isLiked ? Colors.red : Colors.grey,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
