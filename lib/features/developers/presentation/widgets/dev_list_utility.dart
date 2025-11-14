import 'package:dev_gallery/core/configs/theme/app_typography.dart';
import 'package:dev_gallery/core/extentions/extentions.dart';
import 'package:dev_gallery/core/widgets/app_tile.dart';
import 'package:dev_gallery/core/widgets/shimmer.dart';
import 'package:flutter/material.dart';

class DevListUtils {
  const DevListUtils._();
  static Widget get devsLoading => _DevsLoading();
  static Widget devsError(String message) => _DevsError(message: message);
}

class _DevsLoading extends StatelessWidget {
  const _DevsLoading();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 8,
      itemBuilder: (_, __) => AppTile(
        leading: const ShimmerCircle(radius: 32),
        title: const ShimmerText(width: 120, height: 16).pb(8),
        subtitle: const ShimmerText(width: 100, height: 14),
      ),
    );
  }
}

class _DevsError extends StatelessWidget {
  final String message;

  const _DevsError({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: AppTypography.body.copyWith(color: Colors.redAccent),
      ).p(16),
    );
  }
}
