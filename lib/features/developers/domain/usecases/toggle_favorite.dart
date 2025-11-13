import 'package:dartz/dartz.dart';
import '../entities/developer_entity.dart';
import '../repositories/developer_repo.dart';

class ToggleFavorite {
  final DeveloperRepo repository;

  ToggleFavorite(this.repository);

  Future<Either<String, Unit>> call(DeveloperEntity developer) async {
    return await repository.toggleFavorite(developer);
  }
}
