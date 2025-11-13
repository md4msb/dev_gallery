import 'package:dartz/dartz.dart';
import '../entities/developer_entity.dart';
import '../repositories/developer_repo.dart';

class GetDeveloperDetails {
  final DeveloperRepo repository;

  GetDeveloperDetails(this.repository);

  Future<Either<String, DeveloperEntity>> call(String username) async {
    return await repository.getDeveloperDetails(username);
  }
}
