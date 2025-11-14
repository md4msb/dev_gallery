import 'package:dev_gallery/core/configs/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/developers_bloc/developers_bloc.dart';
import '../widgets/dev_list_utility.dart';
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
              DevelopersLoading() => DevListUtils.devsLoading,
              DevelopersError() => DevListUtils.devsError(state.message),
              DevelopersLoaded() => DevsListView(
                developers: state.searchDevs,
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
