import 'package:dio/dio.dart';
import 'package:split_smart_api/src/core/core.dart';

/// Interceptor that handles automatic token refresh when access token expires
class TokenRefreshInterceptor extends Interceptor {
  final Dio dio;
  final TokenStorage tokenStorage;
  final String refreshEndpoint;
  final void Function()? onTokenRefreshFailed;

  bool _isRefreshing = false;
  final List<RequestOptions> _pendingRequests = [];

  TokenRefreshInterceptor({
    required this.dio,
    required this.tokenStorage,
    this.refreshEndpoint = '/auth/refresh',
    this.onTokenRefreshFailed,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Add access token to request headers
    final accessToken = await tokenStorage.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Check if error is due to expired access token
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      final refreshToken = await tokenStorage.getRefreshToken();

      if (refreshToken != null) {
        // Add current request to pending queue
        _pendingRequests.add(err.requestOptions);

        try {
          await _refreshToken(refreshToken);

          // Retry all pending requests with new token
          for (final request in _pendingRequests) {
            final newAccessToken = await tokenStorage.getAccessToken();
            if (newAccessToken != null) {
              request.headers['Authorization'] = 'Bearer $newAccessToken';
            }

            try {
              await dio.fetch(request);
              // Note: This is a simplified retry mechanism
              // In a complete implementation, you'd need to handle the response properly
            } catch (e) {
              // Handle retry errors
            }
          }

          _pendingRequests.clear();

          // Retry the original request
          final newAccessToken = await tokenStorage.getAccessToken();
          if (newAccessToken != null) {
            err.requestOptions.headers['Authorization'] =
                'Bearer $newAccessToken';

            try {
              final response = await dio.fetch(err.requestOptions);
              handler.resolve(response);
              return;
            } catch (retryError) {
              if (retryError is DioException) {
                handler.next(retryError);
              } else {
                handler.next(
                  DioException(
                    requestOptions: err.requestOptions,
                    error: retryError,
                  ),
                );
              }
              return;
            }
          }
        } catch (refreshError) {
          // Token refresh failed
          await tokenStorage.clearTokens();
          onTokenRefreshFailed?.call();
          _pendingRequests.clear();
        }
      }
    }

    handler.next(err);
  }

  Future<void> _refreshToken(String refreshToken) async {
    if (_isRefreshing) return;

    _isRefreshing = true;

    try {
      final response = await dio.post(
        refreshEndpoint,
        data: {'refresh_token': refreshToken},
      );

      final data = response.data as Map<String, dynamic>;
      final newAccessToken = data['access_token'] as String?;
      final newRefreshToken = data['refresh_token'] as String?;

      if (newAccessToken != null) {
        await tokenStorage.saveAccessToken(newAccessToken);
      }

      if (newRefreshToken != null) {
        await tokenStorage.saveRefreshToken(newRefreshToken);
      }
    } finally {
      _isRefreshing = false;
    }
  }
}
