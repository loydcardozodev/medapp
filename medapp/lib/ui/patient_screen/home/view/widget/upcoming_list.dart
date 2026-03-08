import 'package:flutter/material.dart';
import 'package:medapp/domain/models/appointment/appointment.dart';
import 'package:medapp/ui/core/appointment_status.dart';
import 'package:intl/intl.dart';
import 'package:medapp/ui/patient_screen/home/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';

class UpcomingList extends StatelessWidget {
  final List<Appointment> appointments;

  const UpcomingList({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return _AppointmentCard(appointment: appointment);
      },
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const _AppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd/MM/yy').format(appointment.date);
    final viewModel = context.watch<HomeViewModel>();
    final doctor = viewModel.doctors.firstWhere(
      (d) => d.id == appointment.doctorId,
      orElse: () => viewModel.doctors.first,
    );

    return SizedBox(
      height: 160,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: Colors.black45,
                              size: 15,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              formattedDate,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black45,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.lock_clock,
                              color: Colors.black45,
                              size: 15,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              appointment.timeSlot,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        _StatusChip(status: appointment.status),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[200],
                    child: Text(
                      doctor.specialty[0],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {},
                      child: const Text('Reschedule'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final AppointmentStatus status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      AppointmentStatus.confirmed => (Colors.green, 'Confirmed'),
      AppointmentStatus.pending => (Colors.orange, 'Pending'),
      AppointmentStatus.completed => (Colors.blue, 'Completed'),
      AppointmentStatus.cancelled => (Colors.red, 'Cancelled'),
      _ => (Colors.grey, 'Unknown'),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(label, style: TextStyle(fontSize: 12, color: color)),
    );
  }
}
