// import 'package:derma_ai/features/auth/presentation/pages/login_page_clean.dart';
// import 'package:derma_ai/features/auth/presentation/pages/register_page_clean.dart';
// import 'package:derma_ai/features/onboarding/presentation/pages/onboarding_page.dart';
// import 'package:derma_ai/features/splash/presentation/pages/splash_page.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import '../../main.dart';
// import '../../features/home/presentation/pages/home_page.dart';
// import '../../features/doctor_booking/presentation/pages/doctor_details_page.dart';
// import '../../features/ai_diagnosis/presentation/pages/ai_diagnosis_page.dart';
// import '../../features/profile/presentation/pages/profile_page.dart';

// class AppRouter {
//   static final router = GoRouter(
//     initialLocation: '/splash',
//     debugLogDiagnostics: true,
//     routes: [
//       GoRoute(
//         path: '/splash',
//         name: 'splash',
//         builder: (context, state) => const SplashPage(),
//       ),
//       GoRoute(
//         path: '/onboarding',
//         name: 'onboarding',
//         builder: (context, state) => const OnboardingPage(),
//       ),
//       GoRoute(
//         path: '/login',
//         name: 'login',
//         builder: (context, state) => const LoginPage(),
//       ),
//       GoRoute(
//         path: '/register',
//         name: 'register',
//         builder: (context, state) => const RegisterPage(),
//       ),
//       GoRoute(
//         path: '/',
//         name: 'home',
//         builder: (context, state) => const MainScreen(
//           currentIndex: 0,
//           child: HomePage(),
//         ),
//       ),
//       GoRoute(
//         path: '/doctor/:id',
//         name: 'doctor_details',
//         builder: (context, state) {
//           return const DoctorDetailsPage();
//         },
//       ),
//       GoRoute(
//         path: '/diagnosis',
//         name: 'diagnosis',
//         builder: (context, state) => const MainScreen(
//           currentIndex: 1,
//           child: AiDiagnosisPage(),
//         ),
//       ),
//       GoRoute(
//         path: '/profile',
//         name: 'profile',
//         builder: (context, state) => const MainScreen(
//           currentIndex: 2,
//           child: ProfilePage(),
//         ),
//       ),
//     ],
//     errorBuilder: (context, state) => Scaffold(
//       body: Center(
//         child: Text(
//           'Page not found: ${state.uri}',
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//       ),
//     ),
//   );
// }