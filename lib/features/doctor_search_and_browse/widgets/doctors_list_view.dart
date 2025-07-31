import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'doctor_card_widget.dart';

class DoctorsListView extends StatelessWidget {
  final List<Map<String, dynamic>> doctors;
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;
  final void Function(Map<String, dynamic>) onDoctorTap;
  final void Function(Map<String, dynamic>) onFavoriteToggle;
  final void Function(Map<String, dynamic>) onShareDoctor;
  final void Function(Map<String, dynamic>) onMessageDoctor;

  const DoctorsListView({
    super.key,
    required this.doctors,
    required this.scrollController,
    required this.onRefresh,
    required this.onDoctorTap,
    required this.onFavoriteToggle,
    required this.onShareDoctor,
    required this.onMessageDoctor,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        controller: scrollController,
        padding: EdgeInsets.only(bottom: screenHeight * 0.2),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return DoctorCardWidget(
            doctor: doctor,
            onTap: () => onDoctorTap(doctor),
            onFavorite: () => onFavoriteToggle(doctor),
            onShare: () => onShareDoctor(doctor),
            onMessage: () => onMessageDoctor(doctor),
          ).animate().fadeIn(duration: 500.ms, delay: (100 * index).ms).slideX(begin: -0.2, end: 0);
        },
      ),
    );
  }
}
