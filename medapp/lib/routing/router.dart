import 'package:go_router/go_router.dart';
import 'package:medapp/routing/routes.dart';
import 'package:medapp/ui/home/homepage.dart';

GoRouter router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(path: Routes.home, builder: (context, state) => const Homepage()),
  ],
);
