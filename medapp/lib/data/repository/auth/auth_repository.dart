import 'package:flutter/material.dart';
import 'package:medapp/util/result.dart';

abstract class AuthRepository extends ChangeNotifier {
  Future<Result<void>> login({required String email, required String password});

  Future<Result<void>> signup({
    required String email,
    required String password,
  });

  Future<Result<void>> logout();
}
