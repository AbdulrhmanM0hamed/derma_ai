import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/doctor_consultation_info_app_bar.dart';
import '../widgets/doctor_consultation_info_body.dart';

class DoctorConsultationInfoPage extends StatelessWidget {
  const DoctorConsultationInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const DoctorConsultationInfoAppBar(),
          SliverToBoxAdapter(
            child: const DoctorConsultationInfoBody()
                .animate()
                .fadeIn(duration: 600.ms)
                .slideY(begin: 0.1),
          ),
        ],
      ),
    );
  }
}
