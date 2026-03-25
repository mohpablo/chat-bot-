import 'package:chat_bot/core/api/api_endpoints.dart';
import 'package:chat_bot/core/error/api_error.dart';
import 'package:chat_bot/core/error/server_exception.dart';
import 'package:dio/dio.dart';
import 'api_consumer.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer(this.dio) {
    BaseOptions(
      baseUrl: EndPoints.baseUrl,
      headers: {
        APIKeys.authorization: "Bearer ${APIKeys.apikey}",
        "Content-Type": "application/json",
        "HTTP-Referer": "http://localhost:3000",
        "X-Title": "MyFlutterApp",
      },
    );
  }

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: body,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: body,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<dynamic> delete(
    String path, {
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: body,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data;
    ApiError apiError;
    if (data is Map<String, dynamic>) {
      apiError = ApiError.fromJson(data, statusCode: statusCode);
    } else {
      apiError = ApiError(
        statusCode: statusCode,
        message: e.message ?? "Unexpected error",
      );
    }
    return ServerException(apiError);
  }
}
