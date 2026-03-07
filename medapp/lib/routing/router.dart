import 'package:go_router/go_router.dart';
import 'package:medapp/routing/routes.dart';
import 'package:medapp/ui/appointmentscreen/view/widget/appointment_screen.dart';
import 'package:medapp/ui/doctorlist/view/widget/doctors_list.dart';
import 'package:medapp/ui/home/view/homepage.dart';
import 'package:medapp/ui/login/view/loginscreen.dart';
import 'package:medapp/ui/signup/view/signupscreen.dart';
import 'package:medapp/ui/splashscreen/view/splashscreen.dart';
import 'package:provider/provider.dart';

GoRouter router = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(path: Routes.home, builder: (context, state) => const HomePage()),
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const Splashscreen(),
    ),
    GoRoute(
      path: Routes.signup,
      builder: (context, state) => Signupscreen(
        // viewmodel: context.read<SignupViewmodel>(),
      ),
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const Loginscreen(),
    ),

    GoRoute(
      path: Routes.appointmentscreen,
      builder: (context, state) => const AppointmentScreen(),
    ),

    GoRoute(
      path: Routes.doctorList,
      builder: (context, state) => const DoctorsList(),
    ),
  ],
);
