// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MedicalRecord _$MedicalRecordFromJson(Map<String, dynamic> json) =>
    _MedicalRecord(
      id: json['id'] as String,
      appointmentId: json['appointmentId'] as String,
      customerId: json['customerId'] as String,
      doctorId: json['doctorId'] as String,
      diagnosis: json['diagnosis'] as String,
      prescriptions: (json['prescriptions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      doctorNotes: json['doctorNotes'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$MedicalRecordToJson(_MedicalRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointmentId': instance.appointmentId,
      'customerId': instance.customerId,
      'doctorId': instance.doctorId,
      'diagnosis': instance.diagnosis,
      'prescriptions': instance.prescriptions,
      'doctorNotes': instance.doctorNotes,
      'createdAt': instance.createdAt.toIso8601String(),
    };
