import 'package:flutter/material.dart';

// Doctor Feature Pages
import '../../doctor_feature/home/presentation/pages/doctor_home_page.dart';
import '../../doctor_feature/ai_diagnosis/presentation/pages/doctor_ai_diagnosis_page.dart';
import '../../doctor_feature/prescriptions/presentation/pages/prescriptions_page.dart';
import '../../doctor_feature/reports/presentation/pages/reports_page.dart';
import '../../doctor_feature/patients/presentation/pages/advanced_patients_page.dart';
import '../../doctor_feature/appointments/presentation/pages/advanced_appointments_page.dart';
import '../../doctor_feature/settings/presentation/pages/doctor_settings_page.dart';
import '../../doctor_feature/analytics/presentation/pages/analytics_dashboard_page.dart';

class AppRoutes {
  // Route Names
  static const String doctorHome = '/doctor-home';
  static const String doctorAiDiagnosis = '/doctor-ai-diagnosis';
  static const String prescriptions = '/prescriptions';
  static const String reports = '/reports';
  static const String advancedPatients = '/advanced-patients';
  static const String advancedAppointments = '/advanced-appointments';
  static const String doctorSettings = '/doctor-settings';
  static const String analyticsDashboard = '/analytics-dashboard';

  // Routes Map
  static Map<String, WidgetBuilder> get routes {
    return {
      doctorHome: (context) => const DoctorHomePage(),
      doctorAiDiagnosis: (context) => const DoctorAiDiagnosisPage(),
      prescriptions: (context) => const PrescriptionsPage(),
      reports: (context) => const ReportsPage(),
      advancedPatients: (context) => const AdvancedPatientsPage(),
      advancedAppointments: (context) => const AdvancedAppointmentsPage(),
      doctorSettings: (context) => const DoctorSettingsPage(),
      analyticsDashboard: (context) => const AnalyticsDashboardPage(),
    };
  }

  // Generate Route Method
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case doctorHome:
        return _createRoute(const DoctorHomePage());
      
      case doctorAiDiagnosis:
        return _createRoute(const DoctorAiDiagnosisPage());
      
      case prescriptions:
        return _createRoute(const PrescriptionsPage());
      
      case reports:
        return _createRoute(const ReportsPage());
      
      case advancedPatients:
        return _createRoute(const AdvancedPatientsPage());
      
      case advancedAppointments:
        return _createRoute(const AdvancedAppointmentsPage());
      
      case doctorSettings:
        return _createRoute(const DoctorSettingsPage());
      
      case analyticsDashboard:
        return _createRoute(const AnalyticsDashboardPage());
      
      default:
        return _createRoute(
          Scaffold(
            appBar: AppBar(
              title: const Text('صفحة غير موجودة'),
            ),
            body: const Center(
              child: Text(
                'الصفحة المطلوبة غير موجودة',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        );
    }
  }

  // Create Route with Animation
  static Route<dynamic> _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  // Navigation Helper Methods
  static void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      doctorHome,
      (route) => false,
    );
  }

  static void navigateToAiDiagnosis(BuildContext context) {
    Navigator.pushNamed(context, doctorAiDiagnosis);
  }

  static void navigateToPrescriptions(BuildContext context) {
    Navigator.pushNamed(context, prescriptions);
  }

  static void navigateToReports(BuildContext context) {
    Navigator.pushNamed(context, reports);
  }

  static void navigateToPatients(BuildContext context) {
    Navigator.pushNamed(context, advancedPatients);
  }

  static void navigateToAppointments(BuildContext context) {
    Navigator.pushNamed(context, advancedAppointments);
  }

  static void navigateToSettings(BuildContext context) {
    Navigator.pushNamed(context, doctorSettings);
  }

  static void navigateToAnalytics(BuildContext context) {
    Navigator.pushNamed(context, analyticsDashboard);
  }

  // Back Navigation
  static void goBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      navigateToHome(context);
    }
  }

  // Replace Current Route
  static void replaceCurrent(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  // Clear Stack and Navigate
  static void clearStackAndNavigate(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => false,
    );
  }
}
