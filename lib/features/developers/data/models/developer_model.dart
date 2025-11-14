import 'package:hive/hive.dart';
import '../../domain/entities/developer_entity.dart';

part 'developer_model.g.dart';

@HiveType(typeId: 0)
class DeveloperModel extends HiveObject {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String avatarUrl;

  @HiveField(2)
  final String? name;

  @HiveField(3)
  final String? bio;

  @HiveField(4)
  final int? followers;

  @HiveField(5)
  final int? following;

  @HiveField(6)
  final int? publicRepos;

  @HiveField(7)
  final String? location;

  @HiveField(8)
  final DateTime? createdAt;

  @HiveField(9)
  final bool isFavorite;

  DeveloperModel({
    required this.username,
    required this.avatarUrl,
    this.name,
    this.bio,
    this.followers,
    this.following,
    this.publicRepos,
    this.location,
    this.createdAt,
    this.isFavorite = false,
  });

  // Create a DeveloperModel from API Data
  factory DeveloperModel.fromJson(Map<String, dynamic> json) {
    return DeveloperModel(
      username: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      name: json['name'],
      bio: json['bio'],
      followers: json['followers'],
      following: json['following'],
      publicRepos: json['public_repos'],
      location: json['location'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  // Convert to domain entity
  DeveloperEntity toEntity() {
    return DeveloperEntity(
      username: username,
      avatarUrl: avatarUrl,
      name: name,
      bio: bio,
      followers: followers,
      following: following,
      publicRepos: publicRepos,
      location: location,
      createdAt: createdAt,
      isFavorite: isFavorite,
    );
  }

  // Create model from domain entity
  factory DeveloperModel.fromEntity(DeveloperEntity entity) {
    return DeveloperModel(
      username: entity.username,
      avatarUrl: entity.avatarUrl,
      name: entity.name,
      bio: entity.bio,
      followers: entity.followers,
      following: entity.following,
      publicRepos: entity.publicRepos,
      location: entity.location,
      createdAt: entity.createdAt,
      isFavorite: entity.isFavorite,
    );
  }
}
