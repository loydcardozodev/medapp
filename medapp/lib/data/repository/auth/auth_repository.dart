import 'package:flutter/material.dart';
import 'package:medapp/domain/models/app_user/app_user.dart';
import 'package:medapp/util/result.dart';

abstract class AuthRepository {
  AppUser? get currentUser;
  Future<Result<AppUser>> login({
    required String email,
    required String password,
  });
  Future<Result<AppUser>> signup({
    required String email,
    required String password,
  });
  Future<Result<void>> logout();
}
