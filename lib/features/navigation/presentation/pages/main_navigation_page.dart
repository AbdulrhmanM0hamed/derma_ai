import 'package:circle_bottom_navigation/circle_bottom_navigation.dart';
import 'package:circle_bottom_navigation/widgets/tab_data.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/features/appointments/presentation/pages/appointments_page.dart';
import 'package:derma_ai/features/doctor_search_and_browse/doctor_search_and_browse.dart';
import 'package:derma_ai/features/home/presentation/pages/home_page.dart';
import 'package:derma_ai/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int currentPage = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const DoctorSearchAndBrowse(),
    const AppointmentsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // Use AnnotatedRegion to control the system UI overlay style
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // Set the system navigation bar color to white to match the bottom nav bar
        systemNavigationBarColor: Colors.white,
        // Set the system navigation bar icons to dark for visibility
        systemNavigationBarIconBrightness: Brightness.dark,
        // Keep the status bar transparent for an edge-to-edge feel
        statusBarColor: Colors.transparent,
        // Set the status bar icons to dark for visibility on light backgrounds
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: IndexedStack(
          index: currentPage,
          children: _pages,
        ),
        bottomNavigationBar: SafeArea(
          // Use SafeArea to avoid overlap with system navigation buttons
          child: CircleBottomNavigation(
            initialSelection: currentPage,
            circleColor: AppColors.primary,
            activeIconColor: Colors.white,
            inactiveIconColor: Colors.grey[600],
            textColor: AppColors.textPrimary,
            barBackgroundColor: Colors.white,
            circleSize: 60.0,
            barHeight: 60.0,
            arcHeight: 70.0,
            arcWidth: 90.0,
            circleOutline: 10.0,
            shadowAllowance: 20.0,
            hasElevationShadows: true,
            blurShadowRadius: 8.0,
            tabs: [
              TabData(
                icon: Icons.home,
                title: 'الرئيسية',
                iconSize: 24,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              TabData(
                icon: Icons.local_hospital,
                title: 'الأطباء',
                iconSize: 24,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              TabData(
                icon: Icons.calendar_today,
                title: 'المواعيد',
                iconSize: 24,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              TabData(
                icon: Icons.person,
                title: 'الحساب',
                iconSize: 24,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ],
            onTabChangedListener: (index) {
              setState(() => currentPage = index);
              HapticFeedback.lightImpact();
            },
          ),
        ),
      ),
    );
  }
}