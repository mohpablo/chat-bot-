import 'package:chat_bot/core/error/api_error.dart';

class ServerException implements Exception {
  final ApiError error;

  ServerException(this.error);

  @override
  String toString() => "ServerException: ${error.toString()}";
}