import 'package:equatable/equatable.dart';

class RepoEntity extends Equatable {
  final int id;
  final String name;
  final String? description;
  final int? starCount;
  final String? updatedAt;
  final String visibility;

  const RepoEntity({
    required this.id,
    required this.name,
    this.description,
    this.starCount,
    this.updatedAt,
    required this.visibility,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    starCount,
    updatedAt,
    visibility,
  ];
}
