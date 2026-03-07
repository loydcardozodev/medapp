import 'package:medapp/domain/models/app_notification/app_notification.dart';
import 'package:medapp/domain/models/app_user/app_user.dart';
import 'package:medapp/domain/models/appointment/appointment.dart';
import 'package:medapp/domain/models/doctors/doctor.dart';
import 'package:medapp/domain/models/medical_record/medical_record.dart';
import 'package:medapp/domain/models/timeslots/timeslots.dart';

import 'package:medapp/ui/core/appointment_status.dart';
import 'package:medapp/ui/core/user_roles.dart';

class LocalDataService {
  LocalDataService._();

  /// =========================
  /// USERS
  /// =========================

  static final List<AppUser> users = [
    const AppUser(
      id: 'u1',
      name: 'Admin',
      email: 'admin@medapp.com',
      password: 'admin123',
      role: UserRole.admin,
    ),
    const AppUser(
      id: 'u2',
      name: 'Dr. Sarah Johnson',
      email: 'sarah@medapp.com',
      password: 'doctor123',
      role: UserRole.doctor,
    ),
    const AppUser(
      id: 'u3',
      name: 'Dr. James Lee',
      email: 'james@medapp.com',
      password: 'doctor123',
      role: UserRole.doctor,
    ),
    const AppUser(
      id: 'u4',
      name: 'Dr. Maria Cruz',
      email: 'maria@medapp.com',
      password: 'doctor123',
      role: UserRole.doctor,
    ),
    const AppUser(
      id: 'u5',
      name: 'John Doe',
      email: 'john@medapp.com',
      password: 'customer123',
      role: UserRole.customer,
    ),
    const AppUser(
      id: 'u6',
      name: 'Jane Smith',
      email: 'jane@medapp.com',
      password: 'customer123',
      role: UserRole.customer,
    ),
  ];

  /// =========================
  /// DOCTORS
  /// =========================

  static final List<Doctor> doctors = [
    const Doctor(
      id: 'd1',
      userId: 'u2',
      specialty: 'Cardiologist',
      bio: 'Board-certified cardiologist with 10+ years of experience.',
      rating: 4.8,
      reviewCount: 124,
      experienceYears: 10,
      availableDays: ['Monday', 'Wednesday', 'Friday'],
      availableSlots: ['09:00', '10:00', '11:00', '14:00', '15:00'],
      consultationFee: 150.0,
    ),
    const Doctor(
      id: 'd2',
      userId: 'u3',
      specialty: 'Dermatologist',
      bio: 'Specialist in skin, hair, and nail disorders.',
      rating: 4.5,
      reviewCount: 89,
      experienceYears: 7,
      availableDays: ['Tuesday', 'Thursday', 'Saturday'],
      availableSlots: ['10:00', '11:00', '13:00', '14:00', '16:00'],
      consultationFee: 120.0,
    ),
    const Doctor(
      id: 'd3',
      userId: 'u4',
      specialty: 'Pediatrician',
      bio: 'Dedicated to comprehensive care for children.',
      rating: 4.9,
      reviewCount: 210,
      experienceYears: 12,
      availableDays: ['Monday', 'Tuesday', 'Thursday', 'Friday'],
      availableSlots: ['08:00', '09:00', '10:00', '11:00', '15:00', '16:00'],
      consultationFee: 100.0,
    ),
  ];

  /// =========================
  /// APPOINTMENTS
  /// =========================

  static final List<Appointment> appointments = [
    Appointment(
      id: 'a1',
      customerId: 'u5',
      doctorId: 'd1',
      date: DateTime(2026, 3, 10),
      timeSlot: '09:00',
      status: AppointmentStatus.confirmed,
      notes: 'Follow-up for chest pain',
      createdAt: DateTime(2026, 3, 1),
    ),
    Appointment(
      id: 'a2',
      customerId: 'u5',
      doctorId: 'd2',
      date: DateTime(2026, 3, 15),
      timeSlot: '11:00',
      status: AppointmentStatus.pending,
      notes: 'Skin rash on arm',
      createdAt: DateTime(2026, 3, 5),
    ),
    Appointment(
      id: 'a3',
      customerId: 'u6',
      doctorId: 'd3',
      date: DateTime(2026, 3, 8),
      timeSlot: '10:00',
      status: AppointmentStatus.completed,
      notes: 'Annual checkup',
      createdAt: DateTime(2026, 2, 28),
    ),
    Appointment(
      id: 'a4',
      customerId: 'u6',
      doctorId: 'd1',
      date: DateTime(2026, 3, 5),
      timeSlot: '14:00',
      status: AppointmentStatus.cancelled,
      cancelReason: 'Patient rescheduled',
      createdAt: DateTime(2026, 2, 25),
    ),
  ];

