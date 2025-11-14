import 'package:equatable/equatable.dart';

abstract class DeveloperDetailEvent extends Equatable {
  const DeveloperDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchDeveloperDetail extends DeveloperDetailEvent {
  final String username;

  const FetchDeveloperDetail(this.username);

  @override
  List<Object?> get props => [username];
}
