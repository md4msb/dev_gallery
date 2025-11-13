import 'package:equatable/equatable.dart';

abstract class DevelopersEvent extends Equatable {
  const DevelopersEvent();

  @override
  List<Object?> get props => [];
}

class FetchDevelopers extends DevelopersEvent {
  const FetchDevelopers();
}
