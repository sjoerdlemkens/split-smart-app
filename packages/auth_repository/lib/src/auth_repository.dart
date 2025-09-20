import 'package:auth_repository/src/auth_repository_exception.dart';
import 'package:rxdart/subjects.dart';
import 'package:split_smart_api/split_smart_api.dart';
import 'package:user_repository/user_repository.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthRepository {
  final SplitSmartApi _apiClient;
  final UserRepository _userRepository;
  final BehaviorSubject<AuthStatus> _authStatusSubject =
      BehaviorSubject<AuthStatus>.seeded(AuthStatus.unknown);

  AuthRepository({
    SplitSmartApi? apiClient,
    UserRepository? userRepository,
  })  : _apiClient = apiClient ?? SplitSmartApi.development(),
        _userRepository = userRepository ??
            UserRepository(
                apiClient: apiClient ?? SplitSmartApi.development()) {
    _checkInitialAuthStatus();

    _apiClient.auth.setOnTokenRefreshFailed(_onTokenRefreshFailed);
  }

  /// Stream of the auth status
  Stream<AuthStatus> get authStatusStream => _authStatusSubject.stream;

  /// Checks the initial authentication status, and sets the auth status subject.
  void _checkInitialAuthStatus() async {
    if (await _apiClient.auth.isAuthenticated) {
      _authStatusSubject.add(AuthStatus.authenticated);
    } else {
      _authStatusSubject.add(AuthStatus.unauthenticated);
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LoginFailure] if an exception occurs.
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final request = LoginRequest(
        email: email,
        password: password,
      );

      await _apiClient.auth.login(request);
      _authStatusSubject.add(AuthStatus.authenticated);
    } on ApiException catch (e) {
      throw LoginFailure.fromException(e);
    } catch (e) {
      throw const LoginFailure();
    }
  }

  /// Signs up with the provided [email] and [password].
  ///
  /// Creates a user account and automatically logs them in.
  /// Throws a [SignUpFailure] if an exception occurs.
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final request = SignUpRequest(
        email: email,
        password: password,
      );

      // Create the user account and get auth tokens
      final authTokens = await _userRepository.signUp(request);

      // Store the tokens in the API client
      await _apiClient.setAuthTokens(authTokens);
      _authStatusSubject.add(AuthStatus.authenticated);
    } on ApiException catch (e) {
      throw SignUpFailure.fromException(e);
    } catch (e) {
      throw const SignUpFailure();
    }
  }

  /// Logs out the user.
  Future<void> logout() async {
    await _apiClient.auth.logout();
    _authStatusSubject.add(AuthStatus.unauthenticated);
  }

  /// Checks if the user is authenticated.
  Future<bool> isAuthenticated() async {
    return await _apiClient.auth.isAuthenticated;
  }

  void _onTokenRefreshFailed() {
    logout();
  }
}
