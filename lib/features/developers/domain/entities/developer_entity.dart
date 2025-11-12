import 'package:equatable/equatable.dart';

class DeveloperEntity extends Equatable {
  final String username;
  final String avatarUrl;
  final String? name;
  final String? bio;
  final int? followers;
  final int? following;
  final int? publicRepos;
  final bool isFavorite;

  const DeveloperEntity({
    required this.username,
    required this.avatarUrl,
    this.name,
    this.bio,
    this.followers,
    this.following,
    this.publicRepos,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [
    username,
    avatarUrl,
    name,
    bio,
    followers,
    following,
    publicRepos,
    isFavorite,
  ];
}
