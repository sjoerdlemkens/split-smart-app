import 'package:dio/dio.dart';
import 'package:split_smart_api/split_smart_api.dart';

// HTTP client wrapper
class ApiClient {
  final ApiClientConfig config;
  final Dio _dio;
  final TokenStorage _tokenStorage;
  late final TokenRefreshInterceptor _tokenRefreshInterceptor;

  ApiClient({
    required this.config,
    TokenStorage? tokenStorage,
    Dio? dio,
    void Function()? onTokenRefreshFailed,
  })  : _tokenStorage = tokenStorage ?? const SecureTokenStorage(),
        _dio = dio ?? Dio() {
    // Dio config
    _dio.options = BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: config.timeout,
      receiveTimeout: config.timeout,
      sendTimeout: config.timeout,
      headers: config.defaultHeaders,
    );

    // Add token refresh interceptor
    _tokenRefreshInterceptor = TokenRefreshInterceptor(
      dio: _dio,
      tokenStorage: _tokenStorage,
      onTokenRefreshFailed: onTokenRefreshFailed,
    );

    _dio.interceptors.add(_tokenRefreshInterceptor);

    // Add logging interceptor for debugging
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
      requestHeader: false,
      responseHeader: false,
    ));
  }

  /// Make a GET request
  Future<T> get<T>(
    String endpoint, {
    Map<String, String>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        endpoint,
        queryParameters: queryParameters,
      );

      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw UnknownException('Unexpected error: $e');
    }
  }

  /// Set the authentication tokens
  Future<void> setAuthTokens(AuthTokens authTokens) async {
    await _tokenStorage.saveAccessToken(authTokens.accessToken);
    await _tokenStorage.saveRefreshToken(authTokens.refreshToken);
  }

  /// Clear authentication tokens
  Future<void> clearAuthTokens() async {
    await _tokenStorage.clearTokens();
  }

  /// Check if user is authenticated
  Future<bool> get isAuthenticated async {
    final token = await _tokenStorage.getAccessToken();
    return token != null;
  }

  /// Make a POST request
  Future<T> post<T>(
    String endpoint, {
    Object? data,
    Map<String, String>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );

      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw UnknownException('Unexpected error: $e');
    }
  }

  /// Make a PUT request
  Future<T> put<T>(
    String endpoint, {
    Object? data,
    Map<String, String>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );

      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw UnknownException('Unexpected error: $e');
    }
  }

  /// Make a DELETE request
  Future<T> delete<T>(
    String endpoint, {
    Map<String, String>? queryParameters,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        endpoint,
        queryParameters: queryParameters,
      );

      return _handleResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw UnknownException('Unexpected error: $e');
    }
  }

  /// Handle Dio response and convert to appropriate type
  T _handleResponse<T>(
    Response<Map<String, dynamic>> response,
    T Function(Map<String, dynamic>)? fromJson,
  ) {
    final data = response.data;

    if (T == String) {
      return (data?.toString() ?? '') as T;
    }

    if (data == null || data.isEmpty) {
      // Handle empty successful responses
      return {} as T;
    }

    try {
      if (fromJson != null) {
        return fromJson(data);
      } else {
        return data as T;
      }
    } catch (e) {
      throw const UnknownException('Failed to parse response data');
    }
  }

  /// Handle Dio exceptions and convert to appropriate API exceptions
  ApiException _handleDioException(DioException e) {
    print(e);
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const TimeoutException('Request timeout');
    }

    if (e.type == DioExceptionType.connectionError) {
      return const NetworkException('No internet connection');
    }

    final response = e.response;
    if (response == null) {
      return UnknownException('Request failed: ${e.message}');
    }

    final statusCode = response.statusCode ?? 0;
    String errorMessage = 'Request failed';
    Map<String, List<String>>? validationErrors;

    try {
      if (response.data != null) {
        final errorData = response.data as Map<String, dynamic>?;
        if (errorData != null) {
          errorMessage = errorData['message'] ?? errorMessage;

          // Handle validation errors
          if (errorData.containsKey('errors')) {
            validationErrors = Map<String, List<String>>.from(
              errorData['errors'].map(
                (key, value) => MapEntry(
                  key,
                  List<String>.from(value is List ? value : [value.toString()]),
                ),
              ),
            );
          }
        }
      }
    } catch (_) {
      // If we can't parse the error response, use the status code
      errorMessage = 'HTTP $statusCode';
    }

    // Throw appropriate exception based on status code
    if (statusCode == 401 || statusCode == 403) {
      return AuthException(errorMessage, statusCode);
    } else if (statusCode == 422) {
      return ValidationException(errorMessage, statusCode, validationErrors);
    } else if (statusCode >= 400 && statusCode < 500) {
      return ClientException(errorMessage, statusCode);
    } else if (statusCode >= 500) {
      return ServerException(errorMessage, statusCode);
    } else {
      return UnknownException('HTTP $statusCode: $errorMessage');
    }
  }

  /// Close the Dio client
  void dispose() {
    _dio.close();
  }
}
