import 'package:derma_ai/features/doctor_profile/doctor_profile.dart';
import 'package:derma_ai/features/navigation/presentation/pages/main_navigation_page.dart';
import 'package:flutter/material.dart';

// Splash and Onboarding
import '../../../features/splash/presentation/pages/splash_page.dart';
import '../../../features/onboarding/presentation/pages/onboarding_page.dart';

// Auth
import '../../../features/auth/presentation/pages/login_page.dart';
import '../../../features/auth/presentation/pages/register_page.dart';
import '../../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../../features/auth/presentation/pages/password_reset_otp_page.dart';
import '../../../features/auth/presentation/pages/reset_password_page.dart';
import '../../../features/auth/presentation/pages/otp_verification_page.dart';

// Main App
import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/ai_diagnosis/presentation/pages/ai_diagnosis_page.dart';
import '../../../features/doctor_booking/presentation/pages/doctor_details_page.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';

class AppRoutes {
  // Route names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
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
      return _createRoute(const LoginPage());

    case AppRoutes.register:
      return _createRoute(const RegisterPage());

    case AppRoutes.forgotPassword:
      return _createRoute(const ForgotPasswordPage());

    case AppRoutes.passwordResetOtp:
      final args = settings.arguments as Map<String, String>;
      return _createRoute(PasswordResetOtpPage(email: args['email']!));

    case AppRoutes.resetPassword:
      final args = settings.arguments as Map<String, String>;
      return _createRoute(ResetPasswordPage(
        email: args['email']!,
        resetToken: args['resetToken']!,
      ));

    case AppRoutes.otpVerification:
      final args = settings.arguments as Map<String, dynamic>;
      return _createRoute(OtpVerificationPage(
        userId: args['userId'] as int,
        email: args['email'] as String,
        phone: args['phone'] as String? ?? '',
      ));

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
