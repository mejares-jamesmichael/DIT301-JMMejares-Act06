import 'package:dio/dio.dart';

class ApiClient {
  static final Dio _dio = Dio();

  static Dio get dio => _dio;
}
