import 'package:flutter/foundation.dart';
import 'package:medapp/data/repository/appointments/appointment_repository.dart';
import 'package:medapp/data/repository/auth/auth_repository.dart';
import 'package:medapp/data/repository/doctors/doctor_repository.dart';
import 'package:medapp/domain/models/app_user/app_user.dart';
import 'package:medapp/domain/models/appointment/appointment.dart';
import 'package:medapp/domain/models/doctors/doctor.dart';
import 'package:medapp/ui/core/appointment_status.dart';
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

  String searchQuery = '';

  Future<Result<void>> _loadHome() async {
    try {
      currentUser = _authRepository.currentUser;

      if (currentUser == null) {
        return Result.error(Exception('No authenticated user'));
      }

      final results = await Future.wait([
        _doctorRepository.getDoctors(),
        _appointmentRepository.getCustomerAppointments(currentUser!.id),
      ]);

      final doctorsResult = results[0] as Result<List<Doctor>>;
      final appointmentsResult = results[1] as Result<List<Appointment>>;

      if (doctorsResult is Ok<List<Doctor>>) {
        doctors = doctorsResult.value;
        filteredDoctors = List.from(doctors);
      }

      if (appointmentsResult is Ok<List<Appointment>>) {
        final now = DateTime.now();
        upcomingAppointments =
            appointmentsResult.value
                .where(
                  (a) =>
                      a.date.isAfter(now) &&
                      (a.status == AppointmentStatus.confirmed ||
                          a.status == AppointmentStatus.pending),
                )
                .toList()
              ..sort((a, b) => a.date.compareTo(b.date));
      }

      notifyListeners();
      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Failed to load home: $e'));
    }
  }

  Future<Result<void>> _searchDoctors(String query) async {
    searchQuery = query;

    filteredDoctors = query.trim().isEmpty
        ? List.from(doctors)
        : doctors
              .where(
                (d) =>
                    d.specialty.toLowerCase().contains(query.toLowerCase()) ||
                    // also search by doctor name via the specialty field
                    d.specialty.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();

    notifyListeners();
    return const Result.ok(null);
  }
}
