import 'package:dartz/dartz.dart';
import '../entities/developer_entity.dart';

abstract class DeveloperRepo {
  Future<Either<String, List<DeveloperEntity>>> getDevelopersList({
    int? since,
    int perPage = 15,
  });

  Future<Either<String, DeveloperEntity>> getDeveloperDetails(String username);

  Future<Either<String, Unit>> toggleFavorite(DeveloperEntity developer);
}
