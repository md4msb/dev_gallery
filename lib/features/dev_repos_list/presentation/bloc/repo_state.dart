part of 'repo_bloc.dart';

abstract class RepoState extends Equatable {
  const RepoState();

  @override
  List<Object?> get props => [];
}

class RepoInitial extends RepoState {}

class RepoLoading extends RepoState {}

class RepoLoaded extends RepoState {
  final List<RepoEntity> repos;
  const RepoLoaded({required this.repos});

  @override
  List<Object?> get props => [repos];
}

class RepoError extends RepoState {
  final String message;
  const RepoError({required this.message});

  @override
  List<Object?> get props => [message];
}
