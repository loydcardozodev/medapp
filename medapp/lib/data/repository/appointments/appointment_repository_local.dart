import 'package:medapp/data/repository/appointments/appointment_repository.dart';
import 'package:medapp/data/services/local/local_data_service.dart';
import 'package:medapp/domain/models/appointment/appointment.dart';
import 'package:medapp/ui/core/appointment_status.dart';
import 'package:medapp/util/result.dart';

class AppointmentRepositoryLocal extends AppointmentRepository {
  @override
  Future<Result<List<Appointment>>> getCustomerAppointments(
    String customerId,
  ) async {
    try {
      final data = LocalDataService.getAppointmentsForCustomer(customerId);
      return Result.ok(data);
    } catch (e) {
      return Result.error(Exception('Failed to load appointments'));
    }
  }

  @override
  Future<Result<List<Appointment>>> getDoctorAppointments(
    String doctorId,
  ) async {
    try {
      final data = LocalDataService.getAppointmentsForDoctor(doctorId);
      return Result.ok(data);
    } catch (e) {
      return Result.error(Exception('Failed to load appointments'));
    }
  }

  @override
  Future<Result<void>> createAppointment(Appointment appointment) async {
    try {
      LocalDataService.appointments.add(appointment);
      notifyListeners();
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Failed to create appointment'));
    }
  }

  @override
  Future<Result<void>> cancelAppointment(String appointmentId) async {
    try {
      final index = LocalDataService.appointments.indexWhere(
        (a) => a.id == appointmentId,
      );

      if (index == -1) {
        return Result.error(Exception('Appointment not found'));
      }

      final appointment = LocalDataService.appointments[index];

      LocalDataService.appointments[index] = appointment.copyWith(
        status: AppointmentStatus.cancelled,
      );

      notifyListeners();

      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Cancel failed'));
    }
  }
}
