import 'package:flutter/foundation.dart';
import 'package:medapp/data/repository/appointments/appointment_repository.dart';
import 'package:medapp/data/repository/auth/auth_repository.dart';
import 'package:medapp/data/repository/doctors/doctor_repository.dart';
import 'package:medapp/data/repository/medical_records/medical_record_repository.dart';
import 'package:medapp/domain/models/app_user/app_user.dart';
import 'package:medapp/domain/models/appointment/appointment.dart';
import 'package:medapp/domain/models/doctors/doctor.dart';
import 'package:medapp/domain/models/medical_record/medical_record.dart';
import 'package:medapp/ui/core/appointment_status.dart';
import 'package:medapp/util/command.dart';
import 'package:medapp/util/result.dart';

class HomeViewModel extends ChangeNotifier {
  final DoctorRepository _doctorRepository;
  final AppointmentRepository _appointmentRepository;
  final AuthRepository _authRepository;
  final MedicalRecordRepository _medicalRecordRepository;

  HomeViewModel({
    required DoctorRepository doctorRepository,
    required AppointmentRepository appointmentRepository,
    required AuthRepository authRepository,
    required MedicalRecordRepository medicalRecordRepository,
  }) : _doctorRepository = doctorRepository,
       _appointmentRepository = appointmentRepository,
       _authRepository = authRepository,
       _medicalRecordRepository = medicalRecordRepository {
    loadHome = Command0(_loadHome);
    searchDoctors = Command1(_searchDoctors);
  }

  late final Command0<void> loadHome;
  late final Command1<void, String> searchDoctors;

  AppUser? currentUser;

  List<Doctor> doctors = [];
  List<Doctor> filteredDoctors = [];
  List<Appointment> upcomingAppointments = [];
  List<MedicalRecord> records = [];

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
        _medicalRecordRepository.getCustomerRecords(currentUser!.id),
      ]);

      final doctorsResult = results[0] as Result<List<Doctor>>;
      final appointmentsResult = results[1] as Result<List<Appointment>>;
      final recordsResult = results[2] as Result<List<MedicalRecord>>;

      /// Doctors
      if (doctorsResult is Ok<List<Doctor>>) {
        doctors = doctorsResult.value;
        filteredDoctors = List.from(doctors);
      }

      /// Appointments
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

      /// Medical Records
      if (recordsResult is Ok<List<MedicalRecord>>) {
        records = recordsResult.value
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
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
                    d.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();

    notifyListeners();
    return const Result.ok(null);
  }
}
