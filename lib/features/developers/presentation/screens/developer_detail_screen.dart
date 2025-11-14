import 'package:dev_gallery/core/configs/theme/app_typography.dart';
import 'package:dev_gallery/core/extentions/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../injection_container.dart';
import '../bloc/developer_detail_bloc/developer_detail_bloc.dart';
import '../bloc/developer_detail_bloc/developer_detail_event.dart';
import '../bloc/developer_detail_bloc/developer_detail_state.dart';
import '../widgets/dev_profile_section.dart';

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
              DevDetailLoaded() => DevProfileSection(
                developer: state.developer,
              ),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}
