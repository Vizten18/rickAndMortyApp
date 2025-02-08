import 'package:dio/dio.dart';

class DioClient {
  DioClient({required String baseUrl, required Map<String, String> headers})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            headers: headers,
          ),
        ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add any additional headers or configurations here
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Handle responses
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // Handle errors
          return handler.next(e);
        },
      ),
    );
  }

  final Dio _dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _dio.get<T>(path, queryParameters: queryParameters);
  }
}
