import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

import '../../../../core/utils/widgets/custom_snackbar.dart';
import '../../../../core/utils/common/custom_app_bar.dart';
import '../../../../core/utils/common/custom_progress_indicator.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/helper/on_genrated_routes.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/services/service_locatores.dart' as sl;
import '../../../../l10n/app_localizations.dart';
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
  State<DoctorOtpVerificationPage> createState() =>
      _DoctorOtpVerificationPageState();
}

class _DoctorOtpVerificationPageState extends State<DoctorOtpVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorAuthCubit>(
      create: (context) => sl.sl<DoctorAuthCubit>(),
      child: _DoctorOtpVerificationContent(
        userId: widget.userId,
        email: widget.email,
        phone: widget.phone,
        type: widget.type,
      ),
    );
  }
}

class _DoctorOtpVerificationContent extends StatefulWidget {
  final int userId;
  final String email;
  final String phone;
  final String type;

  const _DoctorOtpVerificationContent({
    required this.userId,
    required this.email,
    required this.phone,
    required this.type,
  });

  @override
  State<_DoctorOtpVerificationContent> createState() =>
      _DoctorOtpVerificationContentState();
}

class _DoctorOtpVerificationContentState
    extends State<_DoctorOtpVerificationContent> {
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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: l10n.doctorAccountVerification,
        centerTitle: true,
      ),
      body: BlocBuilder<DoctorAuthCubit, DoctorAuthState>(
        builder: (context, state) {
          return Stack(
            children: [
              BlocListener<DoctorAuthCubit, DoctorAuthState>(
                listener: (context, state) {
                  if (state is DoctorVerifyOtpSuccess) {
                    CustomSnackbar.showSuccess(
                      context: context,
                      message: l10n.otpVerificationSuccess,
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
                      message: l10n.otpResendSuccess,
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
                          Icons.medical_services_outlined,
                          size: 50,
                          color: AppColors.primary,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Title
                      Text(
                        l10n.verifyDoctorAccount,
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
                            ? "${l10n.otpSentToEmailDoctor} ${widget.email}"
                            : "${l10n.otpSentToEmailDoctor} ${widget.phone}",
                        style: getRegularStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                          fontFamily: FontConstant.cairo,
                        ),
                        textAlign: TextAlign.center,
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
                      BlocBuilder<DoctorAuthCubit, DoctorAuthState>(
                        builder: (context, state) {
                          final isLoading = state is DoctorAuthLoading;

                          return SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              onPressed:
                                  isLoading || _otpCode.length < 6
                                      ? () {}
                                      : () => _verifyOtp(),
                              width: double.infinity,
                              height: 56,
                              text: l10n.verifyCode,
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // Resend OTP
                      BlocBuilder<DoctorAuthCubit, DoctorAuthState>(
                        builder: (context, state) {
                          final isLoading = state is DoctorAuthLoading;
                          final canTap = !isLoading && _canResend;

                          return Column(
                            children: [
                              TextButton(
                                onPressed: canTap ? _resendOtp : null,
                                child: Text(
                                  _canResend
                                      ? l10n.resendOtp
                                      : '${l10n.resendOtp} ($_resendCountdown)',
                                  style: getSemiBoldStyle(
                                    color:
                                        canTap
                                            ? AppColors.primary
                                            : AppColors.grey,
                                    fontSize: 14,
                                    fontFamily: FontConstant.cairo,
                                  ),
                                ),
                              ),
                              if (!_canResend)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    '${l10n.canResendIn} $_resendCountdown ${l10n.seconds}',
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
                        l10n.codeValidForMinutes,
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
              if (state is DoctorAuthLoading)
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
}
