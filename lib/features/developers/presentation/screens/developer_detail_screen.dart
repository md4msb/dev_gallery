import 'package:dev_gallery/core/configs/theme/app_colors.dart';
import 'package:dev_gallery/core/configs/theme/app_typography.dart';
import 'package:dev_gallery/core/extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/developer_entity.dart';
import '../bloc/developer_detail_bloc/developer_detail_bloc.dart';
import '../bloc/developer_detail_bloc/developer_detail_event.dart';
import '../bloc/developer_detail_bloc/developer_detail_state.dart';
import '../widgets/avatar_photo.dart';

class DeveloperDetailScreen extends HookWidget {
  final String username;

  const DeveloperDetailScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    final bloc = useMemoized(() => sl<DeveloperDetailBloc>());

    useEffect(() {
      bloc.add(FetchDeveloperDetail(username));
      return null;
    }, []);

    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocBuilder<DeveloperDetailBloc, DevDetailState>(
          builder: (context, state) {
            return switch (state) {
              DevDetailLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              DevDetailError() => Center(
                child: Text(
                  state.message,
                  style: AppTypography.body.copyWith(color: Colors.redAccent),
                ),
              ).p(16),
              DevDetailLoaded() => _ProfileSection(developer: state.developer),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final DeveloperEntity developer;
  const _ProfileSection({required this.developer});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AvatarPhoto(
                radius: 40,
                url: developer.avatarUrl,
                username: developer.username,
              ),
              Gap(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    developer.name ?? developer.username,
                    style: AppTypography.title,
                  ),
                  Gap(4),
                  Text(
                    '@${developer.username}',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondaryDark,
                    ),
                  ),
                  Gap(6),
                  Row(
                    children: [
                      const Icon(Icons.people_outline_rounded, size: 18),
                      Gap(6),
                      Text.rich(
                        style: AppTypography.body,
                        TextSpan(
                          text: '${developer.followers ?? 0} ',
                          children: [
                            TextSpan(
                              style: AppTypography.body.copyWith(
                                color: AppColors.textSecondaryDark,
                              ),
                              text: 'followers',
                            ),
                          ],
                        ),
                      ),
                      Gap(12),
                      const Icon(Icons.person_add_alt, size: 18),
                      Gap(6),
                      Text.rich(
                        style: AppTypography.body,
                        TextSpan(
                          text: '${developer.following ?? 0} ',
                          children: [
                            TextSpan(
                              style: AppTypography.body.copyWith(
                                color: AppColors.textSecondaryDark,
                              ),
                              text: 'following',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          Gap(16),
          // Bio
          if (developer.bio != null)
            Text(developer.bio!, style: AppTypography.body),
          Gap(16),

          // Location, Website, Joined Date
          Row(
            children: [
              const Icon(Icons.place, size: 18),
              Gap(8),

              Text(
                "San Francisco, CA", // You will replace this later with real API field if needed
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondaryDark,
                ),
              ),

              Gap(12),

              const Icon(Icons.calendar_month, size: 18),
              Gap(8),
              Text(
                "Joined Jan 2020", // Placeholder until you add joined date
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondaryDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
