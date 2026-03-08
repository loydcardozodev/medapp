import 'package:flutter/material.dart';
import 'package:medapp/data/repository/appointments/appointment_repository.dart';
import 'package:medapp/data/repository/doctors/doctor_repository.dart';
import 'package:medapp/domain/models/appointment/appointment.dart';
import 'package:medapp/domain/models/doctors/doctor.dart';
import 'package:medapp/ui/core/appointment_status.dart';
import 'package:medapp/util/command.dart';
import 'package:medapp/util/result.dart';

class AppointmentBookingViewmodel extends ChangeNotifier {
  final DoctorRepository _doctorRepository;
  final AppointmentRepository _appointmentRepository;

  AppointmentBookingViewmodel({
    required DoctorRepository doctorRepository,
    required AppointmentRepository appointmentRepository,
  }) : _doctorRepository = doctorRepository,
       _appointmentRepository = appointmentRepository {
    loadDoctor = Command1(_loadDoctor);
    bookAppointment = Command1(_bookAppointment);
  }

  late final Command1<void, String> loadDoctor;
  late final Command1<void, String> bookAppointment;

  Doctor? doctor;
  DateTime? selectedDate;
  String? selectedSlot;
  String? errorMessage;
  bool bookingSuccess = false;

  void selectDate(DateTime date) {
    selectedDate = date;
    selectedSlot = null;
    notifyListeners();
  }

  void selectSlot(String slot) {
    selectedSlot = slot;
    notifyListeners();
  }

  bool get canBook =>
      doctor != null && selectedDate != null && selectedSlot != null;

  Future<Result<void>> _loadDoctor(String doctorId) async {
    try {
      final result = await _doctorRepository.getDoctorById(doctorId);
      if (result is Ok<Doctor>) {
        doctor = result.value;
        errorMessage = null;
      } else if (result is Error<Doctor>) {
        errorMessage = result.error.toString();
      }
      notifyListeners();
      return const Result.ok(null);
    } catch (e) {
      errorMessage = 'Failed to load doctor';
      notifyListeners();
      return Result.error(Exception(e));
    }
  }

  Future<Result<void>> _bookAppointment(String customerId) async {
    if (!canBook) return Result.error(Exception('Select date and time slot'));
    try {
      final appointment = Appointment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        customerId: customerId,
        doctorId: doctor!.id,
        date: selectedDate!,
        timeSlot: selectedSlot!,
        status: AppointmentStatus.pending,
        createdAt: DateTime.now(),
      );
      final result = await _appointmentRepository.createAppointment(
        appointment,
      );
      if (result is Ok<void>) {
        bookingSuccess = true;
        errorMessage = null;
      } else if (result is Error<void>) {
        errorMessage = result.error.toString();
      }
      notifyListeners();
      return result;
    } catch (e) {
      errorMessage = 'Booking failed';
      notifyListeners();
      return Result.error(Exception(e));
    }
  }

  void reset() {
    selectedDate = null;
    selectedSlot = null;
    bookingSuccess = false;
    errorMessage = null;
    notifyListeners();
  }
}
