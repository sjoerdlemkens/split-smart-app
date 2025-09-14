import 'package:equatable/equatable.dart';

/// Base exception for all API-related errors
abstract class ApiException extends Equatable implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, [this.statusCode]);

  @override
  String toString() =>
      'ApiException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';

  @override
  List<Object?> get props => [message, statusCode];
}

/// Network connectivity issues
class NetworkException extends ApiException {
  const NetworkException(super.message);
}

/// Server errors (5xx)
class ServerException extends ApiException {
  const ServerException(super.message, int super.statusCode);
}

/// Client errors (4xx)
class ClientException extends ApiException {
  const ClientException(super.message, int super.statusCode);
}

/// Authentication/Authorization errors
class AuthException extends ApiException {
  const AuthException(super.message, int super.statusCode);
}

/// Validation errors
class ValidationException extends ApiException {
  final Map<String, List<String>>? errors;

  const ValidationException(super.message, int super.statusCode, [this.errors]);

  @override
  List<Object?> get props => [message, statusCode, errors];
}

/// Timeout errors
class TimeoutException extends ApiException {
  const TimeoutException(super.message);
}

/// Unexpected errors
class UnknownException extends ApiException {
  const UnknownException(super.message);
}
