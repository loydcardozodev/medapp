import 'package:medapp/data/repository/medical_records/medical_record_repository.dart';
import 'package:medapp/data/services/local/local_data_service.dart';
import 'package:medapp/domain/models/medical_record/medical_record.dart';
import 'package:medapp/util/result.dart';

class MedicalRecordRepositoryLocal extends MedicalRecordRepository {
  @override
  Future<Result<List<MedicalRecord>>> getCustomerRecords(
    String customerId,
  ) async {
    try {
      final data = LocalDataService.getMedicalRecordsForCustomer(customerId);
      return Result.ok(data);
    } catch (e) {
      return Result.error(Exception('Failed to load medical records'));
    }
  }

  @override
  Future<Result<void>> addRecord(MedicalRecord record) async {
    try {
      LocalDataService.medicalRecords.add(record);
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Failed to add record'));
    }
  }
}
