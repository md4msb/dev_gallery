import 'package:dev_gallery/core/configs/theme/app_colors.dart';
import 'package:dev_gallery/core/configs/theme/app_typography.dart';
import 'package:dev_gallery/core/extentions/extentions.dart';
import 'package:dev_gallery/core/widgets/app_tile.dart';
import 'package:dev_gallery/core/widgets/shimmer.dart';
import 'package:dev_gallery/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../bloc/repo_bloc.dart';

class ReposListview extends HookWidget {
  final String username;
  const ReposListview({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    final bloc = useMemoized(() => sl<RepoBloc>());

    useEffect(() {
      bloc.add(FetchRepos(username));
      return null;
    }, []);

    return BlocProvider.value(
      value: bloc,
      child: Expanded(
        child: BlocBuilder<RepoBloc, RepoState>(
          builder: (context, state) {
            return switch (state) {
              RepoLoading() => _buildSkeletonLoading(),
              RepoError() => Center(child: Text(state.message)),
              RepoLoaded() => _buildReposListview(state, context),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }

  ListView _buildReposListview(RepoLoaded state, BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.repos.length,
      itemBuilder: (_, index) {
        final repo = state.repos[index];
        final secondary = Theme.of(context).brightness == Brightness.dark
            ? AppColors.textSecondaryDark
            : AppColors.textSecondaryLight;
        return AppTile(
          title: Text(
            repo.name,
            style: AppTypography.title.copyWith(fontWeight: FontWeight.w500),
          ).pb(4),
          subtitle: Text(
            (repo.description != null) ? repo.description! : "No description",
            style: AppTypography.body.copyWith(color: secondary),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ).pb(4),
          body: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star_border_rounded, size: 18, color: secondary),
              const SizedBox(width: 4),
              Text(
                repo.starCount.toString(),
                style: AppTypography.body.copyWith(color: secondary),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSkeletonLoading() => ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: 5,
    itemBuilder: (_, __) => AppTile(
      title: const ShimmerText(width: 110, height: 16).pb(8),
      subtitle: const ShimmerText(width: 280, height: 14).pb(8),
      body: const ShimmerText(width: 220, height: 14),
    ),
  );
}
