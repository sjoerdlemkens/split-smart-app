/// Configuration for the API client
class ApiClientConfig {
  final String baseUrl;
  final Duration timeout;
  final Map<String, String> defaultHeaders;

  const ApiClientConfig({
    required this.baseUrl,
    this.timeout = const Duration(seconds: 30),
    this.defaultHeaders = const {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  });
}