  /// =========================
  /// MEDICAL RECORDS
  /// =========================

  static final List<MedicalRecord> medicalRecords = [
    MedicalRecord(
      id: 'mr1',
      appointmentId: 'a3',
      customerId: 'u6',
      doctorId: 'd3',
      diagnosis: 'Healthy child, no abnormalities detected.',
      prescriptions: ['Vitamin D supplement', 'Multivitamin'],
      doctorNotes: 'Next checkup in 6 months.',
      createdAt: DateTime(2026, 3, 8),
    ),
  ];

  /// =========================
  /// AVAILABILITY (TimeSlots)
  /// =========================

  static final List<TimeSlot> timeSlots = [
    TimeSlot(
      id: 'ts1',
      doctorId: 'd1',
      date: DateTime(2026, 3, 10),
      time: '09:00',
      isBooked: true,
    ),
    TimeSlot(
      id: 'ts2',
      doctorId: 'd1',
      date: DateTime(2026, 3, 10),
      time: '10:00',
      isBooked: false,
    ),
    TimeSlot(
      id: 'ts3',
      doctorId: 'd2',
      date: DateTime(2026, 3, 15),
      time: '11:00',
      isBooked: true,
    ),
    TimeSlot(
      id: 'ts4',
      doctorId: 'd3',
      date: DateTime(2026, 3, 8),
      time: '10:00',
      isBooked: true,
    ),
  ];

  /// =========================
  /// NOTIFICATIONS
  /// =========================

  static final List<AppNotification> notifications = [
    AppNotification(
      id: 'n1',
      userId: 'u5',
      title: 'Appointment Confirmed',
      message: 'Your appointment with Dr. Sarah Johnson is confirmed.',
      isRead: false,
      createdAt: DateTime(2026, 3, 1),
    ),
    AppNotification(
      id: 'n2',
      userId: 'u5',
      title: 'Appointment Reminder',
      message: 'Reminder: Appointment tomorrow at 09:00 AM.',
      isRead: false,
      createdAt: DateTime(2026, 3, 9),
    ),
    AppNotification(
      id: 'n3',
      userId: 'u6',
      title: 'Appointment Completed',
      message: 'Your appointment has been completed.',
      isRead: true,
      createdAt: DateTime(2026, 3, 8),
    ),
  ];

  /// =========================
  /// AUTH HELPERS
  /// =========================

  static AppUser? findUser(String email, String password) {
    try {
      return users.firstWhere(
        (u) => u.email == email && u.password == password && u.isActive,
      );
    } catch (_) {
      return null;
    }
  }

  /// =========================
  /// DOCTOR HELPERS
  /// =========================

  static Doctor? getDoctorByUserId(String userId) {
    try {
      return doctors.firstWhere((d) => d.userId == userId);
    } catch (_) {
      return null;
    }
  }

  static AppUser? getUserByDoctorId(String doctorId) {
    try {
      final doctor = doctors.firstWhere((d) => d.id == doctorId);
      return users.firstWhere((u) => u.id == doctor.userId);
    } catch (_) {
      return null;
    }
  }

  /// =========================
  /// APPOINTMENT HELPERS
  /// =========================

  static List<Appointment> getAppointmentsForCustomer(String customerId) =>
      appointments.where((a) => a.customerId == customerId).toList();

  static List<Appointment> getAppointmentsForDoctor(String doctorId) =>
      appointments.where((a) => a.doctorId == doctorId).toList();

  /// =========================
  /// MEDICAL RECORD HELPERS
  /// =========================

  static List<MedicalRecord> getMedicalRecordsForCustomer(String customerId) =>
      medicalRecords.where((r) => r.customerId == customerId).toList();

  /// =========================
  /// AVAILABILITY HELPERS
  /// =========================

  static List<TimeSlot> getDoctorAvailability(String doctorId) =>
      timeSlots.where((slot) => slot.doctorId == doctorId).toList();

  static void addAvailability(TimeSlot slot) {
    timeSlots.add(slot);
  }

  static void removeAvailability(String slotId) {
    timeSlots.removeWhere((slot) => slot.id == slotId);
  }

  /// =========================
  /// NOTIFICATION HELPERS
  /// =========================

  static List<AppNotification> getNotifications(String userId) =>
      notifications.where((n) => n.userId == userId).toList();

  static void markNotificationAsRead(String notificationId) {
    final index = notifications.indexWhere((n) => n.id == notificationId);

    if (index != -1) {
      notifications[index] = notifications[index].copyWith(isRead: true);
    }
  }
}
