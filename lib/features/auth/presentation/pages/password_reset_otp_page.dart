import 'package:derma_ai/core/utils/common/custom_app_bar.dart';
import 'package:derma_ai/core/utils/common/custom_progress_indicator.dart';
import 'package:derma_ai/core/utils/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

import '../../../../core/services/service_locatores.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/helper/on_genrated_routes.dart';
import '../../../../core/widgets/custom_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';

class PasswordResetOtpPage extends StatefulWidget {
  final String email;

  const PasswordResetOtpPage({super.key, required this.email});

  @override
  State<PasswordResetOtpPage> createState() => _PasswordResetOtpPageState();
}

class _PasswordResetOtpPageState extends State<PasswordResetOtpPage> {
  final _otpController = TextEditingController();
  final GlobalKey<OtpPinFieldState> _otpPinFieldController =
      GlobalKey<OtpPinFieldState>();
  String _resetToken = '';
  String _otpCode = '';
  late final AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = sl<AuthCubit>();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _authCubit.close();
    super.dispose();
  }

  void _verifyOtp() {
    if (_otpCode.length == 6) {
      _authCubit.verifyPasswordResetOtp(email: widget.email, otp: _otpCode);
    } else {
      CustomSnackbar.showError(
        message: CustomSnackbar.getLocalizedMessage(
          context: context,
          messageAr: 'يرجى إدخال رمز التحقق المكون من 6 أرقام',
          messageEn: 'Please enter a valid OTP',
        ),
        context: context,
      );
    }
  }

  void _resendOtp() {
    _authCubit.requestPasswordResetOtp(email: widget.email, type: 'email');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider.value(
      value: _authCubit,
      child: Scaffold(
        appBar: CustomAppBar(title: 'التحقق من الرمز', centerTitle: true),
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            print('🔍 Password Reset OTP State: ${state.runtimeType}');

            if (state is VerifyPasswordResetOtpSuccess) {
              print('✅ OTP Success - navigating to reset password page');
              setState(() => _resetToken = state.resetToken);
              CustomSnackbar.showSuccess(
                message: CustomSnackbar.getLocalizedMessage(
                  context: context,
                  messageAr: state.messageAr,
                  messageEn: state.messageEn,
                ),
                context: context,
              );
              // Navigate to reset password page
              Navigator.pushNamed(
                context,
                AppRoutes.resetPassword,
                arguments: {
                  'email': widget.email,
                  'resetToken': state.resetToken,
                },
              );
            } else if (state is VerifyPasswordResetOtpFailure) {
              print('❌ OTP Verification Failed:');
              print('  messageAr: ${state.messageAr}');
              print('  messageEn: ${state.messageEn}');

              final errorMessage = CustomSnackbar.getLocalizedMessage(
                context: context,
                messageAr: state.messageAr,
                messageEn: state.messageEn,
              );
              print('  Final message: $errorMessage');

              CustomSnackbar.showError(message: errorMessage, context: context);
            } else if (state is RequestPasswordResetOtpSuccess) {
              CustomSnackbar.showSuccess(
                message: CustomSnackbar.getLocalizedMessage(
                  context: context,
                  messageAr: 'تم إرسال رمز التحقق مرة أخرى',
                  messageEn: 'OTP sent again',
                ),
                context: context,
              );
            } else if (state is RequestPasswordResetOtpFailure) {
              CustomSnackbar.showError(
                message: CustomSnackbar.getLocalizedMessage(
                  context: context,
                  messageAr: state.messageAr,
                  messageEn: state.messageEn,
                ),
                context: context,
              );
            }
          },
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              final isLoading = state is AuthLoading;

              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.all(size.width * 0.06),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: size.height * 0.05),

                        // Header Icon
                        Container(
                          height: size.width * 0.25,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.verified_user,
                            size: size.width * 0.12,
                            color: AppColors.primary,
                          ),
                        ),

                        SizedBox(height: size.height * 0.04),

                        // Title
                        Text(
                          'التحقق من الرمز',
                          style: getBoldStyle(
                            fontSize: 24,
                            fontFamily: FontConstant.cairo,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: size.height * 0.02),

                        // Subtitle
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: getRegularStyle(
                              color: AppColors.grey,
                              fontSize: 16,
                              fontFamily: FontConstant.cairo,
                            ),
                            children: [
                              const TextSpan(
                                text: 'أدخل رمز التحقق المرسل إلى\n',
                              ),
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

                        SizedBox(height: size.height * 0.05),

                        // OTP Input
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: OtpPinField(
                            key: _otpPinFieldController,
                            autoFillEnable: true,
                            textInputAction: TextInputAction.done,
                            onSubmit: (text) {
                              setState(() {
                                _otpCode = text;
                              });
                              _verifyOtp();
                            },
                            onChange: (text) {
                              setState(() {
                                _otpCode = text;
                              });
                            },
                            onCodeChanged: (code) {
                              setState(() {
                                _otpCode = code;
                              });
                            },
                            maxLength: 6,
                            showCursor: true,
                            cursorColor: AppColors.primary,
                            upperChild: const SizedBox(height: 30),
                            middleChild: Container(
                              width: 2,
                              height: 16,
                              color: AppColors.primary.withValues(alpha: 0.3),
                            ),
                            showDefaultKeyboard: true,
                            fieldWidth: size.width * 0.12,
                            fieldHeight: 60,
                            otpPinFieldStyle: OtpPinFieldStyle(
                              defaultFieldBorderColor: AppColors.textSecondary
                                  .withValues(alpha: 0.3),
                              activeFieldBorderColor: AppColors.primary,
                              defaultFieldBackgroundColor:
                                  Theme.of(context).cardColor,
                              activeFieldBackgroundColor: AppColors.primary
                                  .withValues(alpha: 0.05),
                              filledFieldBorderColor: AppColors.primary,
                              filledFieldBackgroundColor: AppColors.primary
                                  .withValues(alpha: 0.1),
                              fieldBorderRadius: 12,
                              fieldBorderWidth: 2,
                              textStyle: getSemiBoldStyle(
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                                fontSize: 24,
                                fontFamily: FontConstant.cairo,
                              ),
                            ),
                            otpPinFieldDecoration: OtpPinFieldDecoration.custom,
                          ),
                        ),

                        SizedBox(height: size.height * 0.04),

                        // Verify Button
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            final isLoading = state is AuthLoading;

                            return SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                onPressed:
                                    isLoading || _otpCode.length < 6
                                        ? () {}
                                        : () => _verifyOtp(),
                                text: 'تحقق من الرمز',
                              ),
                            );
                          },
                        ),

                        SizedBox(height: size.height * 0.03),

                        // Resend OTP
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            final isLoading = state is AuthLoading;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'لم تستلم الرمز؟ ',
                                  style: getRegularStyle(
                                    fontFamily: FontConstant.cairo,
                                    color: AppColors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: isLoading ? null : _resendOtp,
                                  child: Text(
                                    'إعادة الإرسال',
                                    style: getSemiBoldStyle(
                                      fontFamily: FontConstant.cairo,
                                      color:
                                          isLoading
                                              ? AppColors.grey
                                              : AppColors.primary,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  // Progress Indicator Overlay
                  if (isLoading)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.3),
                        child: const Center(child: CustomProgressIndicator()),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
