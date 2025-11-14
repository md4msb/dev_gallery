import 'package:dev_gallery/core/configs/theme/app_colors.dart';
import 'package:dev_gallery/core/extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart' as shimmer;

/// A shimmer effect for text placeholders
class ShimmerText extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const ShimmerText({
    super.key,
    required this.width,
    this.height = 16,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).brightness == Brightness.dark
        ? AppColors.cardDark.blendWith(Colors.grey.shade700, 0.7)
        : Colors.grey.shade300;

    final highlightColor = Theme.of(context).brightness == Brightness.dark
        ? AppColors.cardDark.blendWith(Colors.grey.shade700, 0.9)
        : Colors.grey.shade100;

    return shimmer.Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      enabled: true,
      period: const Duration(milliseconds: 1500),
      direction: shimmer.ShimmerDirection.ltr,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(4),
        ),
      ),
    );
  }
}

/// A shimmer effect for circular avatars
class ShimmerCircle extends StatelessWidget {
  final double radius;

  const ShimmerCircle({super.key, required this.radius});

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).brightness == Brightness.dark
        ? AppColors.cardDark.blendWith(Colors.grey.shade700, 0.7)
        : Colors.grey.shade300;

    final highlightColor = Theme.of(context).brightness == Brightness.dark
        ? AppColors.cardDark.blendWith(Colors.grey.shade700, 0.9)
        : Colors.grey.shade100;

    return shimmer.Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      enabled: true,
      period: const Duration(milliseconds: 1500),
      direction: shimmer.ShimmerDirection.ltr,
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
      ),
    );
  }
}
