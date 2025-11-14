import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../configs/theme/app_colors.dart';
import '../configs/theme/app_radius.dart';

class AppTile extends StatelessWidget {
  final Function()? onTap;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? body;
  final Widget? trailing;

  const AppTile({
    super.key,
    this.onTap,
    this.leading,
    this.title,
    this.subtitle,
    this.body,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.borderDark
                : AppColors.borderLight,
          ),
        ),
        child: Row(
          children: [
            leading ?? SizedBox.shrink(),
            Gap(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title ?? SizedBox.shrink(),
                  subtitle ?? SizedBox.shrink(),
                  body ?? SizedBox.shrink(),
                ],
              ),
            ),
            trailing ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
