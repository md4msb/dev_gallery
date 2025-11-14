import '../../domain/entities/repo_entity.dart';

class RepoModel extends RepoEntity {
  const RepoModel({
    required super.id,
    required super.name,
    super.description,
    super.starCount,
    super.updatedAt,
    required super.visibility,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      starCount: json['stargazers_count'],
      updatedAt: json['updated_at'],
      visibility: json['visibility'],
    );
  }
}
