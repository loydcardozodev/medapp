import 'package:flutter/material.dart';
import 'package:medapp/data/repository/auth/auth_repository_firebase.dart';
import 'package:medapp/util/command.dart';
import 'package:medapp/util/result.dart';

class LoginViewmodel extends ChangeNotifier {
  final AuthRepositoryFirebase _authRepositoryFirebase;

  LoginViewmodel({required AuthRepositoryFirebase authRepositoryFirebase})
    : _authRepositoryFirebase = authRepositoryFirebase {
    login = Command1<void, (String email, String password)>(_login);
  }
  bool isLoading = false;
  String? error;
  late Command1 login;

  String? _email;

  // void updateRepository(AuthRepository repository) {
  //   _repository = repository;
  // }

  void setEmail(String email) {
    _email = email;
  }

  Future<Result<void>> _login((String, String) credentials) async {
    final (email, password) = credentials;

    return await _authRepositoryFirebase.signup(
      email: email,
      password: password,
    );
  }
}
