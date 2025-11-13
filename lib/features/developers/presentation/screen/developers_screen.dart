import 'package:dev_gallery/core/configs/theme/app_colors.dart';
import 'package:dev_gallery/core/configs/theme/app_typography.dart';
import 'package:dev_gallery/core/extentions/extentions.dart';
import 'package:dev_gallery/features/developers/domain/entities/developer_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/developers_bloc.dart';
import '../bloc/developers_event.dart';
import '../bloc/developers_state.dart';
import '../widgets/developer_card.dart';

class DevelopersScreen extends HookWidget {
  const DevelopersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = useMemoized(() => sl<DevelopersBloc>());

    useEffect(() {
      bloc.add(const FetchDevelopers());
      return null;
    }, []);

    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(title: Text("Developers", style: AppTypography.heading)),
        body: BlocBuilder<DevelopersBloc, DevelopersState>(
          builder: (context, state) {
            if (state is DevelopersLoading) {
              return const _DevelopersLoading();
            }

            if (state is DevelopersError) {
              return _DevelopersError(message: state.message);
            }

            if (state is DevelopersLoaded) {
              return _DevelopersListView(
                developers: state.developers,
                isOffline: state.isOffline,
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _DevelopersLoading extends StatelessWidget {
  const _DevelopersLoading();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 8,
      itemBuilder: (_, __) => Container(
        height: 78,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.faded(.3),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class _DevelopersError extends StatelessWidget {
  final String message;

  const _DevelopersError({required this.message});

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

class _DevelopersListView extends StatelessWidget {
  final List<DeveloperEntity> developers;
  final bool isOffline;

  const _DevelopersListView({
    required this.developers,
    required this.isOffline,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) =>
              SizeTransition(sizeFactor: animation, child: child),
          child: isOffline
              ? Container(
                  key: const ValueKey("offline-banner"),
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  color: AppColors.accentOrange,
                  child: Text(
                    "You are offline — showing cached developers",
                    style: AppTypography.body.copyWith(color: Colors.black),
                  ),
                )
              : const SizedBox.shrink(key: ValueKey("online-banner")),
        ),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: developers.length,
            itemBuilder: (context, index) {
              return Builder(
                builder: (context) {
                  final dev = developers[index];
                  final bloc = context.read<DevelopersBloc>();
                  // Trigger hybrid fetch for missing details
                  if (dev.name == null) {
                    bloc.add(FetchDeveloperDetails(dev.username));
                  }
                  return DeveloperCard(
                    avatarUrl: dev.avatarUrl,
                    username: dev.username,
                    name: dev.name,
                    bio: dev.bio,
                  ).pb(12);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
