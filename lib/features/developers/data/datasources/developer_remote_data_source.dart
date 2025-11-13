import 'package:dio/dio.dart';
import '../../../../core/network/api_constants.dart';
import '../models/developer_model.dart';

abstract class DeveloperRemoteDataSource {
  Future<List<DeveloperModel>> getDevelopersList({
    int? since,
    int perPage = 15,
  });
  
  Future<DeveloperModel> getDeveloperDetails(String username);
}

/// Implementation of [DeveloperRemoteDataSource] using Dio.
class DeveloperRemoteDataSourceImpl implements DeveloperRemoteDataSource {
  final Dio dio;

  DeveloperRemoteDataSourceImpl(this.dio);

  @override
  Future<List<DeveloperModel>> getDevelopersList({
    int? since,
    int perPage = 15,
  }) async {
    final response = await dio.get(
      ApiConstants.users,
      queryParameters: {if (since != null) 'since': since, 'per_page': perPage},
    );

    final List<dynamic> data = response.data;
    return data.map((json) => DeveloperModel.fromJson(json)).toList();
  }

  @override
  Future<DeveloperModel> getDeveloperDetails(String username) async {
    final response = await dio.get(ApiConstants.userDetails(username));
    return DeveloperModel.fromJson(response.data);
  }
}
