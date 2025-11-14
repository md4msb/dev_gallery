import 'package:dev_gallery/core/configs/theme/app_colors.dart';
import 'package:dev_gallery/core/configs/theme/app_typography.dart';
import 'package:dev_gallery/core/extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../domain/entities/developer_entity.dart';
import 'avatar_photo.dart';

class DevProfileSection extends StatelessWidget {
  final DeveloperEntity developer;
  const DevProfileSection({super.key, required this.developer});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Header - Avatar, Name, Username, Followers, Following
        Row(
          children: [
            AvatarPhoto(
              radius: 40,
              url: developer.avatarUrl,
              username: developer.username,
            ).pr(16),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  developer.name ?? developer.username,
                  style: AppTypography.title,
                ).pb(4),

                Text(
                  '@${developer.username}',
                  style: AppTypography.body.copyWith(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ).pb(6),
                // Followers and Following
                Row(
                  children: [
                    followerInfo(context, 'followers', developer.followers),
                    Gap(12),
                    followerInfo(context, 'following', developer.following),
                  ],
                ),
              ],
            ),
          ],
        ),

        Gap(16),
        // Bio
        if (developer.bio != null)
          Text(developer.bio!, style: AppTypography.body).pb(16),

        // Location and Join Date
        Row(
          children: [
            if (developer.location != null)
              devInfoRow(context, Icons.place, developer.location!).pr(12),

            if (developer.createdAt != null)
              devInfoRow(
                context,
                Icons.calendar_month,
                "Joined ${_formatJoinDate(developer.createdAt!)}",
              ),
          ],
        ),
        Gap(20),

        // Public Repos
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Repositories',
              style: AppTypography.body.copyWith(fontWeight: FontWeight.w500),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.blendWith(Colors.grey, 0.75),
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.borderDark
                      : AppColors.borderLight,
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${developer.publicRepos ?? 0}',
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ).p(16);
  }
}

Widget followerInfo(BuildContext context, String type, int? count) {
  final icon = type == 'followers'
      ? Icons.people_outline_rounded
      : Icons.person_add_alt;
  return Row(
    children: [
      Icon(icon, size: 18),
      Gap(6),
      Text.rich(
        style: AppTypography.body,
        TextSpan(
          text: '${count ?? 0} ',
          children: [
            TextSpan(
              style: AppTypography.body.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
              text: type,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget devInfoRow(BuildContext context, IconData icon, String info) {
  return Row(
    children: [
      Icon(icon, size: 18),
      Gap(8),
      Text(
        info,
        style: AppTypography.body.copyWith(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.textSecondaryDark
              : AppColors.textSecondaryLight,
        ),
      ),
    ],
  );
}

String _formatJoinDate(DateTime date) {
  return "${_monthName(date.month)} ${date.year}";
}

String _monthName(int m) {
  const months = [
    "",
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  return months[m];
}
