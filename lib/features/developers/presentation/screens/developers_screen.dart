import 'package:dev_gallery/core/configs/theme/app_typography.dart';
import 'package:dev_gallery/core/extentions/extentions.dart';
import 'package:dev_gallery/core/widgets/app_tile.dart';
import 'package:dev_gallery/core/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/developers_bloc/developers_bloc.dart';
import '../widgets/developers_listview.dart';

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
        appBar: AppBar(
          centerTitle: false,
          title: Text("Dev Gallery", style: AppTypography.heading),
        ),
        body: BlocBuilder<DevelopersBloc, DevelopersState>(
          builder: (context, state) {
            return switch (state) {
              DevelopersLoading() => const _DevsLoading(),
              DevelopersError() => _DevsError(message: state.message),
              DevelopersLoaded() => DevsListView(
                developers: state.developers,
                isOffline: state.isOffline,
              ),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
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
