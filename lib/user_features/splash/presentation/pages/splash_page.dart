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
      // Check if user is already logged in
      try {
        final tokenStorage = sl<TokenStorageService>();
        final token = tokenStorage.accessToken;
        
        if (token != null && token.isNotEmpty) {
          // User is logged in, go to main navigation
          Navigator.pushReplacementNamed(context, AppRoutes.mainNavigationPage);
        } else {
          // User is not logged in, go to login page
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }
      } catch (e) {
        // If there's an error checking token, go to login page
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
