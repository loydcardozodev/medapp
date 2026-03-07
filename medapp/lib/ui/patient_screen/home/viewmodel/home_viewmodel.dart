import 'package:flutter/foundation.dart';
import 'package:medapp/data/repository/appointments/appointment_repository.dart';
import 'package:medapp/data/repository/auth/auth_repository.dart';
import 'package:medapp/data/repository/doctors/doctor_repository.dart';
import 'package:medapp/domain/models/app_user/app_user.dart';
import 'package:medapp/domain/models/appointment/appointment.dart';
import 'package:medapp/domain/models/doctors/doctor.dart';
import 'package:medapp/util/command.dart';
import 'package:medapp/util/result.dart';

class HomeViewModel extends ChangeNotifier {
  final DoctorRepository _doctorRepository;
  final AppointmentRepository _appointmentRepository;
  final AuthRepository _authRepository;

  HomeViewModel({
    required DoctorRepository doctorRepository,
    required AppointmentRepository appointmentRepository,
    required AuthRepository authRepository,
  }) : _doctorRepository = doctorRepository,
       _appointmentRepository = appointmentRepository,
       _authRepository = authRepository {
    loadHome = Command0(_loadHome);
    searchDoctors = Command1(_searchDoctors);
  }

  late final Command0<void> loadHome;
  late final Command1<void, String> searchDoctors;

  AppUser? currentUser;
  List<Doctor> doctors = [];
  List<Doctor> filteredDoctors = [];
  List<Appointment> upcomingAppointments = [];

  String searchQuery = "";

  Future<Result<void>> _loadHome() async {
    try {
      currentUser = _authRepository.currentUser;

      final doctorsResult = await _doctorRepository.getDoctors();

      final appointmentResult = await _appointmentRepository
          .getCustomerAppointments(currentUser!.id);

      if (doctorsResult is Ok<List<Doctor>>) {
        doctors = doctorsResult.value;
        filteredDoctors = doctors;
      }

      if (appointmentResult is Ok<List<Appointment>>) {
        upcomingAppointments = appointmentResult.value;
      }

      notifyListeners();

      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception("Failed to load home"));
    }
  }

  Future<Result<void>> _searchDoctors(String query) async {
    searchQuery = query;

    filteredDoctors = doctors
        .where((d) => d.specialty.toLowerCase().contains(query.toLowerCase()))
        .toList();

    notifyListeners();

    return const Result.ok(null);
  }
}
