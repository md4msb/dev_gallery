import 'package:dartz/dartz.dart';
import 'package:dev_gallery/features/developers/domain/entities/developer_entity.dart';
import 'package:dev_gallery/features/developers/domain/repositories/developer_repo.dart';

class DeveloperRepoImpl implements DeveloperRepo {
  @override
  Future<Either<String, List<DeveloperEntity>>> getDevelopersList({
    int? since,
    int perPage = 15,
  }) {
    // TODO: implement getDevelopersList
    throw UnimplementedError();
  }

  @override
  Future<Either<String, DeveloperEntity>> getDeveloperDetails(String username) {
    // TODO: implement getDeveloperDetails
    throw UnimplementedError();
  }

  @override
  Future<Either<String, DeveloperEntity>> toggleFavorite(
    DeveloperEntity developer,
  ) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }
}
