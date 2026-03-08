import 'package:medapp/data/repository/doctors/doctor_repository.dart';
import 'package:medapp/domain/models/doctors/doctor.dart';
import 'package:medapp/util/command.dart';
import 'package:medapp/util/result.dart';
import 'package:flutter/material.dart';

class DoctorsListViewModel extends ChangeNotifier {
  final DoctorRepository _doctorRepository;

  DoctorsListViewModel({required DoctorRepository doctorRepository})
    : _doctorRepository = doctorRepository {
    loadDoctors = Command0(_loadDoctors);
    searchDoctors = Command1(_searchDoctors);
  }

  late final Command0<void> loadDoctors;
  late final Command1<void, String> searchDoctors;

  List<Doctor> _doctors = [];
  List<Doctor> filteredDoctors = [];
  String searchQuery = '';

  Future<Result<void>> _loadDoctors() async {
    try {
      final result = await _doctorRepository.getDoctors();
      if (result is Ok<List<Doctor>>) {
        _doctors = result.value;
        filteredDoctors = List.from(_doctors);
      }
      notifyListeners();
      return const Result.ok(null);
    } catch (e) {
      return Result.error(Exception('Failed to load doctors: $e'));
    }
  }

  Future<Result<void>> _searchDoctors(String query) async {
    searchQuery = query;
    filteredDoctors = query.trim().isEmpty
        ? List.from(_doctors)
        : _doctors
              .where(
                (d) => d.specialty.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    notifyListeners();
    return const Result.ok(null);
  }
}
