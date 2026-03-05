import 'package:firebase_auth/firebase_auth.dart';
import 'package:medapp/data/repository/auth/auth_repository.dart';
import 'package:medapp/data/services/auth/firebase_auth_service.dart';
import 'package:medapp/util/result.dart';

class AuthRepositoryFirebase extends AuthRepository {
  final FirebaseAuthService _firebaseAuthService;

  AuthRepositoryFirebase({required FirebaseAuthService firebaseAuthService})
    : _firebaseAuthService = firebaseAuthService;

  @override
  Future<Result<void>> login({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuthService.login(email, password);
      return Result.ok(null);
    } catch (e) {
      return _handleAuthError(e);
    }
  }

  @override
  Future<Result<void>> signup({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuthService.signup(email, password);
      return Result.ok(null);
    } catch (e) {
      return _handleAuthError(e);
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _firebaseAuthService.logout();
      return Result.ok(null);
    } catch (e) {
      return _handleAuthError(e);
    }
  }

  Result<void> _handleAuthError(Object e) {
    if (e is FirebaseAuthException) {
      return Result.error(Exception(e.message ?? "Authentication error"));
    }

    return Result.error(Exception("Something went wrong. Please try again."));
  }
}
