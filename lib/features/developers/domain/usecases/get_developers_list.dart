import 'package:dartz/dartz.dart';
import '../entities/developer_entity.dart';
import '../repositories/developer_repo.dart';

class GetDevelopersList {
  final DeveloperRepo repository;

  GetDevelopersList(this.repository);

  Future<Either<String, List<DeveloperEntity>>> call({
    int? since,
    int perPage = 15,
  }) => repository.getDevelopersList(since: since, perPage: perPage);
}
