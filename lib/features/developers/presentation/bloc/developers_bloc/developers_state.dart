part of 'developers_bloc.dart';

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
  final List<DeveloperEntity> searchDevs;
  // final Set<String> loadingDetails;
  final bool hasReachedMax;
  final bool isOffline;

  const DevelopersLoaded({
    this.developers = const [],
    this.searchDevs = const [],
    // this.loadingDetails = const {},
    this.hasReachedMax = false,
    this.isOffline = false,
  });

  DevelopersLoaded copyWith({
    List<DeveloperEntity>? developers,
    List<DeveloperEntity>? searchDevs,
    // Set<String>? loadingDetails,
    bool? hasReachedMax,
    bool? isOffline,
  }) {
    return DevelopersLoaded(
      developers: developers ?? this.developers,
      searchDevs: searchDevs ?? this.searchDevs,
      // loadingDetails: loadingDetails ?? this.loadingDetails,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isOffline: isOffline ?? this.isOffline,
    );
  }

  @override
  List<Object?> get props => [
    developers,
    searchDevs,
    // loadingDetails,
    hasReachedMax,
    isOffline,
  ];
}

/// Error state
class DevelopersError extends DevelopersState {
  final String message;
  final bool isOffline;

  const DevelopersError({required this.message, this.isOffline = false});

  @override
  List<Object?> get props => [message, isOffline];
}
