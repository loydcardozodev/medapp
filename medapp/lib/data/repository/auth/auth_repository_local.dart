import 'package:medapp/data/repository/auth/auth_repository.dart';
import 'package:medapp/data/services/local/local_data_service.dart';
import 'package:medapp/domain/models/app_user/app_user.dart';
import 'package:medapp/util/result.dart';

class AuthRepositoryLocal extends AuthRepository {
  AppUser? _currentUser;

  @override
  AppUser? get currentUser => _currentUser;

  @override
  Future<Result<AppUser>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = LocalDataService.findUser(email, password);
      if (user == null) {
        return Result.error(Exception('Invalid email or password'));
      }
      _currentUser = user;
      notifyListeners();
      return Result.ok(user); // ← return user not null
    } catch (e) {
      return Result.error(Exception('Something went wrong'));
    }
  }

  @override
  Future<Result<AppUser>> signup({
    required String email,
    required String password,
  }) async {
    return Result.error(Exception('Signup not supported in local mode'));
  }

  @override
  Future<Result<void>> logout() async {
    try {
      _currentUser = null;
      notifyListeners();
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Logout failed'));
    }
  }
}
