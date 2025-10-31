import 'package:circle_bottom_navigation/circle_bottom_navigation.dart';
import 'package:circle_bottom_navigation/widgets/tab_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../appointments/presentation/pages/doctor_appointments_page.dart';
import '../../../home/presentation/pages/doctor_home_page.dart';
import '../../../patients/presentation/pages/patients_list_page.dart';
import '../../../profile/presentation/pages/doctor_profile_page.dart';

class DoctorNavigationPage extends StatefulWidget {
  const DoctorNavigationPage({super.key});

  @override
  State<DoctorNavigationPage> createState() => _DoctorNavigationPageState();
}

class _DoctorNavigationPageState extends State<DoctorNavigationPage> {
  int currentPage = 0;

  final List<Widget> _pages = [
    const DoctorHomePage(),
    const DoctorAppointmentsPage(),
    const PatientsListPage(),
    const DoctorProfilePage(),
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
          shadowColor: Colors.black.withOpacity(0.1),
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
                  icon: Icons.home_rounded,
                  title: AppLocalizations.of(context)!.home,
                  iconSize: 24,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                TabData(
                  icon: Icons.calendar_month_rounded,
                  title: AppLocalizations.of(context)!.appointments,
                  iconSize: 24,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                TabData(
                  icon: Icons.people_alt_rounded,
                  title: AppLocalizations.of(context)!.patients,
                  iconSize: 24,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                TabData(
                  icon: Icons.person_rounded,
                  title: AppLocalizations.of(context)!.profile,
                  iconSize: 24,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ],
              onTabChangedListener: (index) {
                setState(() {
                  currentPage = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
