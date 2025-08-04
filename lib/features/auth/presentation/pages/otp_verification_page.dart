import 'package:derma_ai/core/utils/common/custom_app_bar.dart';

import 'package:derma_ai/core/utils/helper/on_genrated_routes.dart';
import 'package:derma_ai/core/widgets/custom_button.dart';
import 'package:derma_ai/l10n/app_localizations.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

import '../../../../core/utils/widgets/custom_snackbar.dart';
import '../../../../core/utils/common/custom_progress_indicator.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';

class OtpVerificationPage extends StatefulWidget {
  final int userId;
  final String email;
  final String phone;

  const OtpVerificationPage({
    super.key,
    required this.userId,
    required this.email,
    required this.phone,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
  String _otpCode = '';
  bool _isEmailVerification = true;
  
  // Timer variables
  Timer? _resendTimer;
  int _resendCountdown = 0;
  bool _canResend = true;
  
  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }
  
  @override
  void dispose() {
    _resendTimer?.cancel();
    super.dispose();
  }
  
  void _startResendTimer() {
    setState(() {
      _canResend = false;
      _resendCountdown = 60; // 60 seconds countdown
    });
    
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _resendCountdown--;
      });
      
      if (_resendCountdown <= 0) {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.accountVerification,
        centerTitle: true,
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Stack(
            children: [
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is VerifyOtpSuccess) {
                    CustomSnackbar.showSuccess(
                      context: context,
                      message: CustomSnackbar.getLocalizedMessage(
                        context: context,
                        messageAr: state.entity.messageAr,
                        messageEn: state.entity.messageEn,
                      ),
                    );
                    // Navigate to main app or next step
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.mainNavigationPage,
                    );
                  } else if (state is VerifyOtpFailure) {
                    CustomSnackbar.showError(
                      context: context,
                      message: CustomSnackbar.getLocalizedMessage(
                        context: context,
                        messageAr: state.messageAr,
                        messageEn: state.messageEn,
                      ),
                    );
                  } else if (state is ResendOtpSuccess) {
                    CustomSnackbar.showSuccess(
                      context: context,
                      message: CustomSnackbar.getLocalizedMessage(
                        context: context,
                        messageAr: state.messageAr,
                        messageEn: state.messageEn,
                      ),
                    );
                  } else if (state is ResendOtpFailure) {
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
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.05),

                      // Header Icon
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.security_outlined,
                          size: 50,
                          color: AppColors.primary,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Title
                      Text(
                        AppLocalizations.of(context)!.verifyOtpCode,
                        style: getBoldStyle(
                          fontSize: 24,
                          fontFamily: FontConstant.cairo,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 16),

                      // Description
                      Text(
                        _isEmailVerification
                            ? '${AppLocalizations.of(context)!.otpSentToEmail}: ${widget.email}'
                            : '${AppLocalizations.of(context)!.otpSentToPhone}: ${widget.phone}',
                        style: getRegularStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                          fontFamily: FontConstant.cairo,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 40),

                      // Verification Type Toggle
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isEmailVerification = true;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        _isEmailVerification
                                            ? AppColors.primary
                                            : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.email_outlined,
                                        size: 20,
                                        color:
                                            _isEmailVerification
                                                ? Colors.white
                                                : AppColors.textSecondary,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        AppLocalizations.of(context)!.emailVerification,
                                        style: getSemiBoldStyle(
                                          color:
                                              _isEmailVerification
                                                  ? Colors.white
                                                  : AppColors.textSecondary,
                                          fontSize: 14,
                                          fontFamily: FontConstant.cairo,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isEmailVerification = false;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        !_isEmailVerification
                                            ? AppColors.primary
                                            : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.phone_outlined,
                                        size: 20,
                                        color:
                                            !_isEmailVerification
                                                ? Colors.white
                                                : AppColors.textSecondary,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        AppLocalizations.of(context)!.phoneVerification,
                                        style: getSemiBoldStyle(
                                          color:
                                              !_isEmailVerification
                                                  ? Colors.white
                                                  : AppColors.textSecondary,
                                          fontSize: 14,
                                          fontFamily: FontConstant.cairo,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // OTP Input Field
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
                          fieldWidth: screenWidth * 0.12,
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
                          ),
                          otpPinFieldDecoration: OtpPinFieldDecoration.custom,
                        ),
                      ),

                      const SizedBox(height: 40),

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

                              width: double.infinity,
                              height: 56,
                              text: AppLocalizations.of(context)!.verifyCode,
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // Resend OTP
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          final isLoading = state is AuthLoading;
                          final canTap = !isLoading && _canResend;

                          return Column(
                            children: [
                              TextButton(
                                onPressed: canTap ? _resendOtp : null,
                                child: Text(
                                  _canResend
                                      ? AppLocalizations.of(context)!.resendCode
                                      : '${AppLocalizations.of(context)!.resendCode} ($_resendCountdown)',
                                  style: getSemiBoldStyle(
                                    color: canTap ? AppColors.primary : AppColors.grey,
                                    fontSize: 14,
                                    fontFamily: FontConstant.cairo,
                                  ),
                                ),
                              ),
                              if (!_canResend)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    Localizations.localeOf(context).languageCode == 'ar'
                                        ? 'يمكنك إعادة الإرسال خلال $_resendCountdown ثانية'
                                        : 'You can resend in $_resendCountdown seconds',
                                    style: getRegularStyle(
                                      fontFamily: FontConstant.cairo,
                                      color: AppColors.grey,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      // Help Text
                      Text(
                        AppLocalizations.of(context)!.codeValidFor5Minutes,
                        style: getRegularStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontFamily: FontConstant.cairo,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              // Progress Indicator Overlay
              if (state is AuthLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: const CustomProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }

  void _verifyOtp() {
    if (_otpCode.length == 6) {
      context.read<AuthCubit>().verifyOtp(
        userId: widget.userId,
        otp: _otpCode,
        type: _isEmailVerification ? 'email' : 'phone',
      );
    }
  }

  void _resendOtp() {
    if (_canResend) {
      context.read<AuthCubit>().resendOtp(
        userId: widget.userId,
        type: _isEmailVerification ? 'email' : 'phone',
      );
      _startResendTimer(); // Start countdown again
    }
  }
}
