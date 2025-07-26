// import 'package:derma_ai/core/utils/theme/app_colors.dart';
// import 'package:derma_ai/core/widgets/custom_button.dart';
// import 'package:derma_ai/core/widgets/custom_text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:go_router/go_router.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:derma_ai/core/utils/constant/font_manger.dart';
// import 'package:derma_ai/core/utils/constant/styles_manger.dart';

// import '../../../../core/utils/animations/app_animations.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isLoading = false;
//   bool _rememberMe = false;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _login() {
//     if (_formKey.currentState?.validate() ?? false) {
//       setState(() {
//         _isLoading = true;
//       });
//       // Simulate API call
//       Future.delayed(const Duration(seconds: 2), () {
//         setState(() {
//           _isLoading = false;
//         });
//         // Navigate to home page
//         if (mounted) {
//           context.go('/');
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(24),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 40),
//                   _buildHeader(),
//                   const SizedBox(height: 40),
//                   _buildEmailField(),
//                   const SizedBox(height: 16),
//                   _buildPasswordField(),
//                   const SizedBox(height: 16),
//                   _buildRememberMeAndForgotPassword(),
//                   const SizedBox(height: 24),
//                   _buildLoginButton(),
//                   const SizedBox(height: 24),
//                   _buildDivider(),
//                   const SizedBox(height: 24),
//                   _buildSocialLogin(),
//                   const SizedBox(height: 24),
//                   _buildSignUpLink(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 60,
//               height: 60,
//               decoration: BoxDecoration(
//                 color: AppColors.primary.withValues(alpha: 0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: Center(
//                 child: Text(
//                   'D',
//                   style: getBoldStyle(
//                     color: AppColors.primary,
//                     fontSize: 32,
//                     fontFamily: FontConstant.cairo,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ).animate(effects: fadeInScaleUp(
//           duration: 300.ms,
//           begin: 0.8,
//         )),
//         const SizedBox(height: 24),
//         Text(
//           AppLocalizations.of(context)!.welcomeBack,
//           style: getBoldStyle(
//                     color: AppColors.textPrimary,
//                     fontSize: 28,
//                     fontFamily: FontConstant.cairo,
//                   ),
//           textAlign: TextAlign.center,
//         ).animate(effects: fadeInSlide(
//           duration: 300.ms,
//           delay: 100.ms,
//           beginY: 0.2,
//         )),
//         const SizedBox(height: 8),
//         Text(
//           AppLocalizations.of(context)!.signInToContinue,
//           style: getMediumStyle(
//                           color: AppColors.textSecondary,
//                           fontSize: 12,
//                           fontFamily: FontConstant.cairo,
//                         ),
//           textAlign: TextAlign.center,
//         ).animate(effects: fadeInSlide(
//           duration: 300.ms,
//           delay: 200.ms,
//           beginY: 0.2,
//         )),
//       ],
//     );
//   }

//   Widget _buildEmailField() {
//     return CustomTextField(
//       controller: _emailController,
//       labelText: AppLocalizations.of(context)!.email,
//       hintText: AppLocalizations.of(context)!.enterEmail,
//       prefixIcon: Icons.email_outlined,
//       keyboardType: TextInputType.emailAddress,
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return AppLocalizations.of(context)!.pleaseEnterEmail;
//         }
//         if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//           return AppLocalizations.of(context)!.pleaseEnterValidEmail;
//         }
//         return null;
//       },
//     ).animate(effects: fadeInSlide(
//           duration: 300.ms,
//           delay: 300.ms,
//           beginY: 0.2,
//         ));
//   }

//   Widget _buildPasswordField() {
//     return CustomTextField(
//       controller: _passwordController,
//       labelText: AppLocalizations.of(context)!.password,
//       hintText: AppLocalizations.of(context)!.enterPassword,
//       prefixIcon: Icons.lock_outline,
//       obscureText: true,
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return AppLocalizations.of(context)!.pleaseEnterPassword;
//         }
//         if (value.length < 6) {
//           return AppLocalizations.of(context)!.passwordMustBe;
//         }
//         return null;
//       },
//     ).animate(effects: fadeInSlide(
//           duration: 300.ms,
//           delay: 400.ms,
//           beginY: 0.2,
//         ));
//   }

