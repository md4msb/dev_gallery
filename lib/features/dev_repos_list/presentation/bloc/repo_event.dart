part of 'repo_bloc.dart';

abstract class RepoEvent extends Equatable {
  const RepoEvent();

  @override
  List<Object?> get props => [];
}

class FetchRepos extends RepoEvent {
  final String username;
  const FetchRepos(this.username);

  @override
  List<Object?> get props => [username];
}
