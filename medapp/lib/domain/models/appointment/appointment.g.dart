// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Appointment _$AppointmentFromJson(Map<String, dynamic> json) => _Appointment(
  id: json['id'] as String,
  customerId: json['customerId'] as String,
  doctorId: json['doctorId'] as String,
  date: DateTime.parse(json['date'] as String),
  timeSlot: json['timeSlot'] as String,
  status: _statusFromJson(json['status'] as String),
  notes: json['notes'] as String?,
  cancelReason: json['cancelReason'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$AppointmentToJson(_Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'doctorId': instance.doctorId,
      'date': instance.date.toIso8601String(),
      'timeSlot': instance.timeSlot,
      'status': _statusToJson(instance.status),
      'notes': instance.notes,
      'cancelReason': instance.cancelReason,
      'createdAt': instance.createdAt.toIso8601String(),
    };
