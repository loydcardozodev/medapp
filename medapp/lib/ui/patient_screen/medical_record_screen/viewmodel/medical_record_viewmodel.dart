import 'package:flutter/material.dart';
import 'package:medapp/data/repository/auth/auth_repository.dart';
import 'package:medapp/data/repository/medical_records/medical_record_repository.dart';
import 'package:medapp/domain/models/medical_record/medical_record.dart';
import 'package:medapp/util/command.dart';
import 'package:medapp/util/result.dart';

class MedicalRecordViewModel extends ChangeNotifier {
  final MedicalRecordRepository _medicalRecordRepository;
  final AuthRepository _authRepository;

  MedicalRecordViewModel({
    required MedicalRecordRepository medicalRecordRepository,
    required AuthRepository authRepository,
  }) : _medicalRecordRepository = medicalRecordRepository,
       _authRepository = authRepository {
    loadRecords = Command0(_loadRecords);
  }

  late final Command0<void> loadRecords;

  List<MedicalRecord> records = [];
  String? errorMessage;

  Future<Result<void>> _loadRecords() async {
    try {
      final user = _authRepository.currentUser;
      if (user == null) return Result.error(Exception('No user'));

      final result = await _medicalRecordRepository.getCustomerRecords(user.id);
      if (result is Ok<List<MedicalRecord>>) {
        records = result.value;
        errorMessage = null;
      } else if (result is Error<List<MedicalRecord>>) {
        errorMessage = result.error.toString();
      }
      notifyListeners();
      return const Result.ok(null);
    } catch (e) {
      errorMessage = 'Failed to load records';
      notifyListeners();
      return Result.error(Exception(e));
    }
  }
}
