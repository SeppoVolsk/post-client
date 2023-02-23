import 'package:dio/dio.dart';

class ErrorEntity {
  final String message;
  final String? errorMessage;
  final dynamic error;
  final StackTrace? stackTrace;

  ErrorEntity({
    required this.message,
    this.errorMessage,
    this.error,
    this.stackTrace,
  });

  factory ErrorEntity.fromException(dynamic error) {
    if (error is ErrorEntity) return error;
    final entity = ErrorEntity(message: "Unknow error");
    if (error is DioError) {
      try {
        return ErrorEntity(
            message: error.response?.data["message"] ?? "Unknow message",
            errorMessage: error.response?.data["error"] ?? "Unknow message",
            stackTrace: error.stackTrace,
            error: error);
      } catch (error) {
        return entity;
      }
    }
    return entity;
  }
}
