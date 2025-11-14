import 'package:equatable/equatable.dart';
import '../../../domain/entities/developer_entity.dart';

abstract class DevDetailState extends Equatable {
  const DevDetailState();

  @override
  List<Object?> get props => [];
}

class DevDetailInitial extends DevDetailState {}

class DevDetailLoading extends DevDetailState {}

class DevDetailLoaded extends DevDetailState {
  final DeveloperEntity developer;

  const DevDetailLoaded(this.developer);

  @override
  List<Object?> get props => [developer];
}

class DevDetailError extends DevDetailState {
  final String message;

  const DevDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
