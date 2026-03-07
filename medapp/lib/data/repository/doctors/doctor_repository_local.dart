import 'package:medapp/data/repository/doctors/doctor_repository.dart';
import 'package:medapp/data/services/local/local_data_service.dart';
import 'package:medapp/domain/models/doctors/doctor.dart';
import 'package:medapp/util/result.dart';

class DoctorRepositoryLocal extends DoctorRepository {
  @override
  Future<Result<List<Doctor>>> getDoctors() async {
    try {
      return Result.ok(LocalDataService.doctors);
    } catch (e) {
      return Result.error(Exception('Failed to load doctors'));
    }
  }

  @override
  Future<Result<Doctor>> getDoctorById(String id) async {
    try {
      final doctor = LocalDataService.doctors.firstWhere((d) => d.id == id);
      return Result.ok(doctor);
    } catch (e) {
      return Result.error(Exception('Doctor not found'));
    }
  }

  @override
  Future<Result<Doctor>> getDoctorByUserId(String userId) async {
    try {
      final doctor = LocalDataService.getDoctorByUserId(userId);
      if (doctor == null) {
        return Result.error(Exception('Doctor not found'));
      }
      return Result.ok(doctor);
    } catch (e) {
      return Result.error(Exception('Failed to load doctor'));
    }
  }
}
