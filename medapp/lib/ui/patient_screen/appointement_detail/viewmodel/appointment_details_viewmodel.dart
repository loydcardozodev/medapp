import 'package:flutter/material.dart';
import 'package:medapp/data/repository/appointments/appointment_repository.dart';
import 'package:medapp/data/repository/doctors/doctor_repository.dart';
import 'package:medapp/domain/models/appointment/appointment.dart';
import 'package:medapp/domain/models/doctors/doctor.dart';
import 'package:medapp/ui/core/appointment_status.dart';
import 'package:medapp/util/command.dart';
import 'package:medapp/util/result.dart';

class AppointmentDetailViewModel extends ChangeNotifier {
  final AppointmentRepository _appointmentRepository;
  final DoctorRepository _doctorRepository;

  AppointmentDetailViewModel({
    required AppointmentRepository appointmentRepository,
    required DoctorRepository doctorRepository,
  }) : _appointmentRepository = appointmentRepository,
       _doctorRepository = doctorRepository {
    loadDetail = Command1(_loadDetail);
    cancelAppointment = Command0(_cancelAppointment);
  }

  late final Command1<void, Appointment> loadDetail;
  late final Command0<void> cancelAppointment;

  Appointment? appointment;
  Doctor? doctor;
  String? errorMessage;
  bool cancelSuccess = false;

  Future<Result<void>> _loadDetail(Appointment appt) async {
    try {
      appointment = appt;
      final result = await _doctorRepository.getDoctorById(appt.doctorId);
      if (result is Ok<Doctor>) {
        doctor = result.value;
        errorMessage = null;
      } else if (result is Error<Doctor>) {
        errorMessage = result.error.toString();
      }
      notifyListeners();
      return const Result.ok(null);
    } catch (e) {
      errorMessage = 'Failed to load details';
      notifyListeners();
      return Result.error(Exception(e));
    }
  }

  Future<Result<void>> _cancelAppointment() async {
    if (appointment == null) return Result.error(Exception('No appointment'));
    try {
      final result = await _appointmentRepository.cancelAppointment(
        appointment!.id,
      );
      if (result is Ok<void>) {
        appointment = appointment!.copyWith(
          status: AppointmentStatus.cancelled,
        );
        cancelSuccess = true;
        errorMessage = null;
        notifyListeners();
      }
      return result;
    } catch (e) {
      errorMessage = 'Cancel failed';
      notifyListeners();
      return Result.error(Exception(e));
    }
  }
}
