import 'package:dev_gallery/core/configs/router/router_names.dart';
import 'package:dev_gallery/core/configs/theme/app_colors.dart';
import 'package:dev_gallery/core/configs/theme/app_typography.dart';
import 'package:dev_gallery/core/widgets/offline_banner.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/developer_entity.dart';
import 'avatar_photo.dart';
import 'developer_tile.dart';

class DevsListView extends StatelessWidget {
  final List<DeveloperEntity> developers;
  final bool isOffline;

  const DevsListView({
    super.key,
    required this.developers,
    required this.isOffline,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OfflineBanner(isOffline: isOffline),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: developers.length,
            itemBuilder: (context, index) {
              final dev = developers[index];
              return DeveloperTile(
                onTap: () => context.pushNamed(
                  RouteNames.developerDetails,
                  pathParameters: {'username': dev.username},
                ),
                leading: AvatarPhoto(
                  radius: 32,
                  url: dev.avatarUrl,
                  username: dev.username,
                ),
                title: dev.name == null
                    ? Text(dev.username, style: AppTypography.title)
                    : Text(dev.name!, style: AppTypography.title),
                subtitle: Text(
                  "@${dev.username}",
                  style: AppTypography.body.copyWith(color: AppColors.primary),
                ),
                trailing: const Icon(Icons.favorite_border_rounded),
              );
            },
          ),
        ),
      ],
    );
  }
}
