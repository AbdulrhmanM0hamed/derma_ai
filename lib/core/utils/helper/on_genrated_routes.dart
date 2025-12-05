import 'package:derma_ai/user_features/doctor_profile/doctor_profile.dart';
import 'package:derma_ai/user_features/health_tips/presentation/pages/all_medical_articles_page.dart';
import 'package:derma_ai/user_features/navigation/presentation/pages/main_navigation_page.dart';
import 'package:derma_ai/user_features/profile/data/models/user_profile_model.dart';
import 'package:derma_ai/user_features/profile/presentation/pages/edit_profile_page.dart';
import 'package:flutter/material.dart';

// Splash and Onboarding
import '../../../user_features/splash/presentation/pages/splash_page.dart';
import '../../../user_features/onboarding/presentation/pages/onboarding_page.dart';

// Auth
import '../../../core/auth/presentation/pages/unified_login_page.dart';
import '../../../core/auth/presentation/pages/unified_register_page.dart';
import '../../../user_features/auth/presentation/pages/forgot_password_page.dart';
import '../../../user_features/auth/presentation/pages/password_reset_otp_page.dart';
import '../../../user_features/auth/presentation/pages/reset_password_page.dart';
import '../../../user_features/auth/presentation/pages/otp_verification_page.dart';
// Main App
import '../../../user_features/home/presentation/pages/home_page.dart';
import '../../../user_features/ai_diagnosis/presentation/pages/ai_diagnosis_page.dart';
import '../../../user_features/doctor_booking/presentation/pages/doctor_details_page.dart';
import '../../../user_features/profile/presentation/pages/profile_page.dart';
// Doctor Features
import '../../../doctor_feature/navigation/presentation/pages/doctor_navigation_page.dart';
import '../../../doctor_feature/home/presentation/pages/doctor_home_page.dart';
import '../../../doctor_feature/ai_diagnosis/presentation/pages/doctor_ai_diagnosis_page.dart';
import '../../../doctor_feature/prescriptions/presentation/pages/prescriptions_page.dart';
import '../../../doctor_feature/reports/presentation/pages/reports_page.dart';
import '../../../doctor_feature/patients/presentation/pages/advanced_patients_page.dart';
import '../../../doctor_feature/appointments/presentation/pages/advanced_appointments_page.dart';
import '../../../doctor_feature/settings/presentation/pages/doctor_settings_page.dart';
import '../../../doctor_feature/analytics/presentation/pages/analytics_dashboard_page.dart';
import '../../../doctor_feature/auth/presentation/pages/doctor_otp_verification_page.dart';
import '../../../user_features/health_tips/presentation/pages/all_health_tips_page.dart';

class AppRoutes {
  // Route names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String doctorLogin = '/doctor-login';
  static const String forgotPassword = '/forgot-password';
  static const String passwordResetOtp = '/password-reset-otp';
  static const String resetPassword = '/reset-password';
  static const String otpVerification = '/otp-verification';
  static const String home = '/home';
  static const String diagnosis = '/diagnosis';
  static const String doctorDetails = '/doctor-details';
  static const String profile = '/profile';
  static const String mainNavigationPage = '/main-navigation-page';
  static const String doctorProfile = '/doctor-profile';
  static const String doctorNavigation = '/doctor-navigation';

  // Doctor Feature Routes
  static const String doctorHome = '/doctor-home';
  static const String doctorAiDiagnosis = '/doctor-ai-diagnosis';
  static const String prescriptions = '/prescriptions';
  static const String reports = '/reports';
  static const String advancedPatients = '/advanced-patients';
  static const String advancedAppointments = '/advanced-appointments';
  static const String doctorSettings = '/doctor-settings';
  static const String analyticsDashboard = '/analytics-dashboard';
  static const String doctorOtpVerification = '/doctor-otp-verification';
  static const String allHealthTips = '/all-health-tips';
  static const String editProfile = '/edit-profile';
}

