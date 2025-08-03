import 'package:flutter/material.dart';

import '../../../../core/utils/helper/on_genrated_routes.dart';
import '../../../../core/services/service_locatores.dart';
import '../../../../core/services/token_storage_service.dart';
import '../widgets/splash_logo.dart';
import '../widgets/splash_app_name.dart';
import '../widgets/splash_loading_indicator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      final storage = sl<TokenStorageService>();
      
      if (!storage.isOnboardingCompleted) {
        // First time user - show onboarding
        Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
      } else if (storage.isLoggedIn) {
        // User is logged in - go to main app
        Navigator.pushReplacementNamed(context, AppRoutes.mainNavigationPage);
      } else {
        // User completed onboarding but not logged in - go to login
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SplashLogo(),
            const SizedBox(height: 32),
            const SplashAppName(),
            const SizedBox(height: 64),
            const SplashLoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
