part of 'developers_bloc.dart';


abstract class DevelopersEvent extends Equatable {
  const DevelopersEvent();

  @override
  List<Object?> get props => [];
}

class FetchDevelopers extends DevelopersEvent {
  const FetchDevelopers();
}

class FetchDeveloperDetails extends DevelopersEvent {
  final String username;

  const FetchDeveloperDetails(this.username);

  @override
  List<Object?> get props => [username];
}

class NetworkStatusChanged extends DevelopersEvent {
  final bool isConnected;

  const NetworkStatusChanged({required this.isConnected});

  @override
  List<Object?> get props => [isConnected];
}