//   Widget _buildRememberMeAndForgotPassword() {
//     return Row(
//       children: [
//         Checkbox(
//           value: _rememberMe,
//           onChanged: (value) {
//             setState(() {
//               _rememberMe = value ?? false;
//             });
//           },
//           activeColor: AppColors.primary,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(4),
//           ),
//         ),
//         Text(
//           AppLocalizations.of(context)!.rememberMe,
//           style: getRegularStyle(
//             color: AppColors.textPrimary,
//             fontFamily: FontConstant.cairo,
//           ),
//         ),
//         const Spacer(),
//         TextButton(
//           onPressed: () {
//             // Navigate to forgot password
//           },
//           child: Text(
//             AppLocalizations.of(context)!.forgotPassword,
//             style: getSemiBoldStyle(
//               color: AppColors.primary,
//               fontFamily: FontConstant.cairo,
//             ),
//           ),
//         ),
//       ],
//     ).animate(effects: fadeIn(
//           duration: 300.ms,
//           delay: 500.ms,
//         ));
//   }

//   Widget _buildLoginButton() {
//     return Animate(
//       effects: [
//         FadeEffect(duration: 300.ms, delay: 600.ms),
//         SlideEffect(begin: const Offset(0, 0.2), end: Offset.zero, duration: 300.ms),
//       ],
//       child: CustomButton(
//         text: AppLocalizations.of(context)!.login,
//         onPressed: _login,
//         isLoading: _isLoading,
//         type: ButtonType.primary,
//         width: double.infinity,
//         height: 56,
//       ),
//     );
//   }

//   Widget _buildDivider() {
//     return Row(
//       children: [
//         const Expanded(
//           child: Divider(),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Text(
//             AppLocalizations.of(context)!.orContinueWith,
//             style: getRegularStyle(
//                           color: AppColors.textSecondary,
//                           fontFamily: FontConstant.cairo,
//                         ),
//           ),
//         ),
//         const Expanded(
//           child: Divider(),
//         ),
//       ],
//     ).animate(effects: fadeIn(
//           duration: 300.ms,
//           delay: 700.ms,
//         ));
//   }

//   Widget _buildSocialLogin() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _buildSocialButton(
//           icon: 'assets/icons/google.svg',
//           onPressed: () {
//             // Login with Google
//           },
//           iconFallback: Icons.g_mobiledata,
//         ),
//         const SizedBox(width: 16),
//         _buildSocialButton(
//           icon: 'assets/icons/facebook.svg',
//           onPressed: () {
//             // Login with Facebook
//           },
//           iconFallback: Icons.facebook,
//         ),
//         const SizedBox(width: 16),
//         _buildSocialButton(
//           icon: 'assets/icons/apple.svg',
//           onPressed: () {
//             // Login with Apple
//           },
//           iconFallback: Icons.apple,
//         ),
//       ],
//     ).animate(effects: fadeIn(
//           duration: 300.ms,
//           delay: 800.ms,
//         ));
//   }

//   Widget _buildSocialButton({
//     required String icon,
//     required VoidCallback onPressed,
//     required IconData iconFallback,
//   }) {
//     return InkWell(
//       onTap: onPressed,
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         width: 60,
//         height: 60,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: AppColors.border),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withValues(alpha: 0.1),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Center(
//           // In a real app, we would use SvgPicture.asset here
//           // But for simplicity, we'll use an Icon
//           child: Icon(
//             iconFallback,
//             color: AppColors.textSecondary,
//             size: 24,
//           ),
//         ),
//       ),
//     ).animate(onPlay: (controller) => controller.repeat(reverse: true))
//         .scaleXY(begin: 1, end: 1.05, duration: 2000.ms, curve: Curves.easeInOut);
//   }

//   Widget _buildSignUpLink() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           AppLocalizations.of(context)!.dontHaveAccount,
//           style: getRegularStyle(
//             color: AppColors.textSecondary,
//             fontFamily: FontConstant.cairo,
//           ),
//         ),
//         TextButton(
//           onPressed: () {
//             // Navigate to sign up
//           },
//           child: Text(
//             AppLocalizations.of(context)!.signUp,
//             style: getBoldStyle(
//               color: AppColors.primary,
//               fontFamily: FontConstant.cairo,
//             ),
//           ),
//         ),
//       ],
//     ).animate(effects: fadeIn(
//           duration: 300.ms,
//           delay: 900.ms,
//         ));
//   }
// }