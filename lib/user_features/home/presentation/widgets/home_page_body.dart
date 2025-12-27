import 'package:derma_ai/user_features/home/presentation/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../location/presentation/bloc/location_cubit.dart';
import '../../../location/presentation/widgets/location_required_dialog.dart';

import 'browse_cosmetic_doctors_section.dart';
import 'home_features_section.dart';
import 'home_top_doctors_section.dart';
import 'home_recent_diagnoses_section.dart';

class HomePageBody extends StatefulWidget {
  final ScrollController scrollController;

  const HomePageBody({super.key, required this.scrollController});

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
        // Floating AppBar that hides on scroll
        _buildSliverAppBar(context),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Browse Cosmetic Doctors - Featured Section
                const BrowseCosmeticDoctorsSection(),
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

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      expandedHeight: 100,
      collapsedHeight: 100,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: buildAppBarContent(context),
          ),
        ),
      ),
    );
  }


}
