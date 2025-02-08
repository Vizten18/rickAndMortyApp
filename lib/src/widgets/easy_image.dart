import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EasyImage extends StatelessWidget {
  const EasyImage({
    required this.imageUrl,
    super.key,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => const BasicSkeleton(),
      errorWidget: (context, url, error) => const BasicSkeleton(),
    );
  }
}

class BasicSkeleton extends StatelessWidget {
  const BasicSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Container(
        height: 290,
        color: Colors.grey[300],
      ),
    );
  }
}
