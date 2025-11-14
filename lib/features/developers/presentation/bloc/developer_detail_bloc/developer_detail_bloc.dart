import 'package:flutter_bloc/flutter_bloc.dart';
import 'developer_detail_event.dart';
import 'developer_detail_state.dart';
import '../../../domain/usecases/get_developer_details.dart';

class DeveloperDetailBloc extends Bloc<DeveloperDetailEvent, DevDetailState> {
  final GetDeveloperDetails getDeveloperDetails;

  DeveloperDetailBloc({required this.getDeveloperDetails})
    : super(DevDetailInitial()) {
    on<FetchDeveloperDetail>(_onFetchDeveloperDetail);
  }

  Future<void> _onFetchDeveloperDetail(
    FetchDeveloperDetail event,
    Emitter<DevDetailState> emit,
  ) async {
    emit(DevDetailLoading());

    final result = await getDeveloperDetails(event.username);

    result.fold(
      (error) => emit(DevDetailError(error)),
      (developer) => emit(DevDetailLoaded(developer)),
    );
  }
}
