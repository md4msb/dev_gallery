import 'dart:async';
import 'package:dev_gallery/core/network/network_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/developer_entity.dart';
import '../../../domain/usecases/get_developers_list.dart';
part 'developers_event.dart';
part 'developers_state.dart';

class DevelopersBloc extends Bloc<DevelopersEvent, DevelopersState> {
  final GetDevelopersList getDevelopersList;
  final NetworkInfo networkInfo;

  StreamSubscription? _networkSub;

  DevelopersBloc({required this.getDevelopersList, required this.networkInfo})
    : super(const DevelopersInitial()) {
    on<FetchDevelopers>(_onFetchDevelopers);
    on<NetworkStatusChanged>(_onNetworkChanged);
    on<SearchDevelopers>(_onSearchDevelopers);

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
      (developers) => emit(
        DevelopersLoaded(developers: developers, searchDevs: developers),
      ),
    );
  }

  Future<void> _onSearchDevelopers(
    SearchDevelopers event,
    Emitter<DevelopersState> emit,
  ) async {
    if (state is DevelopersLoaded) {
      final current = state as DevelopersLoaded;
      final query = event.query.trim().toLowerCase();

      // If empty query show full list
      if (query.isEmpty) {
        emit(current.copyWith(searchDevs: current.developers));
        return;
      }

      final filtered = current.developers
          .where((dev) => dev.username.toLowerCase().contains(query))
          .toList();

      emit(current.copyWith(searchDevs: filtered));
    }
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
