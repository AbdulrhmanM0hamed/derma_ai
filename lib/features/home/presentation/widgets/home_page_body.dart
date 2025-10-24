import 'package:flutter/material.dart';

import 'ai_feature_card.dart';
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
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AiFeatureCard(),
                // NotificationSummaryCard(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const NotificationsPage(),
                //       ),
                //     );
                //   },
                // ),
                const SizedBox(height: 24),
                const HomeFeaturesSection(),
                const SizedBox(height: 32),
                const HomeTopDoctorsSection(),
                const SizedBox(height: 32),
                const HomeRecentDiagnosesSection(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
