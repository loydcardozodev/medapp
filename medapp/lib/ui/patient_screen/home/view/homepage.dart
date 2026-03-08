import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medapp/routing/routes.dart';
import 'package:medapp/ui/patient_screen/home/view/widget/bannerWidget.dart';
import 'package:medapp/ui/patient_screen/home/view/widget/doc_list.dart';
import 'package:medapp/ui/patient_screen/home/view/widget/upcoming_list.dart';
import 'package:medapp/ui/patient_screen/home/viewmodel/home_viewmodel.dart';
import 'package:medapp/ui/patient_screen/medical_record_screen/view/widget/medical_record_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadHome.execute();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: viewModel.loadHome.running
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const Text(
                      'Schedule your next medical appointment',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: _searchController,
                      onChanged: (query) =>
                          viewModel.searchDoctors.execute(query),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search by specialty',
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    const BannerWidget(),

                    const SizedBox(height: 10),

                    /// TODAY'S APPOINTMENTS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Today's Appointments",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              context.push(Routes.appointmentscreen),
                          child: const Text(
                            'See more',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),

                    if (viewModel.upcomingAppointments.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'No upcoming appointments',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    else
                      UpcomingList(
                        appointments: viewModel.upcomingAppointments,
                      ),

                    const SizedBox(height: 10),

                    /// MEDICAL RECORDS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Medical Records',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.push(Routes.medicalRecord),
                          child: const Text(
                            'See more',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),

                    if (viewModel.records.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'No medical records',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: viewModel.records.length,
                        itemBuilder: (context, index) {
                          final record = viewModel.records[index];
                          return MedicalRecordCard(record: record);
                        },
                      ),

                    const SizedBox(height: 10),

                    /// DOCTORS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Doctors',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.push(Routes.doctorList),
                          child: const Text(
                            'See more',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),

                    if (viewModel.filteredDoctors.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'No doctors found',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: viewModel.filteredDoctors.length,
                        itemBuilder: (context, index) {
                          final doctor = viewModel.filteredDoctors[index];
                          return DocList(doctor: doctor);
                        },
                      ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}
