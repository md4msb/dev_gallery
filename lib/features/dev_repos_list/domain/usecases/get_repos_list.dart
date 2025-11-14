import 'package:dartz/dartz.dart';
import '../entities/repo_entity.dart';
import '../repositories/repo_list_repository.dart';

class GetReposList {
  final RepoListRepository repository;

  GetReposList(this.repository);

  Future<Either<String, List<RepoEntity>>> call(String username) async{
    return await repository.getReposList(username);
  }
}
