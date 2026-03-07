import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor.freezed.dart';
part 'doctor.g.dart';

@freezed
class Doctor with _$Doctor {
  const factory Doctor({
    required String id,
    required String userId,
    required String specialty,
    required String bio,
    required double rating,
    required int reviewCount,
    required int experienceYears,
    required List<String> availableDays,
    required List<String> availableSlots,
    required double consultationFee,
    @Default(true) bool isActive,
  }) = _Doctor;

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);
}
