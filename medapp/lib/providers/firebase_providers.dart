import 'package:medapp/data/repository/auth/auth_repository.dart';
import 'package:medapp/data/services/auth/firebase_auth_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repository/auth/auth_repository_firebase.dart';

List<SingleChildWidget> firebaseProviders = [
  Provider<FirebaseAuthService>(create: (context) => FirebaseAuthService()),
  ProxyProvider<FirebaseAuthService, AuthRepository>(
    update: (context, firebaseAuthService, __) =>
        AuthRepositoryFirebase(firebaseAuthService: firebaseAuthService),
  ),
];
