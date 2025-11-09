import 'package:dio/dio.dart';

class ApiClient {
  static final Dio _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) {
          String message;
          switch (error.response?.statusCode) {
            case 400:
              message = 'Bad request. Please check your input.';
              break;
            case 401:
              message = 'Unauthorized. Please check your API key.';
              break;
            case 403:
              message = 'Forbidden. Access denied.';
              break;
            case 404:
              message = 'Not found. Please check the city name.';
              break;
            case 429:
              message = 'Too many requests. Please try again later.';
              break;
            case 500:
            case 502:
            case 503:
              message = 'Server error. Please try again later.';
              break;
            default:
              message = error.message ?? 'An unexpected error occurred.';
          }
          handler.next(
            DioException(
              requestOptions: error.requestOptions,
              response: error.response,
              type: error.type,
              error: error.error,
              message: message,
            ),
          );
        },
      ),
    );

  static Dio get dio => _dio;
}
