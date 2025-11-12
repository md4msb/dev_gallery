import 'package:dio/dio.dart';
import 'api_constants.dart';

class DioClient {
  late Dio _dio;
  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {'Accept': 'application/vnd.github.v3+json'},
      ),
    );
  }
  Dio get dio => _dio;
}
