import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/repo_entity.dart';
import '../../domain/usecases/get_repos_list.dart';

part 'repo_event.dart';
part 'repo_state.dart';

class RepoBloc extends Bloc<RepoEvent, RepoState> {
  final GetReposList _getReposList;

  RepoBloc({required GetReposList getReposList})
      : _getReposList = getReposList,
        super(RepoInitial()) {
    on<FetchRepos>(_onFetchRepos);
  }

  Future<void> _onFetchRepos(FetchRepos event, Emitter<RepoState> emit) async {
    emit(RepoLoading());
    final result = await _getReposList(event.username);
    result.fold(
      (error) => emit(RepoError(message: error)),
      (repos) => emit(RepoLoaded(repos: repos)),
    );
  }
}
