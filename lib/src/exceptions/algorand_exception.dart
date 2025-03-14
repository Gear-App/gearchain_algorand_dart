import 'algorand_factory.dart';
import 'exceptions.dart';
import 'package:dio/dio.dart';

class AlgorandException implements Exception {
  final int errorCode;
  final int? statusCode;
  final String _message;
  final Object? cause;

  AlgorandException({
    this.errorCode = 0,
    String message = '',
    this.statusCode,
    this.cause,
  }) : _message = message;

  factory AlgorandException.fromDioException(DioException error) {
    return AlgorandException(
      statusCode: error.response?.statusCode,
      message: error.message ?? 'An error occurred',
      cause: error,
    );
  }

  String get message {
    final cause = this.cause;
    if (cause is! DioException) {
      return _message;
    }

    final message = cause.response?.data?['message'];

    if (message is! String) {
      return _message;
    }

    return message;
  }

  AlgorandError? get error {
    return AlgorandFactory().tryParse(message);
  }
}
