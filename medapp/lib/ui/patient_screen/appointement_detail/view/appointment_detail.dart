import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medapp/domain/models/appointment/appointment.dart';
import 'package:medapp/ui/core/appointment_status.dart';
import 'package:medapp/ui/patient_screen/appointement_detail/viewmodel/appointment_details_viewmodel.dart';
import 'package:provider/provider.dart';

class AppointmentDetail extends StatefulWidget {
  final Appointment appointment;
  const AppointmentDetail({super.key, required this.appointment});

  @override
  State<AppointmentDetail> createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppointmentDetailViewModel>().loadDetail.execute(
        widget.appointment,
      );
    });
  }

  Future<void> _onCancel() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Appointment'),
        content: const Text(
          'Are you sure you want to cancel this appointment?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Yes, Cancel',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirm != true || !mounted) return;
    await context
        .read<AppointmentDetailViewModel>()
        .cancelAppointment
        .execute();

    if (!mounted) return;
    if (context.read<AppointmentDetailViewModel>().cancelSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Appointment cancelled'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AppointmentDetailViewModel>();

    if (viewModel.loadDetail.running) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final appt = viewModel.appointment ?? widget.appointment;
    final doctor = viewModel.doctor;
    final isCancellable =
        appt.status == AppointmentStatus.confirmed ||
        appt.status == AppointmentStatus.pending;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Appointment Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _StatusBanner(status: appt.status),
            const SizedBox(height: 20),

            _InfoCard(
              title: 'Doctor',
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: const Color(0xFF048A6D).withOpacity(0.12),
                    child: Text(
                      doctor?.specialty[0] ?? '?',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF048A6D),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor?.specialty ?? 'Loading...',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (doctor != null) ...[
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 13,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${doctor.rating}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            _InfoCard(
              title: 'Schedule',
              child: Column(
                children: [
                  _DetailRow(
                    icon: Icons.calendar_month,
                    label: 'Date',
                    value: DateFormat('EEEE, MMMM d yyyy').format(appt.date),
                  ),
                  const SizedBox(height: 10),
                  _DetailRow(
                    icon: Icons.access_time,
                    label: 'Time',
                    value: appt.timeSlot,
                  ),
                  const SizedBox(height: 10),
                  _DetailRow(
                    icon: Icons.receipt_long,
                    label: 'Booked on',
                    value: DateFormat('MMM d, yyyy').format(appt.createdAt),
                  ),
                ],
              ),
            ),

            if (appt.notes != null && appt.notes!.isNotEmpty) ...[
              const SizedBox(height: 16),
              _InfoCard(
                title: 'Notes',
                child: Text(
                  appt.notes!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ),
            ],

            if (appt.cancelReason != null && appt.cancelReason!.isNotEmpty) ...[
              const SizedBox(height: 16),
              _InfoCard(
                title: 'Cancel Reason',
                child: Text(
                  appt.cancelReason!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                    height: 1.5,
                  ),
                ),
              ),
            ],

            const SizedBox(height: 32),

            if (isCancellable)
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: viewModel.cancelAppointment.running
                      ? null
                      : _onCancel,
                  child: viewModel.cancelAppointment.running
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.red,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Cancel Appointment',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _StatusBanner extends StatelessWidget {
  final AppointmentStatus status;
  const _StatusBanner({required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, label, icon) = switch (status) {
      AppointmentStatus.confirmed => (
        Colors.green,
        'Confirmed',
        Icons.check_circle_outline,
      ),
      AppointmentStatus.pending => (
        Colors.orange,
        'Pending Confirmation',
        Icons.hourglass_empty,
      ),
      AppointmentStatus.completed => (Colors.blue, 'Completed', Icons.task_alt),
      AppointmentStatus.cancelled => (
        Colors.red,
        'Cancelled',
        Icons.cancel_outlined,
      ),
      _ => (Colors.grey, 'Unknown', Icons.info_outline),
    };
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
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
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
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
