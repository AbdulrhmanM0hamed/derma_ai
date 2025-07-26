// import 'package:derma_ai/core/utils/theme/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:go_router/go_router.dart';
// import 'package:derma_ai/core/utils/constant/font_manger.dart';
// import 'package:derma_ai/core/utils/constant/styles_manger.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import '../../../../core/widgets/custom_button.dart';
// import '../../../../core/widgets/custom_text_field.dart';

// import '../../../../core/utils/animations/app_animations.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   bool _isLoading = false;
//   bool _acceptTerms = false;

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   void _register() {
//     if (_formKey.currentState?.validate() ?? false) {
//       if (!_acceptTerms) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               AppLocalizations.of(context)!.pleaseAcceptTerms,
//               style: getRegularStyle(
//                 color: Colors.white,
//                 fontFamily: FontConstant.cairo,
//               ),
//             ),
//             backgroundColor: AppColors.error,
//           ),
//         );
//         return;
//       }
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
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(24),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildHeader(),
//                   const SizedBox(height: 32),
//                   _buildNameField(),
//                   const SizedBox(height: 16),
//                   _buildEmailField(),
//                   const SizedBox(height: 16),
//                   _buildPasswordField(),
//                   const SizedBox(height: 16),
//                   _buildConfirmPasswordField(),
//                   const SizedBox(height: 24),
//                   _buildTermsAndConditions(),
//                   const SizedBox(height: 24),
//                   _buildRegisterButton(),
//                   const SizedBox(height: 24),
//                   _buildLoginLink(),
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
//         Text(
//           AppLocalizations.of(context)!.createAccount,
//           style: getBoldStyle(
//                     color: AppColors.textPrimary,
//                     fontSize: 28,
//                     fontFamily: FontConstant.cairo,
//                   ),
//         ).animate(effects: fadeInSlide(
//           duration: 300.ms,
//           beginY: 0.2,
//         )),
//         const SizedBox(height: 8),
//         Text(
//           AppLocalizations.of(context)!.signUpToGetStarted,
//           style: getRegularStyle(
//                     color: AppColors.textSecondary,
//                     fontSize: 16,
//                     fontFamily: FontConstant.cairo,
//                   ),
//         ).animate(effects: fadeInSlide(
//           duration: 300.ms,
//           delay: 100.ms,
//           beginY: 0.2,
//         )),
//       ],
//     );
//   }

//   Widget _buildNameField() {
//     return CustomTextField(
//       controller: _nameController,
//       labelText: AppLocalizations.of(context)!.fullName,
//       hintText: AppLocalizations.of(context)!.enterFullName,
//       prefixIcon: Icons.person_outline,
//       keyboardType: TextInputType.name,
//       textCapitalization: TextCapitalization.words,
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return AppLocalizations.of(context)!.pleaseEnterName;
//         }
//         return null;
//       },
//     ).animate(effects: fadeInSlide(
//           duration: 300.ms,
//           delay: 200.ms,
//           beginY: 0.2,
//         ));
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

//   Widget _buildConfirmPasswordField() {
//     return CustomTextField(
//       controller: _confirmPasswordController,
//       labelText: AppLocalizations.of(context)!.confirmPassword,
//       hintText: AppLocalizations.of(context)!.confirmYourPassword,
//       prefixIcon: Icons.lock_outline,
//       obscureText: true,
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return AppLocalizations.of(context)!.pleaseConfirmPassword;
//         }
//         if (value != _passwordController.text) {
//           return AppLocalizations.of(context)!.passwordsDoNotMatch;
//         }
//         return null;
//       },
//     ).animate(effects: fadeInSlide(
//           duration: 300.ms,
//           delay: 500.ms,
//           beginY: 0.2,
//         ));
//   }

//   Widget _buildTermsAndConditions() {
//     return Row(
//       children: [
//         Checkbox(
//           value: _acceptTerms,
//           onChanged: (value) {
//             setState(() {
//               _acceptTerms = value ?? false;
//             });
//           },
//           activeColor: AppColors.primary,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(4),
//           ),
//         ),
//         Expanded(
//           child: RichText(
//             text: TextSpan(
//               text: AppLocalizations.of(context)!.iAgreeToThe,
//               style: getRegularStyle(
//                     color: AppColors.textSecondary,
//                     fontSize: 16,
//                     fontFamily: FontConstant.cairo,
//                   ),
//               children: [
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.termsOfService,
//                   style: getBoldStyle(
//                     color: AppColors.primary,
//                     fontSize: 16,
//                     fontFamily: FontConstant.cairo,
//                   ),
//                 ),
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.and,
//                 ),
//                 TextSpan(
//                   text: AppLocalizations.of(context)!.privacyPolicy,
//                   style: getBoldStyle(
//                     color: AppColors.primary,
//                     fontSize: 16,
//                     fontFamily: FontConstant.cairo,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ).animate(effects: fadeIn(
//           duration: 300.ms,
//           delay: 600.ms,
//         ));
//   }

//   Widget _buildRegisterButton() {
//     return Animate(
//       effects: [
//         FadeEffect(duration: 300.ms, delay: 700.ms),
//         SlideEffect(begin: const Offset(0, 0.2), end: Offset.zero, duration: 300.ms),
//       ],
//       child: CustomButton(
//         text: AppLocalizations.of(context)!.createAccount,
//         onPressed: _register,
//         isLoading: _isLoading,
//         type: ButtonType.primary,
//         width: double.infinity,
//         height: 56,
//       ),
//     );
//   }

//   Widget _buildLoginLink() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           AppLocalizations.of(context)!.alreadyHaveAccount,
//           style: getRegularStyle(
//                         color: AppColors.textSecondary,
//                         fontSize: 16,
//                         fontFamily: FontConstant.cairo,
//                       ),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: Text(
//             AppLocalizations.of(context)!.login,
//             style: getBoldStyle(
//               color: AppColors.primary,
//               fontFamily: FontConstant.cairo,
//             ),
//           ),
//         ),
//       ],
//     ).animate(effects: fadeIn(
//           duration: 300.ms,
//           delay: 800.ms,
//         ));
//   }
// }