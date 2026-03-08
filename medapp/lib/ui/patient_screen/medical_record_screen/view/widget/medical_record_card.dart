import 'package:flutter/material.dart';
import 'package:medapp/domain/models/medical_record/medical_record.dart';

class MedicalRecordCard extends StatelessWidget {
  final MedicalRecord record;

  const MedicalRecordCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Diagnosis
            Text(
              record.diagnosis,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            /// Doctor Notes
            Text(record.doctorNotes, style: const TextStyle(fontSize: 14)),

            const SizedBox(height: 12),

            /// Prescriptions
            const Text(
              "Prescriptions",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: record.prescriptions.map((p) => Text("• $p")).toList(),
            ),

            const SizedBox(height: 12),

            /// Date
            Text(
              "Created: ${record.createdAt}",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