Route<dynamic> onGeneratedRoutes(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return _createRoute(const SplashPage());
    case AppRoutes.mainNavigationPage:
      return _createRoute(const MainNavigationPage());

    case AppRoutes.onboarding:
      return _createRoute(const OnboardingPage());

    case AppRoutes.login:
      return _createRoute(const UnifiedLoginPage());

    case AppRoutes.register:
      return _createRoute(const UnifiedRegisterPage());

    case AppRoutes.editProfile:
      // Expect userProfile as argument
      if (settings.arguments != null &&
          settings.arguments is UserProfileModel) {
        final userProfile = settings.arguments as UserProfileModel;
        return _createRoute(EditProfilePage(userProfile: userProfile));
      }
      // Fallback to profile page if no argument provided
      return _createRoute(const ProfilePage());

    case AppRoutes.doctorLogin:
      return _createRoute(const UnifiedLoginPage());

    case AppRoutes.forgotPassword:
      return _createRoute(const ForgotPasswordPage());

    case AppRoutes.passwordResetOtp:
      final args = settings.arguments as Map<String, String>;
      return _createRoute(PasswordResetOtpPage(email: args['email']!));

    case AppRoutes.resetPassword:
      final args = settings.arguments as Map<String, String>;
      return _createRoute(
        ResetPasswordPage(
          email: args['email']!,
          resetToken: args['resetToken']!,
        ),
      );

    case AppRoutes.otpVerification:
      final args = settings.arguments as Map<String, dynamic>;
      return _createRoute(
        OtpVerificationPage(
          userId: args['userId'] as int,
          email: args['email'] as String,
          phone: args['phone'] as String? ?? '',
          type: args['type'] as String? ?? 'email',
        ),
      );

    case AppRoutes.home:
      return _createRoute(const HomePage());

    case AppRoutes.diagnosis:
      return _createRoute(const AiDiagnosisPage());

    case AppRoutes.doctorDetails:
      return _createRoute(const DoctorDetailsPage());

    case AppRoutes.profile:
      return _createRoute(const ProfilePage());
    case AppRoutes.doctorProfile:
      return _createRoute(const DoctorProfile());
    case AppRoutes.doctorNavigation:
      return _createRoute(const DoctorNavigationPage());

    // Doctor Feature Routes
    case AppRoutes.doctorHome:
      return _createRoute(const DoctorHomePage());

    case AppRoutes.doctorAiDiagnosis:
      return _createRoute(const DoctorAiDiagnosisPage());

    case AppRoutes.prescriptions:
      return _createRoute(const PrescriptionsPage());

    case AllMedicalArticlesPage.routeName:
      return _createRoute(const AllMedicalArticlesPage());

    case AppRoutes.reports:
      return _createRoute(const ReportsPage());

    case AppRoutes.advancedPatients:
      return _createRoute(const AdvancedPatientsPage());

    case AppRoutes.advancedAppointments:
      return _createRoute(const AdvancedAppointmentsPage());

    case AppRoutes.doctorSettings:
      return _createRoute(const DoctorSettingsPage());

    case AppRoutes.analyticsDashboard:
      return _createRoute(const AnalyticsDashboardPage());

    case AppRoutes.doctorOtpVerification:
      final args = settings.arguments as Map<String, dynamic>;
      return _createRoute(
        DoctorOtpVerificationPage(
          userId: args['userId'] as int,
          email: args['email'] as String,
          phone: args['phone'] as String? ?? '',
          type: args['type'] as String? ?? 'email',
        ),
      );

    case AppRoutes.allHealthTips:
      return _createRoute(const AllHealthTipsPage());

    default:
      return _createRoute(const SplashPage());
  }
}

// Helper method to create routes with slide transition
PageRouteBuilder<T> _createRoute<T extends Object?>(Widget page) {
  return PageRouteBuilder<T>(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(position: animation.drive(tween), child: child);
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
