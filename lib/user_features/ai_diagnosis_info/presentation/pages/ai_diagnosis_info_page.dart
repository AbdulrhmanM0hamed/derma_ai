import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/ai_diagnosis_info_app_bar.dart';
import '../widgets/ai_diagnosis_info_body.dart';

class AiDiagnosisInfoPage extends StatelessWidget {
  const AiDiagnosisInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const AiDiagnosisInfoAppBar(),
          SliverToBoxAdapter(
            child: const AiDiagnosisInfoBody()
                .animate()
                .fadeIn(duration: 600.ms)
                .slideY(begin: 0.1),
          ),
        ],
      ),
    );
  }
}
