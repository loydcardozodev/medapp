import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medapp/domain/models/appointment/appointment.dart';
import 'package:medapp/domain/models/app_user/app_user.dart';
import 'package:medapp/routing/routes.dart';
import 'package:medapp/ui/core/appointment_status.dart';
import 'package:medapp/ui/patient_screen/appointmentscreen/viewmodel/appointment_viewmodel.dart';
import 'package:provider/provider.dart';

class AppointmentScreen extends StatefulWidget {
  final AppUser? currentUser;
  const AppointmentScreen({super.key, required this.currentUser});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.currentUser != null) {
        context.read<AppointmentViewModel>().loadAppointments.execute(
          widget.currentUser!.id,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AppointmentViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Appointments',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF048A6D),
          labelColor: const Color(0xFF048A6D),
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Past'),
          ],
        ),
      ),
      body: viewModel.loadAppointments.running
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _AppointmentList(
                  appointments: viewModel.upcoming,
                  emptyMessage: 'No upcoming appointments',
                  onTap: (appt) =>
                      context.push(Routes.appointmentDetail, extra: appt),
                  onCancel: (appt) => context
                      .read<AppointmentViewModel>()
                      .cancelAppointment
                      .execute(appt.id),
                  showActions: true,
                ),
                _AppointmentList(
                  appointments: viewModel.past,
                  emptyMessage: 'No past appointments',
                  onTap: (appt) =>
                      context.push(Routes.appointmentDetail, extra: appt),
                  showActions: false,
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF048A6D),
        foregroundColor: Colors.white,
        onPressed: () async {
          final booked = await context.push<bool>(Routes.doctorList);
          if (booked == true && widget.currentUser != null && context.mounted) {
            context.read<AppointmentViewModel>().loadAppointments.execute(
              widget.currentUser!.id,
            );
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Book'),
      ),
    );
  }
}

class _AppointmentList extends StatelessWidget {
  final List<Appointment> appointments;
  final String emptyMessage;
  final void Function(Appointment) onTap;
  final void Function(Appointment)? onCancel;
  final bool showActions;

  const _AppointmentList({
    required this.appointments,
    required this.emptyMessage,
    required this.onTap,
    this.onCancel,
    required this.showActions,
  });

  @override
  Widget build(BuildContext context) {
    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              size: 56,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: const TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: appointments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final appt = appointments[index];
        return _AppointmentCard(
          appointment: appt,
          onTap: () => onTap(appt),
          onCancel: showActions && appt.status != AppointmentStatus.cancelled
              ? () => onCancel?.call(appt)
              : null,
        );
      },
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onTap;
  final VoidCallback? onCancel;

  const _AppointmentCard({
    required this.appointment,
    required this.onTap,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat(
      'EEE, MMM d yyyy',
    ).format(appointment.date);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFF048A6D).withOpacity(0.12),
                  child: const Icon(
                    Icons.person,
                    color: Color(0xFF048A6D),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Doctor ID: ${appointment.doctorId}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            size: 13,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            formattedDate,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.access_time,
                            size: 13,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            appointment.timeSlot,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _StatusChip(status: appointment.status),
              ],
            ),
            if (appointment.notes != null && appointment.notes!.isNotEmpty) ...[
              const SizedBox(height: 10),
              const Divider(height: 1),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.notes, size: 14, color: Colors.grey),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      appointment.notes!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
            if (onCancel != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onCancel,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF048A6D),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Details'),
                    ),
                  ),
                ],
              ),
            ],
          ],
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
