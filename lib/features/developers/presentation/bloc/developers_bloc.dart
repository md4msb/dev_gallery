import 'package:flutter_bloc/flutter_bloc.dart';
import 'developers_event.dart';
import 'developers_state.dart';
import '../../domain/usecases/get_developers_list.dart';

class DevelopersBloc extends Bloc<DevelopersEvent, DevelopersState> {
  final GetDevelopersList _getDevelopersList;

  DevelopersBloc({required GetDevelopersList getDevelopersList})
    : _getDevelopersList = getDevelopersList,
      super(const DevelopersInitial()) {
    on<FetchDevelopers>(_onFetchDevelopers);
  }

  Future<void> _onFetchDevelopers(
    FetchDevelopers event,
    Emitter<DevelopersState> emit,
  ) async {
    emit(const DevelopersLoading());

    final result = await _getDevelopersList();

    result.fold(
      (error) => emit(DevelopersError(message: error)),
      (developers) => emit(DevelopersLoaded(developers: developers)),
    );
  }
}
