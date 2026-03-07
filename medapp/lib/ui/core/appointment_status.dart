import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum AppointmentStatus {
  pending('pending'),
  confirmed('confirmed'),
  cancelled('cancelled'),
  completed('completed');

  const AppointmentStatus(this.value);
  final String value;
}
