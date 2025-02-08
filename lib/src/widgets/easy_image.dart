import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EasyImage extends StatelessWidget {
  const EasyImage({
    required this.imageUrl,
    this.height = 290,
    super.key,

  });

  final String imageUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Constants.defaultRadius),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => const BasicSkeleton(),
          errorWidget: (context, url, error) => const BasicSkeleton(),
        ),
      ),
    );
  }
}

class BasicSkeleton extends StatelessWidget {
  const BasicSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Constants.defaultRadius),
        child: Container(
          height: 290,
          width: double.infinity,
          color: Colors.grey[300],
        ),
      ),
    );
  }
}
