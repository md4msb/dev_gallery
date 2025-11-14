import 'package:dartz/dartz.dart';
import 'package:dev_gallery/core/handlers/error-handler/error_handler.dart';
import '../../domain/entities/repo_entity.dart';
import '../../domain/repositories/repo_list_repository.dart';
import '../datasources/repo_remote_data_source.dart';

class RepoRepositoryImpl implements RepoListRepository {
  final RepoRemoteDataSource remoteDataSource;

  RepoRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, List<RepoEntity>>> getReposList(String username) async {
    try {
      final repos = await remoteDataSource.getReposList(username);
      return Right(repos);
    } catch (e, stackTrace) {
      final message = handleError(e, stackTrace);
      return Left(message);
    }
  }
}
