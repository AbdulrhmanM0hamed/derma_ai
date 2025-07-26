// import 'package:derma_ai/core/utils/constant/font_manger.dart';
// import 'package:derma_ai/core/utils/constant/styles_manger.dart';
// import 'package:derma_ai/core/utils/theme/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:go_router/go_router.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import '../../../../core/utils/animations/app_animations.dart';


// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _navigateToOnboarding();
//   }

//   Future<void> _navigateToOnboarding() async {
//     await Future.delayed(const Duration(seconds: 3));
//     if (mounted) {
//       context.go('/onboarding');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primary,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildLogo(),
//             const SizedBox(height: 24),
//             _buildAppName(),
//             const SizedBox(height: 48),
//             _buildLoadingIndicator(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLogo() {
//     return Container(
//       width: 120,
//       height: 120,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         shape: BoxShape.circle,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Center(
//         child: SvgPicture.asset(
//           'assets/images/logo.svg',
//           width: 80,
//           height: 80,
//         ),
//       ),
//     )
//         .animate(effects: fadeInScaleUp(
//           duration: 600.ms,
//           begin: 0.5,
//         ));
//   }

//   Widget _buildAppName() {
//     return Column(
//       children: [
//         Text(
//           AppLocalizations.of(context)!.appName,
//           style: getBoldStyle(
//             color: AppColors.textPrimary,
//             fontSize: 28,
//             fontFamily: FontConstant.cairo,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           AppLocalizations.of(context)!.appTagline,
//           style: getRegularStyle(
//                   color: AppColors.textSecondary,
//                   fontSize: 16,
//                   fontFamily: FontConstant.cairo,
//                 ),
//         ),
//       ],
//     ).animate(effects: fadeInSlide(
//           duration: 600.ms,
//           delay: 300.ms,
//           beginY: 0.2,
//         ));
//   }

//   Widget _buildLoadingIndicator() {
//     return Column(
//       children: [
//         SizedBox(
//           width: 48,
//           height: 48,
//           child: CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//             strokeWidth: 4,
//           ),
//         ),
//         const SizedBox(height: 16),
//         Text(
//           AppLocalizations.of(context)!.loading,
//           style: getRegularStyle(
//             color: Colors.white.withOpacity(0.8),
//             fontSize: 14,
//             fontFamily: FontConstant.cairo,
//           ),
//         ),
//       ],
//     ).animate(effects: fadeIn(
//           duration: 600.ms,
//           delay: 600.ms,
//         ));
//   }
// }