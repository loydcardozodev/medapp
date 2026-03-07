import 'package:medapp/config/app_config.dart';
import 'package:medapp/data/repository/auth/auth_repository.dart';
import 'package:medapp/data/repository/auth/auth_repository_firebase.dart';
import 'package:medapp/data/repository/auth/auth_repository_local.dart';
import 'package:medapp/data/services/firebase/auth/firebase_auth_service.dart';
import 'package:medapp/ui/sharedscreens/login/viewmodel/login_viewmodel.dart';
import 'package:medapp/ui/sharedscreens/signup/viewmodel/signup_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> buildProviders(AppConfig config) {
  final flavourProviders = config.useFirebase
      ? firebaseProviders
      : localProviders;

  return [...flavourProviders];
}

List<SingleChildWidget> firebaseProviders = [
  Provider<FirebaseAuthService>(create: (_) => FirebaseAuthService()),
  ChangeNotifierProxyProvider<FirebaseAuthService, AuthRepository>(
    create: (_) =>
        AuthRepositoryFirebase(firebaseAuthService: FirebaseAuthService()),
    update: (_, firebaseAuthService, __) =>
        AuthRepositoryFirebase(firebaseAuthService: firebaseAuthService),
  ),
  ProxyProvider<AuthRepository, SignupViewmodel>(
    update: (_, authRepository, __) =>
        SignupViewmodel(authRepository: authRepository),
  ),
  ProxyProvider<AuthRepository, LoginViewmodel>(
    update: (_, authRepository, __) =>
        LoginViewmodel(authRepository: authRepository),
  ),
];

List<SingleChildWidget> localProviders = [
  ChangeNotifierProvider<AuthRepository>(create: (_) => AuthRepositoryLocal()),
  ProxyProvider<AuthRepository, SignupViewmodel>(
    update: (_, authRepository, __) =>
        SignupViewmodel(authRepository: authRepository),
  ),
  ProxyProvider<AuthRepository, LoginViewmodel>(
    update: (_, authRepository, __) =>
        LoginViewmodel(authRepository: authRepository),
  ),
];
