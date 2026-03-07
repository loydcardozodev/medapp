// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_availability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DoctorAvailability _$DoctorAvailabilityFromJson(Map<String, dynamic> json) =>
    _DoctorAvailability(
      id: json['id'] as String,
      doctorId: json['doctorId'] as String,
      date: DateTime.parse(json['date'] as String),
      slots: (json['slots'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DoctorAvailabilityToJson(_DoctorAvailability instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctorId': instance.doctorId,
      'date': instance.date.toIso8601String(),
      'slots': instance.slots,
    };
