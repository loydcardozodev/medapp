import 'package:flutter/material.dart';
import 'package:medapp/domain/models/app_user/app_user.dart';
import 'package:medapp/util/result.dart';

// remove firebase_auth import - abstract class should not know about Firebase
abstract class AuthRepository extends ChangeNotifier {
  Future<Result<AppUser>> login({
    required String email,
    required String password,
  });
  Future<Result<AppUser>> signup({
    required String email,
    required String password,
  });
  Future<Result<void>> logout();
  AppUser? get currentUser;
}
