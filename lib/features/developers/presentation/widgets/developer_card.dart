import 'package:cached_network_image/cached_network_image.dart';
import 'package:dev_gallery/core/configs/theme/app_colors.dart';
import 'package:dev_gallery/core/configs/theme/app_radius.dart';
import 'package:dev_gallery/core/configs/theme/app_typography.dart';
import 'package:dev_gallery/core/extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DeveloperCard extends StatelessWidget {
  final String avatarUrl;
  final String username;
  final String? name;
  final String? bio;
  final VoidCallback? onTap;

  const DeveloperCard({
    super.key,
    required this.avatarUrl,
    required this.username,
    this.name,
    this.bio,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final secondary = Theme.of(context).brightness == Brightness.dark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
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
            // Avatar
            CircleAvatar(
              radius: 32,
              backgroundImage: avatarUrl.isNotEmpty
                  ? CachedNetworkImageProvider(avatarUrl)
                  : null,
              child: avatarUrl.isEmpty
                  ? Text(
                      username[0].toUpperCase(),
                      style: const TextStyle(fontSize: 24),
                    )
                  : null,
            ),
            Gap(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  name == null
                      ? Container(
                          height: 14,
                          width: 120,
                          color: Colors.grey.faded(0.2),
                        )
                      : Text(name!, style: AppTypography.title),
                  Text(
                    "@$username",
                    style: AppTypography.body.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  bio == null
                      ? Container(
                          height: 10,
                          width: 180,
                          color: Colors.grey.faded(0.2),
                        )
                      : Text(
                          bio!,
                          style: AppTypography.caption.copyWith(
                            color: secondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                ],
              ),
            ),
            const Icon(Icons.favorite_border_rounded),
          ],
        ),
      ),
    );
  }
}
