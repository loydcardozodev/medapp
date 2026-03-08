import 'package:go_router/go_router.dart';
import 'package:medapp/domain/models/appointment/appointment.dart';
import 'package:medapp/domain/models/app_user/app_user.dart';
import 'package:medapp/domain/models/medical_record/medical_record.dart';
import 'package:medapp/routing/routes.dart';
import 'package:medapp/ui/doctor_screen/add_medical_record/view/add_medical_record.dart';
import 'package:medapp/ui/doctor_screen/appointment_details/view/doc_appointment_detail.dart';
import 'package:medapp/ui/doctor_screen/appointments/view/doc_appointment.dart';
import 'package:medapp/ui/doctor_screen/doctor_dashboard/view/doc_dashboard.dart';
import 'package:medapp/ui/doctor_screen/manage_availability/view/manage_availability.dart';
import 'package:medapp/ui/doctor_screen/patient_list/view/patient_list.dart';
import 'package:medapp/ui/doctor_screen/patients_details/view/patient_detail.dart';
import 'package:medapp/ui/patient_screen/appointement_detail/view/appointment_detail.dart';
import 'package:medapp/ui/patient_screen/appointment_booking/view/appointment_booking.dart';
import 'package:medapp/ui/patient_screen/appointmentscreen/view/widget/appointment_screen.dart';
import 'package:medapp/ui/patient_screen/doctor_detail/view/doctor_detail.dart';
import 'package:medapp/ui/patient_screen/doctorlist/view/widget/doctors_list.dart';
import 'package:medapp/ui/patient_screen/home/view/homepage.dart';
import 'package:medapp/ui/patient_screen/medical_record_detail/view/medical_record_detail.dart';
import 'package:medapp/ui/sharedscreens/edit_profile_screen/view/edit_profile_screen.dart';
import 'package:medapp/ui/sharedscreens/login/view/loginscreen.dart';
import 'package:medapp/ui/sharedscreens/profile_screen/view/profile_screen.dart';
import 'package:medapp/ui/sharedscreens/signup/view/signupscreen.dart';
import 'package:medapp/ui/sharedscreens/splashscreen/view/splashscreen.dart';
import '../ui/patient_screen/medical_record_screen/view/medical_record_screen.dart';

GoRouter router = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const Splashscreen(),
    ),
    GoRoute(
      path: Routes.signup,
      builder: (context, state) => const Signupscreen(),
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const Loginscreen(),
    ),
    GoRoute(
      path: Routes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: Routes.editProfile,
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(path: Routes.home, builder: (context, state) => const HomePage()),

    GoRoute(
      path: Routes.appointmentscreen,
      builder: (context, state) =>
          AppointmentScreen(currentUser: state.extra as AppUser?),
    ),

    // context.go(Routes.appointmentDetail, extra: appointment)
    GoRoute(
      path: Routes.appointmentDetail,
      builder: (context, state) =>
          AppointmentDetail(appointment: state.extra as Appointment),
    ),

    GoRoute(
      path: Routes.appointmentBooking,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return AppointmentBooking(
          doctorId: args['doctorId'] as String,
          currentUser: args['currentUser'] as AppUser,
        );
      },
    ),

    GoRoute(
      path: Routes.doctorList,
      builder: (context, state) => const DoctorsList(),
    ),

    // context.go(Routes.doctorDetail, extra: doctorId)
    GoRoute(
      path: Routes.doctorDetail,
      builder: (context, state) =>
          DoctorDetail(doctorId: state.extra as String),
    ),

    GoRoute(
      path: Routes.medicalRecord,
      builder: (context, state) => MedicalRecordView(),
    ),
    GoRoute(
      path: Routes.medicalRecordDetail,
      builder: (context, state) =>
          MedicalRecordDetail(record: state.extra as MedicalRecord),
    ),
    GoRoute(
      path: Routes.addMedicalRecord,
      builder: (context, state) => const AddMedicalRecord(),
    ),
    GoRoute(
      path: Routes.docAppointmentDetails,
      builder: (context, state) => const DocAppointmentDetail(),
    ),
    GoRoute(
      path: Routes.doctorDashboard,
      builder: (context, state) => const DocDashboard(),
    ),
    GoRoute(
      path: Routes.doctorAppointment,
      builder: (context, state) => const DocAppointment(),
    ),
    GoRoute(
      path: Routes.manageAvailability,
      builder: (context, state) => const ManageAvailability(),
    ),
    GoRoute(
      path: Routes.patientList,
      builder: (context, state) => const PatientList(),
    ),
    GoRoute(
      path: Routes.patientDetail,
      builder: (context, state) => const PatientDetail(),
    ),
  ],
);
