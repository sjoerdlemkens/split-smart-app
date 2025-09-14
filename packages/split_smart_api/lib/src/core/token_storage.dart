import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Interface for storing and retrieving authentication tokens
abstract class TokenStorage {
  /// Stores the access token
  Future<void> saveAccessToken(String token);

  /// Stores the refresh token
  Future<void> saveRefreshToken(String token);

  /// Retrieves the access token
  Future<String?> getAccessToken();

  /// Retrieves the refresh token
  Future<String?> getRefreshToken();

  /// Clears both access and refresh tokens
  Future<void> clearTokens();
}

/// Secure token storage using Flutter Secure Storage
class SecureTokenStorage implements TokenStorage {
  static const String _accessTokenKey = 'split_smart_access_token';
  static const String _refreshTokenKey = 'split_smart_refresh_token';

  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  final FlutterSecureStorage _storage;

  const SecureTokenStorage([this._storage = _secureStorage]);

  @override
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  @override
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  @override
  Future<void> clearTokens() async {
    await Future.wait([
      _storage.delete(key: _accessTokenKey),
      _storage.delete(key: _refreshTokenKey),
    ]);
  }
}
