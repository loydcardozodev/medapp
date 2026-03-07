import 'package:flutter/foundation.dart';
import 'package:medapp/data/repository/auth/auth_repository.dart'; // ← import abstract class
import 'package:medapp/util/command.dart';
import 'package:medapp/util/result.dart';

class SignupViewmodel extends ChangeNotifier {
  final AuthRepository _authRepository; // ← abstract type

  SignupViewmodel({required AuthRepository authRepository})
    : _authRepository = authRepository {
    signup = Command1<void, (String email, String password)>(_signup);
  }

  bool isLoading = false;
  String? error;
  late Command1 signup;

  String? _email;

  void setEmail(String email) {
    _email = email;
  }

  Future<Result<void>> _signup((String, String) credentials) async {
    final (email, password) = credentials;

    return await _authRepository.signup(
      // ← use _authRepository not _authRepositoryFirebase
      email: email,
      password: password,
    );
  }
}
