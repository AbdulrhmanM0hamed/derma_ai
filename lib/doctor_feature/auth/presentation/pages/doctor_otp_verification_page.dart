import 'package:derma_ai/core/utils/common/custom_app_bar.dart';
import 'package:derma_ai/core/utils/helper/on_genrated_routes.dart';
import 'package:derma_ai/core/widgets/custom_button.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

import '../../../../core/utils/widgets/custom_snackbar.dart';
import '../../../../core/utils/common/custom_progress_indicator.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/services/service_locatores.dart' as sl;
import '../bloc/doctor_auth_cubit.dart';
import '../bloc/doctor_auth_state.dart';

class DoctorOtpVerificationPage extends StatefulWidget {
  final int userId;
  final String email;
  final String phone;
  final String type;

  const DoctorOtpVerificationPage({
    super.key,
    required this.userId,
    required this.email,
    required this.phone,
    this.type = 'email',
  });

  @override
  State<DoctorOtpVerificationPage> createState() => _DoctorOtpVerificationPageState();
}

class _DoctorOtpVerificationPageState extends State<DoctorOtpVerificationPage> {
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
    _isEmailVerification = widget.type == 'email';
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
      _resendCountdown = 60;
    });
    
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendCountdown > 0) {
          _resendCountdown--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  void _verifyOtp() {
    if (_otpCode.length == 6) {
      context.read<DoctorAuthCubit>().verifyOtp(
        userId: widget.userId,
        otp: _otpCode,
        type: widget.type,
      );
    } else {
      CustomSnackbar.showError(
        context: context,
        message: "يرجى إدخال رمز التحقق صحيح",
      );
    }
  }

  void _resendOtp() {
    if (_canResend) {
      context.read<DoctorAuthCubit>().resendOtp(
        userId: widget.userId,
        type: widget.type,
      );
      _startResendTimer();
    }
  }

  void _switchVerificationMethod() {
    setState(() {
      _isEmailVerification = !_isEmailVerification;
      _otpCode = '';
      _otpPinFieldController.currentState?.clearOtp();
    });
    
    final newType = _isEmailVerification ? 'email' : 'phone';
    context.read<DoctorAuthCubit>().resendOtp(
      userId: widget.userId,
      type: newType,
    );
    _startResendTimer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorAuthCubit>(
      create: (context) => sl.sl<DoctorAuthCubit>(),
      child: BlocListener<DoctorAuthCubit, DoctorAuthState>(
      listener: (context, state) {
        if (state is DoctorVerifyOtpSuccess) {
          CustomSnackbar.showSuccess(
            context: context,
            message: "تم التحقق من الحساب بنجاح",
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.doctorNavigation,
            (route) => false,
          );
        } else if (state is DoctorVerifyOtpFailure) {
          CustomSnackbar.showError(
            context: context,
            message: CustomSnackbar.getLocalizedMessage(
              context: context,
              messageAr: state.messageAr,
              messageEn: state.messageEn,
            ),
          );
        } else if (state is DoctorResendOtpSuccess) {
          CustomSnackbar.showSuccess(
            context: context,
            message: "تم إرسال رمز التحقق بنجاح",
          );
        } else if (state is DoctorResendOtpFailure) {
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
      child: Scaffold(
        appBar: CustomAppBar(
          title: "تأكيد الحساب",
        ),
        body: BlocBuilder<DoctorAuthCubit, DoctorAuthState>(
          builder: (context, state) {
            final isLoading = state is DoctorAuthLoading;
            
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      
                      // Header
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.medical_services,
                                size: 40,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              "تأكيد حسابك",
                              style: getBoldStyle(
                                color: AppColors.textPrimary,
                                fontSize: 24,
                                fontFamily: FontConstant.cairo,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _isEmailVerification
                                  ? "تم إرسال رمز التحقق إلى ${widget.email}"
                                  : "تم إرسال رمز التحقق إلى ${widget.phone}",
                              style: getRegularStyle(
                                color: AppColors.textSecondary,
                                fontSize: 16,
                                fontFamily: FontConstant.cairo,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 48),
                      
                      // OTP Input
                      Text(
                        "أدخل رمز التحقق",
                        style: getMediumStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontFamily: FontConstant.cairo,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      OtpPinField(
                        key: _otpPinFieldController,
                        autoFillEnable: false,
                        textInputAction: TextInputAction.done,
                        onSubmit: (text) {
                          setState(() {
                            _otpCode = text;
                          });
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
                        otpPinFieldStyle: OtpPinFieldStyle(
                          defaultFieldBorderColor: Colors.grey.shade300,
                          activeFieldBorderColor: AppColors.primary,
                          defaultFieldBackgroundColor: Colors.transparent,
                          activeFieldBackgroundColor: Colors.transparent,
                          filledFieldBackgroundColor: AppColors.primary.withOpacity(0.1),
                          filledFieldBorderColor: AppColors.primary,
                          fieldBorderRadius: 12,
                          fieldBorderWidth: 2,
                          textStyle: getBoldStyle(
                            color: AppColors.textPrimary,
                            fontSize: 20,
                            fontFamily: FontConstant.cairo,
                          ),
                        ),
                        maxLength: 6,
                        showCursor: true,
                        cursorColor: AppColors.primary,
                        upperChild: const Column(
                          children: [
                            SizedBox(height: 30),
                            Icon(Icons.dialpad_rounded, size: 30),
                            SizedBox(height: 30),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Verify Button
                      CustomButton(
                        text: "تأكيد",
                        onPressed: _otpCode.length == 6 && !isLoading ? _verifyOtp : null,
                        isLoading: isLoading,
                        backgroundColor: AppColors.primary,
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Resend OTP
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "لم تستلم الرمز؟",
                              style: getRegularStyle(
                                color: AppColors.textSecondary,
                                fontSize: 14,
                                fontFamily: FontConstant.cairo,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: _canResend && !isLoading ? _resendOtp : null,
                              child: Text(
                                _canResend
                                    ? "إعادة الإرسال"
                                    : 'إعادة الإرسال خلال $_resendCountdown ثانية',
                                style: getMediumStyle(
                                  color: _canResend ? AppColors.primary : AppColors.textSecondary,
                                  fontSize: 14,
                                  fontFamily: FontConstant.cairo,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Switch verification method
                      if (widget.email.isNotEmpty && widget.phone.isNotEmpty)
                        Center(
                          child: TextButton.icon(
                            onPressed: !isLoading ? _switchVerificationMethod : null,
                            icon: Icon(
                              _isEmailVerification ? Icons.phone : Icons.email,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            label: Text(
                              _isEmailVerification
                                  ? "التحقق عبر الهاتف"
                                  : "التحقق عبر البريد الإلكتروني",
                              style: getMediumStyle(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontFamily: FontConstant.cairo,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                
                if (isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const Center(
                      child: CustomProgressIndicator(),
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
