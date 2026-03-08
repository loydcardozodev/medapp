import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medapp/domain/models/medical_record/medical_record.dart';

class MedicalRecordDetail extends StatelessWidget {
  final MedicalRecord record;
  const MedicalRecordDetail({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medical Record',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoCard(
              title: 'Diagnosis',
              child: Text(
                record.diagnosis,
                style: const TextStyle(fontSize: 15, height: 1.5),
              ),
            ),
            const SizedBox(height: 16),
            _InfoCard(
              title: 'Prescriptions',
              child: record.prescriptions.isEmpty
                  ? const Text(
                      'No prescriptions',
                      style: TextStyle(color: Colors.grey),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: record.prescriptions
                          .map(
                            (p) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.medication_outlined,
                                    size: 16,
                                    color: Color(0xFF048A6D),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(p, style: const TextStyle(fontSize: 14)),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ),
            const SizedBox(height: 16),
            _InfoCard(
              title: "Doctor's Notes",
              child: Text(
                record.doctorNotes.isEmpty ? 'No notes' : record.doctorNotes,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _InfoCard(
              title: 'Details',
              child: Column(
                children: [
                  _DetailRow(
                    icon: Icons.calendar_month,
                    label: 'Date',
                    value: DateFormat(
                      'EEEE, MMMM d yyyy',
                    ).format(record.createdAt),
                  ),
                  const SizedBox(height: 10),
                  _DetailRow(
                    icon: Icons.receipt_long,
                    label: 'Appointment ID',
                    value: record.appointmentId,
                  ),
                  const SizedBox(height: 10),
                  _DetailRow(
                    icon: Icons.person_outline,
                    label: 'Doctor ID',
                    value: record.doctorId,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _InfoCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF048A6D)),
        const SizedBox(width: 10),
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 13, color: Colors.grey),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
