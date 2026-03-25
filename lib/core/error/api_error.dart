class ApiError {
  final int? statusCode;
  final String message;

  ApiError({this.statusCode, required this.message});

  factory ApiError.fromJson(Map<String, dynamic> json, {int? statusCode}) {
    return ApiError(
      statusCode: statusCode,
      message: json["error"]?["message"] ?? json["message"] ?? "Unknown error",
    );
  }

  @override
  String toString() => "ApiError(statusCode: $statusCode, message: $message)";
}