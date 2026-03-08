import 'package:flutter/material.dart';
import 'package:medapp/data/repository/appointments/appointment_repository.dart';
import 'package:medapp/domain/models/appointment/appointment.dart';
import 'package:medapp/ui/core/appointment_status.dart';
import 'package:medapp/util/command.dart';
import 'package:medapp/util/result.dart';

class AppointmentViewModel extends ChangeNotifier {
  final AppointmentRepository _appointmentRepository;

  AppointmentViewModel({required AppointmentRepository appointmentRepository})
    : _appointmentRepository = appointmentRepository {
    loadAppointments = Command1(_loadAppointments);
    cancelAppointment = Command1(_cancelAppointment);
  }

  late final Command1<void, String> loadAppointments;
  late final Command1<void, String> cancelAppointment;

  List<Appointment> _all = [];
  List<Appointment> upcoming = [];
  List<Appointment> past = [];
  String? errorMessage;

  Future<Result<void>> _loadAppointments(String customerId) async {
    try {
      final result = await _appointmentRepository.getCustomerAppointments(
        customerId,
      );
      if (result is Ok<List<Appointment>>) {
        _all = result.value;
        _categorize();
        errorMessage = null;
      } else if (result is Error<List<Appointment>>) {
        errorMessage = result.error.toString();
      }
      notifyListeners();
      return const Result.ok(null);
    } catch (e) {
      errorMessage = 'Failed to load appointments';
      notifyListeners();
      return Result.error(Exception(e));
    }
  }

  Future<Result<void>> _cancelAppointment(String appointmentId) async {
    try {
      final result = await _appointmentRepository.cancelAppointment(
        appointmentId,
      );
      if (result is Ok<void>) {
        final index = _all.indexWhere((a) => a.id == appointmentId);
        if (index != -1) {
          _all[index] = _all[index].copyWith(
            status: AppointmentStatus.cancelled,
          );
          _categorize();
        }
        notifyListeners();
      }
      return result;
    } catch (e) {
      return Result.error(Exception('Cancel failed'));
    }
  }

  void _categorize() {
    final now = DateTime.now();
    upcoming =
        _all
            .where(
              (a) =>
                  a.date.isAfter(now) &&
                  (a.status == AppointmentStatus.confirmed ||
                      a.status == AppointmentStatus.pending),
            )
            .toList()
          ..sort((a, b) => a.date.compareTo(b.date));

    past =
        _all
            .where(
              (a) =>
                  a.date.isBefore(now) ||
                  a.status == AppointmentStatus.completed ||
                  a.status == AppointmentStatus.cancelled,
            )
            .toList()
          ..sort((a, b) => b.date.compareTo(a.date));
  }
}
