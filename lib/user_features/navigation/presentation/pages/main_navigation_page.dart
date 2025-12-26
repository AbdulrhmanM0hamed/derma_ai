import 'package:derma_ai/user_features/ai_diagnosis/presentation/pages/ai_diagnosis_page.dart';
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

  final List<Widget> _pages = [
    const HomePage(), // Index 0
    const DoctorSearchAndBrowse(), // Index 1
    SizedBox(),
    const AppointmentsPage(), // Index 3
    const ProfilePage(), // Index 4
  ];

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
        body: IndexedStack(index: currentPage, children: _pages),
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
