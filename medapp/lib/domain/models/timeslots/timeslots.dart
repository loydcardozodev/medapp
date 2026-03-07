import 'package:freezed_annotation/freezed_annotation.dart';

part 'timeslots.freezed.dart';
part 'timeslots.g.dart';

@freezed
abstract class TimeSlot with _$TimeSlot {
  const factory TimeSlot({
    required String id,
    required String doctorId,
    required DateTime date,
    required String time,
    required bool isBooked,
  }) = _TimeSlot;

  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);
}
