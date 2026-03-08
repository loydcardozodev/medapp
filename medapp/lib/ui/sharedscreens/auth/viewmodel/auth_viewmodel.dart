import 'package:flutter/material.dart';
import 'package:medapp/data/repository/auth/auth_repository.dart';
import 'package:medapp/domain/models/app_user/app_user.dart';
import 'package:medapp/util/result.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository {
    _currentUser = _authRepository.currentUser;
  }

  AppUser? _currentUser;

  AppUser? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  Future<Result<AppUser>> login({
    required String email,
    required String password,
  }) async {
    final result = await _authRepository.login(
      email: email,
      password: password,
    );

    if (result is Ok<AppUser>) {
      _currentUser = result.value;
      notifyListeners();
    }

    return result;
  }

  Future<Result<AppUser>> signup({
    required String email,
    required String password,
  }) async {
    final result = await _authRepository.signup(
      email: email,
      password: password,
    );

    if (result is Ok<AppUser>) {
      _currentUser = result.value;
      notifyListeners();
    }

    return result;
  }

  Future<void> logout() async {
    await _authRepository.logout();
    _currentUser = null;
    notifyListeners();
  }
}
