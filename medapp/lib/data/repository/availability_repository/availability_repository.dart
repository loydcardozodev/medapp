import 'package:medapp/domain/models/timeslots/timeslots.dart';
import 'package:medapp/util/result.dart';

abstract class AvailabilityRepository {
  Future<Result<List<TimeSlot>>> getDoctorAvailability(String doctorId);

  Future<Result<void>> addAvailability(TimeSlot slot);

  Future<Result<void>> removeAvailability(String slotId);
}
