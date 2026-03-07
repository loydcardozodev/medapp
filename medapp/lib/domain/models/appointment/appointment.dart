import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:medapp/ui/core/appointment_status.dart';

part 'appointment.freezed.dart';
part 'appointment.g.dart';

@freezed
abstract class Appointment with _$Appointment {
  const factory Appointment({
    required String id,
    required String customerId,
    required String doctorId,
    required DateTime date,
    required String timeSlot,
    @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
    required AppointmentStatus status,
    String? notes,
    String? cancelReason,
    required DateTime createdAt,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);
}

AppointmentStatus _statusFromJson(String value) =>
    AppointmentStatus.values.byName(value);

String _statusToJson(AppointmentStatus status) => status.name;
