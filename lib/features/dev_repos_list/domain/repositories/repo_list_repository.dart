import 'package:dartz/dartz.dart';
import '../entities/repo_entity.dart';

abstract class RepoListRepository {
  Future<Either<String, List<RepoEntity>>> getReposList(String username);
}