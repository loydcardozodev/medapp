import 'package:firebase_auth/firebase_auth.dart';
import 'package:medapp/data/repository/auth/auth_repository.dart';
import 'package:medapp/data/services/firebase/auth/firebase_auth_service.dart';
import 'package:medapp/domain/models/app_user/app_user.dart';
import 'package:medapp/util/result.dart';

class AuthRepositoryFirebase extends AuthRepository {
  final FirebaseAuthService _firebaseAuthService;

  AuthRepositoryFirebase({required FirebaseAuthService firebaseAuthService})
    : _firebaseAuthService = firebaseAuthService {
    _firebaseAuthService.authStateChanges.listen((_) {
      notifyListeners();
    });
  }

  @override
  AppUser? get currentUser => _firebaseAuthService.currentUser; // ← use service

  @override
  Future<Result<AppUser>> login({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuthService.login(email, password);
      final user = _firebaseAuthService.currentUser;
      if (user == null) return Result.error(Exception('Login failed'));
      return Result.ok(user); // ← return AppUser not null
    } catch (e) {
      return _handleAuthError(e);
    }
  }

  @override
  Future<Result<AppUser>> signup({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuthService.signup(email, password);
      final user = _firebaseAuthService.currentUser;
      if (user == null) return Result.error(Exception('Signup failed'));
      return Result.ok(user); // ← return AppUser not null
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

  Result<Never> _handleAuthError(Object e) {
    if (e is FirebaseAuthException) {
      return Result.error(Exception(e.message ?? 'Authentication error'));
    }
    return Result.error(Exception('Something went wrong. Please try again.'));
  }
}
