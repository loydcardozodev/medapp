import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medapp/domain/models/app_user/app_user.dart';
import 'package:medapp/ui/patient_screen/appointment_booking/viewmodel/appointment_booking_viewmodel.dart';
import 'package:provider/provider.dart';

class AppointmentBooking extends StatefulWidget {
  final String doctorId;
  final AppUser currentUser;

  const AppointmentBooking({
    super.key,
    required this.doctorId,
    required this.currentUser,
  });

  @override
  State<AppointmentBooking> createState() => _AppointmentBookingState();
}

class _AppointmentBookingState extends State<AppointmentBooking> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppointmentBookingViewmodel>()
        ..reset()
        ..loadDoctor.execute(widget.doctorId);
    });
  }

  Future<void> _onBook(AppointmentBookingViewmodel viewModel) async {
    await viewModel.bookAppointment.execute(widget.currentUser.id);
    if (!mounted) return;
    if (viewModel.bookingSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Appointment booked successfully!'),
          backgroundColor: Color(0xFF048A6D),
        ),
      );
      context.pop(true);
    } else if (viewModel.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(viewModel.errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AppointmentBookingViewmodel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Appointment',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: viewModel.loadDoctor.running
          ? const Center(child: CircularProgressIndicator())
          : viewModel.doctor == null
          ? Center(
              child: Text(
                viewModel.errorMessage ?? 'Doctor not found',
                style: const TextStyle(color: Colors.grey),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DoctorSummaryCard(
                    specialty: viewModel.doctor!.specialty,
                    fee: viewModel.doctor!.consultationFee,
                    rating: viewModel.doctor!.rating,
                  ),
                  const SizedBox(height: 24),
                  const _SectionTitle('Select Date'),
                  const SizedBox(height: 12),
                  _DateSelector(
                    availableDays: viewModel.doctor!.availableDays,
                    selectedDate: viewModel.selectedDate,
                    onDateSelected: viewModel.selectDate,
                  ),
                  const SizedBox(height: 24),
                  const _SectionTitle('Select Time Slot'),
                  const SizedBox(height: 12),
                  if (viewModel.selectedDate == null)
                    const Text(
                      'Please select a date first',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    )
                  else
                    _SlotSelector(
                      slots: viewModel.doctor!.availableSlots,
                      selectedSlot: viewModel.selectedSlot,
                      onSlotSelected: viewModel.selectSlot,
                    ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: viewModel.canBook
                            ? const Color(0xFF048A6D)
                            : Colors.grey[300],
                        foregroundColor: viewModel.canBook
                            ? Colors.white
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed:
                          viewModel.canBook &&
                              !viewModel.bookAppointment.running
                          ? () => _onBook(viewModel)
                          : null,
                      child: viewModel.bookAppointment.running
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Confirm Booking',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
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

class _DoctorSummaryCard extends StatelessWidget {
  final String specialty;
  final double fee;
  final double rating;
  const _DoctorSummaryCard({
    required this.specialty,
    required this.fee,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF048A6D).withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF048A6D).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFF048A6D).withOpacity(0.15),
            child: Text(
              specialty[0],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF048A6D),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  specialty,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '$rating',
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${fee.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF048A6D),
                ),
              ),
              const Text(
                'per visit',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DateSelector extends StatelessWidget {
  final List<String> availableDays;
  final DateTime? selectedDate;
  final void Function(DateTime) onDateSelected;

  const _DateSelector({
    required this.availableDays,
    required this.selectedDate,
    required this.onDateSelected,
  });

  bool _isAvailable(DateTime date) =>
      availableDays.contains(DateFormat('EEEE').format(date));

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dates = List.generate(
      14,
      (i) => DateTime(now.year, now.month, now.day + i + 1),
    );

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final date = dates[index];
          final available = _isAvailable(date);
          final selected =
              selectedDate != null &&
              DateFormat('yyyy-MM-dd').format(date) ==
                  DateFormat('yyyy-MM-dd').format(selectedDate!);

          return GestureDetector(
            onTap: available ? () => onDateSelected(date) : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 58,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF048A6D)
                    : available
                    ? Colors.white
                    : Colors.grey[100],
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: selected
                      ? const Color(0xFF048A6D)
                      : available
                      ? Colors.grey.shade300
                      : Colors.transparent,
                ),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF048A6D).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEE').format(date),
                    style: TextStyle(
                      fontSize: 11,
                      color: selected
                          ? Colors.white
                          : available
                          ? Colors.grey
                          : Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('d').format(date),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: selected
                          ? Colors.white
                          : available
                          ? Colors.black87
                          : Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    DateFormat('MMM').format(date),
                    style: TextStyle(
                      fontSize: 10,
                      color: selected
                          ? Colors.white70
                          : available
                          ? Colors.grey
                          : Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SlotSelector extends StatelessWidget {
  final List<String> slots;
  final String? selectedSlot;
  final void Function(String) onSlotSelected;

  const _SlotSelector({
    required this.slots,
    required this.selectedSlot,
    required this.onSlotSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: slots.map((slot) {
        final selected = slot == selectedSlot;
        return GestureDetector(
          onTap: () => onSlotSelected(slot),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: selected ? const Color(0xFF048A6D) : Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected
                    ? const Color(0xFF048A6D)
                    : Colors.grey.shade300,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: selected ? Colors.white : Colors.grey,
                ),
                const SizedBox(width: 6),
                Text(
                  slot,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: selected ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}
