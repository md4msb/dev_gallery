import 'package:dartz/dartz.dart';
import '../entities/developer_entity.dart';
import '../repositories/developer_repo.dart';

class ToggleFavorite {
  final DeveloperRepo repository;

  ToggleFavorite(this.repository);

  Future<Either<String, DeveloperEntity>> call(DeveloperEntity developer) {
    return repository.toggleFavorite(developer);
  }
}
