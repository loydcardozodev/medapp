import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum UserRole {
  admin('admin'),
  doctor('doctor'),
  customer('customer');

  const UserRole(this.value);
  final String value;
}
