import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:medapp/domain/models/app_user/app_user.dart';
import 'package:medapp/ui/core/user_roles.dart';

class FirebaseAuthService {
  FirebaseAuthService({
    firebase.FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  }) : _auth = auth ?? firebase.FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance;

  final firebase.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  // --- Private Helpers ---

  Future<UserRole> _fetchRole(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      final roleStr = doc.data()?['role'] as String?;
      return UserRole.values.firstWhere(
        (r) => r.name == roleStr,
        orElse: () => UserRole.patient,
      );
    } catch (_) {
      return UserRole.patient;
    }
  }

  AppUser _mapUser(firebase.User user, UserRole role) {
    return AppUser(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      password: '',
      role: role,
    );
  }

  // --- Public API ---

  /// Returns the current user with role fetched from Firestore.
  /// Returns null if no user is signed in.
  Future<AppUser?> get currentUser async {
    final user = _auth.currentUser;
    if (user == null) return null;
    final role = await _fetchRole(user.uid);
    return _mapUser(user, role);
  }

  /// Emits a new [AppUser] whenever auth state changes, with role from Firestore.
  Stream<AppUser?> get authStateChanges {
    return _auth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      final role = await _fetchRole(user.uid);
      return _mapUser(user, role);
    });
  }

  Future<AppUser> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user!;
    final role = await _fetchRole(user.uid);
    return _mapUser(user, role);
  }

  /// Creates a Firebase Auth account AND writes the user doc to Firestore.
  /// [role] defaults to [UserRole.patient] if not provided.
  Future<AppUser> signup({
    required String email,
    required String password,
    required String name,
    UserRole role = UserRole.patient,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user!;

    await user.updateDisplayName(name);

    // Write user doc so _fetchRole works for all future sessions.
    await _firestore.collection('users').doc(user.uid).set({
      'name': name,
      'email': email,
      'role': role.name,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return _mapUser(user, role);
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
