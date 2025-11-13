import 'dart:async';

import 'package:dev_gallery/core/network/network_info.dart';
import 'package:dev_gallery/features/developers/domain/usecases/get_developer_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'developers_event.dart';
import 'developers_state.dart';
import '../../domain/usecases/get_developers_list.dart';

class DevelopersBloc extends Bloc<DevelopersEvent, DevelopersState> {
  final GetDevelopersList getDevelopersList;
  final GetDeveloperDetails getDeveloperDetails;
  final NetworkInfo networkInfo;

  StreamSubscription? _networkSub;

  DevelopersBloc({
    required this.getDevelopersList,
    required this.getDeveloperDetails,
    required this.networkInfo,
  }) : super(const DevelopersInitial()) {
    on<FetchDevelopers>(_onFetchDevelopers);
    on<NetworkStatusChanged>(_onNetworkChanged);
    on<FetchDeveloperDetails>(_onFetchDeveloperDetails);

    // Listen for connectivity changes
    _networkSub = networkInfo.onStatusChange.listen((connected) {
      add(NetworkStatusChanged(isConnected: connected));
    });
  }

  Future<void> _onFetchDevelopers(
    FetchDevelopers event,
    Emitter<DevelopersState> emit,
  ) async {
    emit(const DevelopersLoading());

    final result = await getDevelopersList();

    result.fold(
      (error) => emit(DevelopersError(message: error)),
      (developers) => emit(DevelopersLoaded(developers: developers)),
    );
  }

  Future<void> _onFetchDeveloperDetails(
    FetchDeveloperDetails event,
    Emitter<DevelopersState> emit,
  ) async {
    if (state is! DevelopersLoaded) return;

    final current = state as DevelopersLoaded;

    // Skip if already loading
    if (current.loadingDetails.contains(event.username)) return;

    // Mark this developer as loading
    final newLoading = Set<String>.from(current.loadingDetails)
      ..add(event.username);
    emit(current.copyWith(loadingDetails: newLoading));

    final detailResult = await getDeveloperDetails(event.username);

    detailResult.fold(
      (error) {
        // Remove from loading list
        final removedLoading = Set<String>.from(newLoading)
          ..remove(event.username);
        emit(current.copyWith(loadingDetails: removedLoading));
      },
      (updatedDev) {
        // Update this developer's info in the list
        final updatedList = current.developers.map((d) {
          return d.username == updatedDev.username ? updatedDev : d;
        }).toList();

        final removedLoading = Set<String>.from(newLoading)
          ..remove(event.username);

        emit(
          current.copyWith(
            developers: updatedList,
            loadingDetails: removedLoading,
          ),
        );
      },
    );
  }

  void _onNetworkChanged(
    NetworkStatusChanged event,
    Emitter<DevelopersState> emit,
  ) {
    if (state is DevelopersLoaded) {
      emit((state as DevelopersLoaded).copyWith(isOffline: !event.isConnected));
    }
  }

  @override
  Future<void> close() {
    _networkSub?.cancel();
    return super.close();
  }
}
