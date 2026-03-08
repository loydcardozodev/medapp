import 'package:flutter/material.dart';
import 'package:medapp/ui/patient_screen/medical_record_screen/view/widget/medical_record_card.dart';
import 'package:medapp/ui/patient_screen/medical_record_screen/viewmodel/medical_record_viewmodel.dart';
import 'package:provider/provider.dart';

class MedicalRecordView extends StatefulWidget {
  const MedicalRecordView({super.key});

  @override
  State<MedicalRecordView> createState() => _MedicalRecordViewState();
}

class _MedicalRecordViewState extends State<MedicalRecordView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MedicalRecordViewModel>().loadRecords.execute();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MedicalRecordViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Medical Records")),

      body: Builder(
        builder: (_) {
          /// Loading
          if (viewModel.loadRecords.running) {
            return const Center(child: CircularProgressIndicator());
          }

          /// Error
          if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          }

          /// Empty
          if (viewModel.records.isEmpty) {
            return const Center(child: Text("No medical records found"));
          }

          /// Records List
          return RefreshIndicator(
            onRefresh: () => viewModel.loadRecords.execute(),
            child: ListView.builder(
              itemCount: viewModel.records.length,
              itemBuilder: (context, index) {
                final record = viewModel.records[index];

                return MedicalRecordCard(record: record);
              },
            ),
          );
        },
      ),
    );
  }
}
