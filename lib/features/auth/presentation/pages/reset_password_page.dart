import 'package:derma_ai/core/utils/common/custom_app_bar.dart';
import 'package:derma_ai/core/utils/common/custom_button.dart';
import 'package:derma_ai/core/utils/common/custom_progress_indicator.dart';
import 'package:derma_ai/core/utils/common/custom_text_field.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/core/utils/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/service_locatores.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/helper/on_genrated_routes.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;
  final String resetToken;

  const ResetPasswordPage({
    super.key,
    required this.email,
    required this.resetToken,
  });

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  late final AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = sl<AuthCubit>();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _authCubit.close();
    super.dispose();
  }

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      _authCubit.resetPassword(
        token: widget.resetToken,
        newPassword: _passwordController.text.trim(),
      );
    }
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال كلمة المرور';
    }
    if (value.length < 8) {
      return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
      return 'كلمة المرور يجب أن تحتوي على حرف كبير وصغير ورقم';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى تأكيد كلمة المرور';
    }
    if (value != _passwordController.text) {
      return 'كلمة المرور غير متطابقة';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider.value(
      value: _authCubit,
      child: Scaffold(
     
        appBar: CustomAppBar(title: 'كلمة مرور جديدة'),
        body: Stack(
          children: [
            // Main Content
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                print('🔍 Reset Password State: ${state.runtimeType}');

                if (state is AuthLoading) {
                  setState(() => _isLoading = true);
                } else {
                  setState(() => _isLoading = false);
                }

                if (state is ResetPasswordSuccess) {
                  print('✅ Password Reset Success - navigating to login page');
                  CustomSnackbar.showSuccess(
                    context: context,
                    message: CustomSnackbar.getLocalizedMessage(
                      context: context,
                      messageAr: state.messageAr,
                      messageEn: state.messageEn,
                    ),
                  );
                  // Navigate back to login page
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login,
                    (route) => false,
                  );
                } else if (state is ResetPasswordFailure) {
                  print('❌ Password Reset Failed: ${state.messageEn}');
                  CustomSnackbar.showError(
                    context: context,
                    message: CustomSnackbar.getLocalizedMessage(
                      context: context,
                      messageAr: state.messageAr,
                      messageEn: state.messageEn,
                    ),
                  );
                }
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.all(size.width * 0.06),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: size.height * 0.01),

                  // Header Icon
                  Container(
                    height: size.width * 0.25,
                    width: size.width * 0.25,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lock_outline,
                      size: size.width * 0.12,
                      color: AppColors.primary,
                    ),
                  ),

                  SizedBox(height: size.height * 0.04),

                  // Title
                  Text(
                    'إنشاء كلمة مرور جديدة',
                    style: getBoldStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: size.height * 0.01),

                  // Subtitle
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: getRegularStyle(
                        fontFamily: FontConstant.cairo,
                        color: AppColors.grey,
                        fontSize: 16,
                      ),
                      children: [
                        const TextSpan(text: 'أدخل كلمة مرور جديدة لحسابك\n'),
                        TextSpan(
                          text: widget.email,
                          style: getSemiBoldStyle(
                            fontFamily: FontConstant.cairo,
                            color: AppColors.primary,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.02),

                  // Back to Login
                  TextButton(
                    onPressed: _isLoading ? null : () => Navigator.pop(context),
                    child: Text(
                      'العودة لتسجيل الدخول',
                      style: getSemiBoldStyle(
                        fontFamily: FontConstant.cairo,
                        color: AppColors.primary,
                        fontSize: 14,
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.02),

                  // New Password Field
                  CustomTextField(
                    controller: _passwordController,
                    label: 'كلمة المرور الجديدة',
                    hint: 'أدخل كلمة المرور الجديدة',
                    obscureText: _obscurePassword,
                    prefix: Icon(Icons.lock_outline),
                    suffix: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.grey,
                      ),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                    validator: _validatePassword,
                  ),

                  SizedBox(height: size.height * 0.02),

                  // Confirm Password Field
                  CustomTextField(
                    controller: _confirmPasswordController,
                    label: 'تأكيد كلمة المرور',
                    hint: 'أعد إدخال كلمة المرور',
                    obscureText: _obscureConfirmPassword,
                    prefix: Icon(Icons.lock_outline),
                    suffix: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.grey,
                      ),
                      onPressed: () {
                        setState(
                          () =>
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword,
                        );
                      },
                    ),
                    validator: _validateConfirmPassword,
                  ),

                  SizedBox(height: size.height * 0.01),

                  // Password Requirements
                  // Container(
                  //   padding: EdgeInsets.all(size.width * 0.04),
                  //   decoration: BoxDecoration(
                  //     color: AppColors.primary.withValues(alpha: 0.1),
                  //     borderRadius: BorderRadius.circular(12),
                  //     border: Border.all(color: AppColors.primary, width: 1),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         'متطلبات كلمة المرور:',
                  //         style: getSemiBoldStyle(
                  //           fontFamily: FontConstant.cairo,
                  //           color: AppColors.primary,
                  //           fontSize: 14,
                  //         ),
                  //       ),
                  //       SizedBox(height: size.height * 0.01),
                  //       _buildRequirement('8 أحرف على الأقل'),
                  //       _buildRequirement('حرف كبير وحرف صغير'),
                  //       _buildRequirement('رقم واحد على الأقل'),
                  //     ],
                  //   ),
                  // ),

                  SizedBox(height: size.height * 0.04),

                  // Reset Button
                  CustomButton(
                    onPressed: _resetPassword,
                    text: 'إعادة تعيين كلمة المرور',
                   
                    ),
                  
                    ],
                  ),
                ),
              ),
            ),
            
            // Loading Overlay
            if (_isLoading)
              Container(
                color: Colors.black.withValues(alpha: 0.3),
                child: const Center(
                  child: CustomProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirement(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, size: 16, color: AppColors.grey),
          const SizedBox(width: 8),
          Text(
            text,
            style: getRegularStyle(
              color: AppColors.grey,
              fontSize: 12,
              fontFamily: FontConstant.cairo,
            ),
          ),
        ],
      ),
    );
  }
}
