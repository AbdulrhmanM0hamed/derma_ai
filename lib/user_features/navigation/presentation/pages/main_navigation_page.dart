import 'package:derma_ai/user_features/ai_diagnosis/presentation/pages/ai_features_page.dart';
import 'package:derma_ai/user_features/appointments/presentation/pages/appointments_page.dart';
import 'package:derma_ai/user_features/doctor_search_and_browse/doctor_search_and_browse.dart';
import 'package:derma_ai/user_features/home/presentation/pages/home_page.dart';
import 'package:derma_ai/user_features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/custom_bottom_navigation_bar.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int currentPage = 0;

  Widget _getCurrentPage() {
    switch (currentPage) {
      case 0:
        return const HomePage();
      case 1:
        return const DoctorSearchAndBrowse();
      case 2:
        return const AiFeaturesPage();
      case 3:
        return const AppointmentsPage();
      case 4:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: theme.scaffoldBackgroundColor,
        systemNavigationBarIconBrightness:
            isLight ? Brightness.dark : Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        body: _getCurrentPage(),
        bottomNavigationBar: SafeArea(
          child: CustomBottomNavigationBar(
            currentIndex: currentPage,
            onTap: (index) {
              setState(() => currentPage = index);
              HapticFeedback.lightImpact();
            },
          ),
        ),
      ),
    );
  }
}
