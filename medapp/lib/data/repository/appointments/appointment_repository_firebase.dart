import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medapp/data/repository/appointments/appointment_repository.dart';
import 'package:medapp/domain/models/appointment/appointment.dart';
import 'package:medapp/ui/core/appointment_status.dart';
import 'package:medapp/util/result.dart';

class AppointmentRepositoryFirebase extends AppointmentRepository {
  AppointmentRepositoryFirebase({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _appointments =>
      _firestore.collection('appointments');

  @override
  Future<Result<List<Appointment>>> getCustomerAppointments(
    String customerId,
  ) async {
    try {
      final snapshot = await _appointments
          .where('customerId', isEqualTo: customerId)
          .get();

      final data = snapshot.docs
          .map((doc) => Appointment.fromJson({...doc.data(), 'id': doc.id}))
          .toList();

      return Result.ok(data);
    } catch (e) {
      return Result.error(Exception('Failed to load appointments: $e'));
    }
  }

  @override
  Future<Result<List<Appointment>>> getDoctorAppointments(
    String doctorId,
  ) async {
    try {
      final snapshot = await _appointments
          .where('doctorId', isEqualTo: doctorId)
          .get();

      final data = snapshot.docs
          .map((doc) => Appointment.fromJson({...doc.data(), 'id': doc.id}))
          .toList();

      return Result.ok(data);
    } catch (e) {
      return Result.error(Exception('Failed to load appointments: $e'));
    }
  }

  @override
  Future<Result<void>> createAppointment(Appointment appointment) async {
    try {
      final json = appointment.toJson();
      // Let Firestore generate the document ID if appointment.id is empty,
      // otherwise use it as the document ID for consistency.
      if (appointment.id.isEmpty) {
        await _appointments.add(json);
      } else {
        await _appointments.doc(appointment.id).set(json);
      }

      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Failed to create appointment: $e'));
    }
  }

  @override
  Future<Result<void>> cancelAppointment(String appointmentId) async {
    try {
      final docRef = _appointments.doc(appointmentId);
      final snapshot = await docRef.get();

      if (!snapshot.exists) {
        return Result.error(Exception('Appointment not found'));
      }

      await docRef.update({'status': AppointmentStatus.cancelled.name});

      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Cancel failed: $e'));
    }
  }
}
