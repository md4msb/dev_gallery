import 'package:dev_gallery/core/configs/theme/app_radius.dart';
import 'package:dev_gallery/core/extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../configs/theme/app_colors.dart';
import '../configs/theme/app_typography.dart';

class OfflineBanner extends StatelessWidget {
  final bool isOffline;
  const OfflineBanner({super.key, required this.isOffline});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) =>
          SizeTransition(sizeFactor: animation, child: child),
      child: isOffline
          ? Container(
              key: const ValueKey("offline-banner"),
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.accentOrange.faded(0.12),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.accentOrange.faded(0.4)),
              ),

              child: Row(
                children: [
                  Icon(Icons.wifi_off_rounded, color: AppColors.accentOrange),
                  Gap(16),
                  Text(
                    "You are currently offline",
                    style: AppTypography.body.copyWith(
                      color: AppColors.accentOrange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(key: ValueKey("online-banner")),
    );
  }
}
