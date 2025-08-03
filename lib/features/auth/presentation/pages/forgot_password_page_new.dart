// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/services/service_locatores.dart';
// import '../../../../core/utils/theme/app_colors.dart';
// import '../../../../core/utils/constant/font_manger.dart';
// import '../../../../core/utils/constant/styles_manger.dart';
// import '../../../../core/widgets/custom_button.dart';
// import '../../../../core/utils/widgets/custom_snackbar.dart';
// import '../../../../core/widgets/custom_text_field.dart';
// import '../bloc/auth_bloc.dart';
// import '../bloc/auth_state.dart';

// class ForgotPasswordPage extends StatefulWidget {
//   const ForgotPasswordPage({super.key});

//   @override
//   State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
// }

// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   final _emailController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   late final AuthCubit _authCubit;

//   @override
//   void initState() {
//     super.initState();
//     _authCubit = sl<AuthCubit>();
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _authCubit.close();
//     super.dispose();
//   }

//   void _requestOtp() {
//     if (_formKey.currentState!.validate()) {
//       _authCubit.requestPasswordResetOtp(
//         email: _emailController.text.trim(),
//         type: 'email',
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: _authCubit,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
//             onPressed: () => Navigator.pop(context),
//           ),
//           title: Text(
//             'إعادة تعيين كلمة المرور',
//             style: getRegularStyle(
//               color: AppColors.primary,
//               fontSize: 18,
//               fontFamily: FontConstant.cairo,
//             ),
//           ),
//           centerTitle: true,
//         ),
//         body: BlocListener<AuthCubit, AuthState>(
//           listener: (context, state) {
//             print('🔍 Forgot Password State: ${state.runtimeType}');
            
//             if (state is RequestPasswordResetOtpSuccess) {
//               print('✅ OTP Request Success - navigating to OTP page');
//               CustomSnackbar.showSuccess(
//                 context: context,
//                 message: state.messageAr.isNotEmpty ? state.messageAr : state.messageEn,
//               );
//               Navigator.pushNamed(
//                 context,
//                 '/passwordResetOtp',
//                 arguments: {'email': _emailController.text.trim()},
//               );
//             } else if (state is RequestPasswordResetOtpFailure) {
//               print('❌ OTP Request Failed: ${state.messageEn}');
//               CustomSnackbar.showError(
//                 context: context,
//                 message: state.messageAr.isNotEmpty ? state.messageAr : state.messageEn,
//               );
//             }
//           },
//           child: Stack(
//             children: [
//               SingleChildScrollView(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       const SizedBox(height: 40),
                      
//                       // Header Icon
//                       Center(
//                         child: Container(
//                           width: 80,
//                           height: 80,
//                           decoration: BoxDecoration(
//                             color: AppColors.primary.withValues(alpha: 0.1),
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Icon(
//                             Icons.lock_reset,
//                             color: AppColors.primary,
//                             size: 40,
//                           ),
//                         ),
//                       ),
                      
//                       const SizedBox(height: 32),
                      
//                       // Title
//                       Text(
//                         'نسيت كلمة المرور؟',
//                         style: getBoldStyle(
//                           color: AppColors.primary,
//                           fontSize: 24,
//                           fontFamily: FontConstant.cairo,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
                      
//                       const SizedBox(height: 16),
                      
//                       // Subtitle
//                       Text(
//                         'أدخل بريدك الإلكتروني وسنرسل لك رمز التحقق لإعادة تعيين كلمة المرور',
//                         style: getRegularStyle(
//                           color: AppColors.textSecondary,
//                           fontSize: 16,
//                           fontFamily: FontConstant.cairo,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
                      
//                       const SizedBox(height: 40),
                      
//                       // Email Field
//                       CustomTextField(
//                         controller: _emailController,
//                         labelText: 'البريد الإلكتروني',
//                         hintText: 'أدخل بريدك الإلكتروني',
//                         keyboardType: TextInputType.emailAddress,
//                         prefixIcon: Icons.email_outlined,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'يرجى إدخال البريد الإلكتروني';
//                           }
//                           if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//                             return 'يرجى إدخال بريد إلكتروني صحيح';
//                           }
//                           return null;
//                         },
//                       ),
                      
//                       const SizedBox(height: 32),
                      
//                       // Submit Button
//                       BlocBuilder<AuthCubit, AuthState>(
//                         builder: (context, state) {
//                           final isLoading = state is AuthLoading;
                          
//                           return CustomButton(
//                             text: 'إرسال رمز التحقق',
//                             onPressed: isLoading ? () {} : _requestOtp,
//                             isLoading: isLoading,
//                           );
//                         },
//                       ),
                      
//                       const SizedBox(height: 24),
                      
//                       // Back to Login
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             'تذكرت كلمة المرور؟ ',
//                             style: getRegularStyle(
//                               color: AppColors.textSecondary,
//                               fontSize: 14,
//                               fontFamily: FontConstant.cairo,
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () => Navigator.pop(context),
//                             child: Text(
//                               'تسجيل الدخول',
//                               style: getSemiBoldStyle(
//                                 color: AppColors.primary,
//                                 fontSize: 14,
//                                 fontFamily: FontConstant.cairo,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
              
//               // Loading Overlay
//               BlocBuilder<AuthCubit, AuthState>(
//                 builder: (context, state) {
//                   if (state is AuthLoading) {
//                     return Container(
//                       color: Colors.black.withValues(alpha: 0.3),
//                       child: const Center(
//                         child: CircularProgressIndicator(
//                           valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
//                         ),
//                       ),
//                     );
//                   }
//                   return const SizedBox.shrink();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
