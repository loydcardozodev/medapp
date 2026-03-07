import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:medapp/domain/models/app_user/app_user.dart';
import 'package:medapp/ui/core/user_roles.dart';

class FirebaseAuthService {
  final firebase.FirebaseAuth _auth;

  FirebaseAuthService({firebase.FirebaseAuth? auth})
    : _auth = auth ?? firebase.FirebaseAuth.instance;

  // returns AppUser? not Firebase User?
  AppUser? get currentUser {
    final user = _auth.currentUser;
    if (user == null) return null;
    return AppUser(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      password: '',
      role: UserRole.customer,
    );
  }

  // returns Stream<AppUser?> not Stream<Firebase User?>
  Stream<AppUser?> get authStateChanges {
    return _auth.authStateChanges().map((user) {
      if (user == null) return null;
      return AppUser(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        password: '',
        role: UserRole.customer,
      );
    });
  }

  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signup(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
