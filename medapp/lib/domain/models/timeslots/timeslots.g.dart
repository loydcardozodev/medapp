// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeslots.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) => _TimeSlot(
  id: json['id'] as String,
  doctorId: json['doctorId'] as String,
  date: DateTime.parse(json['date'] as String),
  time: json['time'] as String,
  isBooked: json['isBooked'] as bool,
);

Map<String, dynamic> _$TimeSlotToJson(_TimeSlot instance) => <String, dynamic>{
  'id': instance.id,
  'doctorId': instance.doctorId,
  'date': instance.date.toIso8601String(),
  'time': instance.time,
  'isBooked': instance.isBooked,
};
