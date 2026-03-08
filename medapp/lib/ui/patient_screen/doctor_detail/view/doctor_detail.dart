import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medapp/routing/routes.dart';
import 'package:medapp/ui/patient_screen/doctor_detail/viewmodel/doctor_detail_viewmodel.dart';
import 'package:provider/provider.dart';

class DoctorDetail extends StatefulWidget {
  final String doctorId;
  const DoctorDetail({super.key, required this.doctorId});

  @override
  State<DoctorDetail> createState() => _DoctorDetailState();
}

class _DoctorDetailState extends State<DoctorDetail> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DoctorDetailViewModel>().loadDoctor.execute(widget.doctorId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DoctorDetailViewModel>();

    if (viewModel.loadDoctor.running) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (viewModel.doctor == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(
            viewModel.errorMessage ?? 'Doctor not found',
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    final doctor = viewModel.doctor!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: const Color(0xFF048A6D),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF048A6D), Color(0xFF036B55)],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        child: Text(
                          doctor.specialty[0],
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        doctor.specialty,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats
                  Row(
                    children: [
                      _StatCard(
                        icon: Icons.star,
                        iconColor: Colors.amber,
                        value: doctor.rating.toString(),
                        label: 'Rating',
                      ),
                      const SizedBox(width: 12),
                      _StatCard(
                        icon: Icons.reviews_outlined,
                        iconColor: const Color(0xFF048A6D),
                        value: '${doctor.reviewCount}',
                        label: 'Reviews',
                      ),
                      const SizedBox(width: 12),
                      _StatCard(
                        icon: Icons.work_outline,
                        iconColor: Colors.blueAccent,
                        value: '${doctor.experienceYears}y',
                        label: 'Experience',
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // About
                  const _SectionTitle('About'),
                  const SizedBox(height: 8),
                  Text(
                    doctor.bio,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Fee
                  const _SectionTitle('Consultation Fee'),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF048A6D).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.attach_money,
                          color: Color(0xFF048A6D),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '\$${doctor.consultationFee.toStringAsFixed(0)} per visit',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF048A6D),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Available Days
                  const _SectionTitle('Available Days'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: doctor.availableDays
                        .map((day) => _DayChip(label: day))
                        .toList(),
                  ),

                  const SizedBox(height: 24),

                  // Time Slots
                  const _SectionTitle('Available Time Slots'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: doctor.availableSlots
                        .map((slot) => _SlotChip(label: slot))
                        .toList(),
                  ),

                  const SizedBox(height: 32),

                  // Book Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF048A6D),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () async {
                        final booked = await context.push<bool>(
                          Routes.appointmentBooking,
                          extra: {
                            'doctorId': doctor.id,
                            'currentUser': viewModel.currentUser!,
                          },
                        );
                        if (booked == true && context.mounted)
                          context.pop(true);
                      },
                      child: const Text(
                        'Book Appointment',
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
          ),
        ],
      ),
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

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  final String label;
  const _DayChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF048A6D).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF048A6D).withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          color: Color(0xFF048A6D),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _SlotChip extends StatelessWidget {
  final String label;
  const _SlotChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.access_time, size: 13, color: Colors.grey),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
