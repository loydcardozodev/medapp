import 'package:medapp/config/app_config.dart';
import 'package:medapp/data/repository/appointments/appointment_repository.dart';
import 'package:medapp/data/repository/appointments/appointment_repository_local.dart';
import 'package:medapp/data/repository/auth/auth_repository.dart';
import 'package:medapp/data/repository/auth/auth_repository_firebase.dart';
import 'package:medapp/data/repository/auth/auth_repository_local.dart';
import 'package:medapp/data/repository/doctors/doctor_repository.dart';
import 'package:medapp/data/repository/doctors/doctor_repository_local.dart';
import 'package:medapp/data/repository/medical_records/medical_record_repository.dart';
import 'package:medapp/data/repository/medical_records/medical_repository_local.dart';
import 'package:medapp/data/services/firebase/auth/firebase_auth_service.dart';

import 'package:medapp/ui/patient_screen/appointement_detail/viewmodel/appointment_details_viewmodel.dart';
import 'package:medapp/ui/patient_screen/appointment_booking/viewmodel/appointment_booking_viewmodel.dart';
import 'package:medapp/ui/patient_screen/appointmentscreen/viewmodel/appointment_viewmodel.dart';
import 'package:medapp/ui/patient_screen/doctor_detail/viewmodel/doctor_detail_viewmodel.dart';
import 'package:medapp/ui/patient_screen/doctorlist/viewmodel/doctor_list_viewmodel.dart';
import 'package:medapp/ui/patient_screen/home/viewmodel/home_viewmodel.dart';
import 'package:medapp/ui/patient_screen/medical_record_screen/viewmodel/medical_record_viewmodel.dart';

import 'package:medapp/ui/sharedscreens/login/viewmodel/login_viewmodel.dart';
import 'package:medapp/ui/sharedscreens/signup/viewmodel/signup_viewmodel.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> buildProviders(AppConfig config) {
  return config.useFirebase ? firebaseProviders : localProviders;
}

List<SingleChildWidget> firebaseProviders = [
  Provider<FirebaseAuthService>(create: (_) => FirebaseAuthService()),

  Provider<AuthRepository>(
    create: (context) => AuthRepositoryFirebase(
      firebaseAuthService: context.read<FirebaseAuthService>(),
    ),
  ),

  Provider<DoctorRepository>(create: (_) => DoctorRepositoryLocal()),

  Provider<AppointmentRepository>(create: (_) => AppointmentRepositoryLocal()),

  Provider<MedicalRecordRepository>(
    create: (_) => MedicalRecordRepositoryLocal(),
  ),

  ChangeNotifierProvider(
    create: (context) =>
        SignupViewmodel(authRepository: context.read<AuthRepository>()),
  ),

  ChangeNotifierProvider(
    create: (context) =>
        LoginViewmodel(authRepository: context.read<AuthRepository>()),
  ),

  ChangeNotifierProvider(
    create: (context) => HomeViewModel(
      authRepository: context.read<AuthRepository>(),
      doctorRepository: context.read<DoctorRepository>(),
      appointmentRepository: context.read<AppointmentRepository>(),
      medicalRecordRepository: context.read<MedicalRecordRepository>(),
    ),
  ),

  ChangeNotifierProvider(
    create: (context) => MedicalRecordViewModel(
      medicalRecordRepository: context.read<MedicalRecordRepository>(),
      authRepository: context.read<AuthRepository>(),
    ),
  ),

  ChangeNotifierProvider(
    create: (context) => DoctorsListViewModel(
      doctorRepository: context.read<DoctorRepository>(),
    ),
  ),

  ChangeNotifierProvider(
    create: (context) => DoctorDetailViewModel(
      doctorRepository: context.read<DoctorRepository>(),
      authRepository: context.read<AuthRepository>(),
    ),
  ),

  ChangeNotifierProvider(
    create: (context) => AppointmentViewModel(
      appointmentRepository: context.read<AppointmentRepository>(),
    ),
  ),

  ChangeNotifierProvider(
    create: (context) => AppointmentBookingViewmodel(
      doctorRepository: context.read<DoctorRepository>(),
      appointmentRepository: context.read<AppointmentRepository>(),
    ),
  ),

  ChangeNotifierProvider(
    create: (context) => AppointmentDetailViewModel(
      appointmentRepository: context.read<AppointmentRepository>(),
      doctorRepository: context.read<DoctorRepository>(),
    ),
  ),
];

List<SingleChildWidget> localProviders = [
  Provider<AuthRepository>(create: (_) => AuthRepositoryLocal()),

  Provider<DoctorRepository>(create: (_) => DoctorRepositoryLocal()),

  Provider<AppointmentRepository>(create: (_) => AppointmentRepositoryLocal()),

  Provider<MedicalRecordRepository>(
    create: (_) => MedicalRecordRepositoryLocal(),
  ),

  ChangeNotifierProvider(
    create: (context) =>
        SignupViewmodel(authRepository: context.read<AuthRepository>()),
  ),

  ChangeNotifierProvider(
    create: (context) =>
        LoginViewmodel(authRepository: context.read<AuthRepository>()),
  ),

  ChangeNotifierProvider(
    create: (context) => HomeViewModel(
      authRepository: context.read<AuthRepository>(),
      doctorRepository: context.read<DoctorRepository>(),
      appointmentRepository: context.read<AppointmentRepository>(),
      medicalRecordRepository: context.read<MedicalRecordRepository>(),
    ),
  ),

  ChangeNotifierProvider(
    create: (context) => MedicalRecordViewModel(
      medicalRecordRepository: context.read<MedicalRecordRepository>(),
      authRepository: context.read<AuthRepository>(),
    ),
  ),

  ChangeNotifierProvider(
    create: (context) => DoctorsListViewModel(
      doctorRepository: context.read<DoctorRepository>(),
    ),
  ),

  ChangeNotifierProvider(
    create: (context) => DoctorDetailViewModel(
      doctorRepository: context.read<DoctorRepository>(),
      authRepository: context.read<AuthRepository>(),
    ),
  ),

  ChangeNotifierProvider(
    create: (context) => AppointmentViewModel(
      appointmentRepository: context.read<AppointmentRepository>(),
    ),
  ),

  ChangeNotifierProvider(
    create: (context) => AppointmentBookingViewmodel(
      doctorRepository: context.read<DoctorRepository>(),
      appointmentRepository: context.read<AppointmentRepository>(),
    ),
  ),

  ChangeNotifierProvider(
    create: (context) => AppointmentDetailViewModel(
      appointmentRepository: context.read<AppointmentRepository>(),
      doctorRepository: context.read<DoctorRepository>(),
    ),
  ),
];
