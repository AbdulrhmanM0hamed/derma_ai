import 'package:flutter/material.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

class DoctorAppointmentsPage extends StatefulWidget {
  const DoctorAppointmentsPage({super.key});

  @override
  State<DoctorAppointmentsPage> createState() => _DoctorAppointmentsPageState();
}

class _DoctorAppointmentsPageState extends State<DoctorAppointmentsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.appointments ?? "Appointments",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: [
            Tab(text: AppLocalizations.of(context)?.upcoming ?? "Upcoming"),
            Tab(text: AppLocalizations.of(context)?.completed ?? "Completed"),
            Tab(text: AppLocalizations.of(context)?.canceled ?? "Canceled"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Placeholder for the Upcoming Appointments tab
          Center(
            child: Text(
              AppLocalizations.of(context)?.upcomingAppointments ?? "Upcoming Appointments",
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          // Placeholder for the Completed Appointments tab
          Center(
            child: Text(
              AppLocalizations.of(context)?.completedAppointments ?? "Completed Appointments",
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          // Placeholder for the Canceled Appointments tab
          Center(
            child: Text(
              AppLocalizations.of(context)?.canceledAppointments ?? "Canceled Appointments",
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
