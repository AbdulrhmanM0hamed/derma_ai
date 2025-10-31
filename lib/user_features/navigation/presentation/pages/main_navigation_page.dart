import 'package:circle_bottom_navigation/circle_bottom_navigation.dart';
import 'package:circle_bottom_navigation/widgets/tab_data.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/user_features/appointments/presentation/pages/appointments_page.dart';
import 'package:derma_ai/user_features/doctor_search_and_browse/doctor_search_and_browse.dart';
import 'package:derma_ai/user_features/home/presentation/pages/home_page.dart';
import 'package:derma_ai/user_features/profile/presentation/pages/profile_page.dart';
import 'package:derma_ai/l10n/app_localizations.dart';
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
   // const CommunityPage(),
    const AppointmentsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: theme.scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        body: IndexedStack(
          index: currentPage,
          children: _pages,
        ),
        bottomNavigationBar: Material(
          elevation: 8.0,
          shadowColor: Colors.black.withValues(alpha:0.1),
          child: SafeArea(
            child: CircleBottomNavigation(
              initialSelection: currentPage,
              circleColor: AppColors.primary,
              activeIconColor: Colors.white,
              inactiveIconColor: theme.unselectedWidgetColor,
              textColor: theme.colorScheme.onSurface,
              barBackgroundColor: theme.scaffoldBackgroundColor,
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
                  title: AppLocalizations.of(context)!.home,
                  iconSize: 24,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                TabData(
                  icon: Icons.local_hospital,
                  title: AppLocalizations.of(context)!.doctors,
                  iconSize: 24,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                // TabData(
                //   icon: Icons.groups_rounded,
                //   title: AppLocalizations.of(context)!.community,
                //   iconSize: 28,
                //   fontSize: 12,
                //   fontWeight: FontWeight.w600,
                // ),
                TabData(
                  icon: Icons.calendar_today,
                  title: AppLocalizations.of(context)!.appointments,
                  iconSize: 24,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                TabData(
                  icon: Icons.person,
                  title: AppLocalizations.of(context)!.profile,
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
      ),
    );
  }
}