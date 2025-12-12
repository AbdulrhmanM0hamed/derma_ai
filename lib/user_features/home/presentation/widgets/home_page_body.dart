import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../location/presentation/bloc/location_cubit.dart';
import '../../../location/presentation/widgets/location_required_dialog.dart';

import 'ai_feature_card.dart';
import 'home_features_section.dart';
import 'home_top_doctors_section.dart';
import 'home_recent_diagnoses_section.dart';


class HomePageBody extends StatefulWidget {
  final ScrollController scrollController;

  const HomePageBody({
    super.key,
    required this.scrollController,
  });

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  bool _hasCheckedLocation = false;

  @override
  void initState() {
    super.initState();
    // Check location after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowLocationDialog();
    });
  }

  void _checkAndShowLocationDialog() {
    if (_hasCheckedLocation) return;
    _hasCheckedLocation = true;

    final locationCubit = context.read<LocationCubit>();
    
    // If no location is saved, show the location required dialog
    if (!locationCubit.hasLocationSaved) {
      LocationRequiredDialog.show(
        context,
        onLocationSelected: () {
          // Refresh the UI after location is selected
          setState(() {});
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: widget.scrollController,
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
