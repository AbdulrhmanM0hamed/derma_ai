import 'package:flutter/material.dart';

import 'home_app_bar.dart';
import 'home_welcome_section.dart';
import 'home_features_section.dart';
import 'home_top_doctors_section.dart';
import 'home_recent_diagnoses_section.dart';

class HomePageBody extends StatelessWidget {
  final ScrollController scrollController;

  const HomePageBody({
    super.key,
    required this.scrollController,
  });
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        const HomeAppBar(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                HomeWelcomeSection(),
                SizedBox(height: 32),
                HomeFeaturesSection(),
                SizedBox(height: 32),
                HomeTopDoctorsSection(),
                SizedBox(height: 32),
                HomeRecentDiagnosesSection(),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
