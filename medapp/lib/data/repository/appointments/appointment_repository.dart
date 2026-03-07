import 'package:flutter/material.dart';
import 'package:medapp/domain/models/appointment/appointment.dart';
import 'package:medapp/util/result.dart';

abstract class AppointmentRepository extends ChangeNotifier {
  Future<Result<List<Appointment>>> getCustomerAppointments(String customerId);

  Future<Result<List<Appointment>>> getDoctorAppointments(String doctorId);

  Future<Result<void>> createAppointment(Appointment appointment);

  Future<Result<void>> cancelAppointment(String appointmentId);
}
