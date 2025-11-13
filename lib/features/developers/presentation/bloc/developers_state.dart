import 'package:equatable/equatable.dart';
import '../../domain/entities/developer_entity.dart';

abstract class DevelopersState extends Equatable {
  const DevelopersState();

  @override
  List<Object?> get props => [];
}

// Initial empty state
class DevelopersInitial extends DevelopersState {
  const DevelopersInitial();
}

// Loading state
class DevelopersLoading extends DevelopersState {
  const DevelopersLoading();
}

// Loaded state
class DevelopersLoaded extends DevelopersState {
  final List<DeveloperEntity> developers;
  final bool hasReachedMax;
  final bool isOffline;

  const DevelopersLoaded({
    this.developers = const [],
    this.hasReachedMax = false,
    this.isOffline = false,
  });

  DevelopersLoaded copyWith({
    List<DeveloperEntity>? developers,
    bool? hasReachedMax,
    bool? isOffline,
  }) {
    return DevelopersLoaded(
      developers: developers ?? this.developers,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isOffline: isOffline ?? this.isOffline,
    );
  }

  @override
  List<Object?> get props => [developers, hasReachedMax, isOffline];
}

/// Error state
class DevelopersError extends DevelopersState {
  final String message;
  final List<DeveloperEntity>? cachedDevelopers;
  final bool isOffline;

  const DevelopersError({
    required this.message,
    this.cachedDevelopers,
    this.isOffline = false,
  });

  @override
  List<Object?> get props => [message, cachedDevelopers, isOffline];
}
