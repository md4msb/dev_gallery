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
  final bool isFavorite;

  DeveloperModel({
    required this.username,
    required this.avatarUrl,
    this.name,
    this.bio,
    this.followers,
    this.following,
    this.publicRepos,
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
    );
  }

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'login': username,
      'avatar_url': avatarUrl,
      'name': name,
      'bio': bio,
      'followers': followers,
      'following': following,
      'public_repos': publicRepos,
      'isFavorite': isFavorite,
    };
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
      isFavorite: entity.isFavorite,
    );
  }
}
