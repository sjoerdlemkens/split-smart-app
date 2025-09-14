import 'package:split_smart_api/src/services/auth_service.dart';

import 'core/core.dart';

/// Main API client for the SplitSmart application
class SplitSmartApi {
  late final ApiClient _apiClient;
  late final AuthService _authService;

  SplitSmartApi({
    required String baseUrl,
    Duration timeout = const Duration(seconds: 30),
    Map<String, String>? defaultHeaders,
  }) {
    final config = ApiClientConfig(
      baseUrl: baseUrl,
      timeout: timeout,
      defaultHeaders: defaultHeaders ??
          const {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
    );

    _apiClient = ApiClient(config: config);
    _authService = AuthService(_apiClient);
  }

  /// Predefined constructor for development environment
  SplitSmartApi.development({
    String baseUrl = 'http://localhost:3000',
    Duration timeout = const Duration(seconds: 30),
  }) : this(baseUrl: baseUrl, timeout: timeout);

  /// Predefined constructor for production environment
  SplitSmartApi.production({
    required String baseUrl,
    Duration timeout = const Duration(seconds: 30),
  }) : this(baseUrl: baseUrl, timeout: timeout);

  /// Authentication service
  AuthService get auth => _authService;
}
