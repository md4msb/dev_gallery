import 'package:dev_gallery/core/configs/router/router_names.dart';
import 'package:dev_gallery/core/configs/theme/app_colors.dart';
import 'package:dev_gallery/core/configs/theme/app_typography.dart';
import 'package:dev_gallery/core/extentions/extentions.dart';
import 'package:dev_gallery/core/widgets/app_tile.dart';
import 'package:dev_gallery/core/widgets/offline_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/developer_entity.dart';
import '../bloc/developers_bloc/developers_bloc.dart';
import 'avatar_photo.dart';

class DevsListView extends HookWidget {
  final List<DeveloperEntity> developers;
  final bool isOffline;

  const DevsListView({
    super.key,
    required this.developers,
    required this.isOffline,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DevelopersBloc>();
    final searchController = useTextEditingController();
    final focusNode = useFocusNode();
    final searchText = useState('');

    return Column(
      children: [
        OfflineBanner(isOffline: isOffline),

        TextField(
          controller: searchController,
          focusNode: focusNode,
          onChanged: (value) {
            searchText.value = value;
            bloc.add(SearchDevelopers(value));
          },
          decoration: InputDecoration(
            hintText: "Search developers...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            suffixIcon: searchText.value.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchText.value = '';
                      searchController.clear();
                      focusNode.unfocus();
                      bloc.add(SearchDevelopers(''));
                    },
                  )
                : null,
          ),
        ).p(16),

        Expanded(
          child: (searchController.text.isNotEmpty && developers.isEmpty)
              ? _NoResultsFound(
                  query: searchText.value,
                  onClear: () {
                    searchText.value = '';
                    searchController.clear();
                    focusNode.unfocus();
                    bloc.add(SearchDevelopers(''));
                  },
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: developers.length,
                  itemBuilder: (context, index) {
                    final dev = developers[index];
                    return AppTile(
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
                        style: AppTypography.body.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      trailing: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.favorite_border_rounded),
                          Gap(22),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _NoResultsFound extends StatelessWidget {
  final String query;
  final VoidCallback onClear;

  const _NoResultsFound({required this.query, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No results found for',
              textAlign: TextAlign.center,
              style: AppTypography.body.copyWith(fontSize: 16),
            ),
            Text(
              '"$query"',
              textAlign: TextAlign.center,
              style: AppTypography.title.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            TextButton(onPressed: onClear, child: const Text("Clear Search")),
          ],
        ),
      ),
    );
  }
}
