import 'package:dio/dio.dart';
import '../../../../core/network/api_constants.dart';
import '../models/repo_model.dart';

abstract class RepoRemoteDataSource {
  Future<List<RepoModel>> getReposList(String username);
}

class RepoRemoteDataSourceImpl implements RepoRemoteDataSource {
  final Dio dio;

  RepoRemoteDataSourceImpl(this.dio);

  @override
  Future<List<RepoModel>> getReposList(String username) async {
    final response = await dio.get(ApiConstants.userRepos(username));
    final List data = response.data;
    return data.map((e) => RepoModel.fromJson(e)).toList();
  }
}
