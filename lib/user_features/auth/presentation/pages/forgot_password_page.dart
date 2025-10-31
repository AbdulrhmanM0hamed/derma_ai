import 'package:derma_ai/core/utils/common/custom_app_bar.dart';
import 'package:derma_ai/core/utils/common/custom_progress_indicator.dart';
import 'package:derma_ai/core/utils/helper/on_genrated_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/service_locatores.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/utils/widgets/custom_snackbar.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = sl<AuthCubit>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _authCubit.close();
    super.dispose();
  }

  void _requestOtp() {
    if (_formKey.currentState!.validate()) {
      _authCubit.requestPasswordResetOtp(
        email: _emailController.text.trim(),
        type: 'email',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authCubit,
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppLocalizations.of(context)!.resetPasswordTitle,
          centerTitle: true,
        ),
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            //    print('🔍 Forgot Password State: ${state.runtimeType}');

            if (state is RequestPasswordResetOtpSuccess) {
              //      print('✅ OTP Request Success - navigating to OTP page');
              CustomSnackbar.showSuccess(
                context: context,
                message: CustomSnackbar.getLocalizedMessage(
                  context: context,
                  messageAr: state.messageAr,
                  messageEn: state.messageEn,
                ),
              );
              Navigator.pushNamed(
                context,
                AppRoutes.passwordResetOtp,
                arguments: {'email': _emailController.text.trim()},
              );
            } else if (state is RequestPasswordResetOtpFailure) {
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
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),

                      // Header Icon
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.lock_reset,
                            color: AppColors.primary,
                            size: 40,
                          ),
                        ).animate(
                          effects: [
                            FadeEffect(duration: 600.ms),
                            ScaleEffect(
                              duration: 600.ms,
                              begin: const Offset(0.5, 0.5),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Title
                      Text(
                        AppLocalizations.of(context)!.forgotPasswordTitle,
                        style: getBoldStyle(
                          fontSize: 24,
                          fontFamily: FontConstant.cairo,
                        ),
                        textAlign: TextAlign.center,
                      ).animate(
                        effects: [
                          FadeEffect(duration: 600.ms, delay: 200.ms),
                          SlideEffect(
                            duration: 600.ms,
                            delay: 200.ms,
                            begin: const Offset(0, 0.2),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Subtitle
                      Text(
                        AppLocalizations.of(context)!.forgotPasswordSubtitle,
                        style: getRegularStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                          fontFamily: FontConstant.cairo,
                        ),
                        textAlign: TextAlign.center,
                      ).animate(
                        effects: [
                          FadeEffect(duration: 600.ms, delay: 400.ms),
                          SlideEffect(
                            duration: 600.ms,
                            delay: 400.ms,
                            begin: const Offset(0, 0.2),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // Email Field
                      CustomTextField(
                        controller: _emailController,
                        labelText: AppLocalizations.of(context)!.email,
                        hintText: AppLocalizations.of(context)!.enterEmail,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.pleaseEnterEmail;
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return AppLocalizations.of(
                              context,
                            )!.pleaseEnterValidEmail;
                          }
                          return null;
                        },
                      ).animate(
                        effects: [
                          FadeEffect(duration: 600.ms, delay: 600.ms),
                          SlideEffect(
                            duration: 600.ms,
                            delay: 600.ms,
                            begin: const Offset(0, 0.2),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Submit Button
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return CustomButton(
                            text:
                                AppLocalizations.of(
                                  context,
                                )!.sendVerificationCode,
                            onPressed: () => _requestOtp(),
                          );
                        },
                      ).animate(
                        effects: [
                          FadeEffect(duration: 600.ms, delay: 800.ms),
                          SlideEffect(
                            duration: 600.ms,
                            delay: 800.ms,
                            begin: const Offset(0, 0.2),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Back to Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.rememberPassword} ',
                            style: getRegularStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: getSemiBoldStyle(
                                color: AppColors.primary,
                                fontSize: 14,
                                fontFamily: FontConstant.cairo,
                              ),
                            ),
                          ),
                        ],
                      ).animate(
                        effects: [
                          FadeEffect(duration: 600.ms, delay: 1000.ms),
                          SlideEffect(
                            duration: 600.ms,
                            delay: 1000.ms,
                            begin: const Offset(0, 0.2),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Loading Overlay
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return Container(
                      color: Colors.black.withValues(alpha: 0.3),
                      child: const Center(child: CustomProgressIndicator()),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
