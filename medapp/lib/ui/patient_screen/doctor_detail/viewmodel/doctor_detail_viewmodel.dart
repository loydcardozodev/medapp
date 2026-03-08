import 'package:medapp/data/repository/auth/auth_repository.dart';
import 'package:medapp/data/repository/doctors/doctor_repository.dart';
import 'package:flutter/material.dart';
import 'package:medapp/data/repository/auth/auth_repository.dart';
import 'package:medapp/data/repository/doctors/doctor_repository.dart';
import 'package:medapp/domain/models/app_user/app_user.dart';
import 'package:medapp/domain/models/doctors/doctor.dart';
import 'package:medapp/util/command.dart';
import 'package:medapp/util/result.dart';

class DoctorDetailViewModel extends ChangeNotifier {
  final DoctorRepository _doctorRepository;
  final AuthRepository _authRepository;

  DoctorDetailViewModel({
    required DoctorRepository doctorRepository,
    required AuthRepository authRepository,
  }) : _doctorRepository = doctorRepository,
       _authRepository = authRepository {
    loadDoctor = Command1(_loadDoctor);
  }

  late final Command1<void, String> loadDoctor;

  Doctor? doctor;
  String? errorMessage;

  AppUser? get currentUser => _authRepository.currentUser;

  Future<Result<void>> _loadDoctor(String doctorId) async {
    try {
      final result = await _doctorRepository.getDoctorById(doctorId);
      if (result is Ok<Doctor>) {
        doctor = result.value;
        errorMessage = null;
      } else if (result is Error<Doctor>) {
        errorMessage = result.error.toString();
      }
      notifyListeners();
      return const Result.ok(null);
    } catch (e) {
      errorMessage = 'Failed to load doctor';
      notifyListeners();
      return Result.error(Exception(e));
    }
  }
}
