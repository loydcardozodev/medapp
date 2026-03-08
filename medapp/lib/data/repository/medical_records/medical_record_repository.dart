import 'package:flutter/material.dart';
import 'package:medapp/domain/models/medical_record/medical_record.dart';
import 'package:medapp/util/result.dart';

abstract class MedicalRecordRepository {
  Future<Result<List<MedicalRecord>>> getCustomerRecords(String customerId);

  Future<Result<void>> addRecord(MedicalRecord record);
}
