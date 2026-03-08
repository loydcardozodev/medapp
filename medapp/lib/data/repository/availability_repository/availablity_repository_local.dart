import 'package:medapp/data/repository/availability_repository/availability_repository.dart';
import 'package:medapp/data/services/local/local_data_service.dart';
import 'package:medapp/domain/models/timeslots/timeslots.dart';
import 'package:medapp/util/result.dart';

class AvailabilityRepositoryLocal implements AvailabilityRepository {
  @override
  Future<Result<List<TimeSlot>>> getDoctorAvailability(String doctorId) async {
    try {
      final slots = LocalDataService.getDoctorAvailability(doctorId);
      return Result.ok(slots);
    } catch (e) {
      return Result.error(Exception('Failed to fetch availability: $e'));
    }
  }

  @override
  Future<Result<void>> addAvailability(TimeSlot slot) async {
    try {
      LocalDataService.addAvailability(slot);
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Failed to add availability: $e'));
    }
  }

  @override
  Future<Result<void>> removeAvailability(String slotId) async {
    try {
      LocalDataService.removeAvailability(slotId);
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Failed to remove availability: $e'));
    }
  }
}
