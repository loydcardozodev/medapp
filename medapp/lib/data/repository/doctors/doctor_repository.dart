import 'package:flutter/material.dart';
import 'package:medapp/domain/models/doctors/doctor.dart';
import 'package:medapp/util/result.dart';

abstract class DoctorRepository extends ChangeNotifier {
  Future<Result<List<Doctor>>> getDoctors();

  Future<Result<Doctor>> getDoctorById(String id);

  Future<Result<Doctor>> getDoctorByUserId(String userId);
}
