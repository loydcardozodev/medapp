// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Doctor _$DoctorFromJson(Map<String, dynamic> json) => _Doctor(
  id: json['id'] as String,
  userId: json['userId'] as String,
  specialty: json['specialty'] as String,
  bio: json['bio'] as String,
  rating: (json['rating'] as num).toDouble(),
  reviewCount: (json['reviewCount'] as num).toInt(),
  experienceYears: (json['experienceYears'] as num).toInt(),
  availableDays: (json['availableDays'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  availableSlots: (json['availableSlots'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  consultationFee: (json['consultationFee'] as num).toDouble(),
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$DoctorToJson(_Doctor instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'specialty': instance.specialty,
  'bio': instance.bio,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'experienceYears': instance.experienceYears,
  'availableDays': instance.availableDays,
  'availableSlots': instance.availableSlots,
  'consultationFee': instance.consultationFee,
  'isActive': instance.isActive,
};
