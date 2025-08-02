import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/utils/common/custom_progress_indicator.dart';
import '../../../../core/utils/common/custom_snackbar.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/helper/on_genrated_routes.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/validators/form_validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../widgets/social_auth_section.dart';
import 'otp_verification_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _acceptTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (!_formKey.currentState!.validate()) return;

    if (!_acceptTerms) {
      CustomSnackbar.showError(
        context: context,
        message: 'يرجى قبول الشروط والأحكام',
      );
      return;
    }

    context.read<AuthCubit>().register(
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      password: _passwordController.text,
      fullName: _nameController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Stack(
            children: [
              BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
          if (state is RegisterSuccess) {
            CustomSnackbar.showSuccess(
              context: context,
              message: CustomSnackbar.getLocalizedMessage(
                context: context,
                messageAr: state.entity.messageAr,
                messageEn: state.entity.messageEn,
              ),
            );
            // Navigate to OTP verification
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpVerificationPage(
                  userId: state.entity.userId!,
                  email: _emailController.text.trim(),
                  phone: _phoneController.text.trim(),
                ),
              ),
            );
          } else if (state is RegisterFailure) {
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  _buildHeader(),
                  const SizedBox(height: 40),
                  _buildNameField(),
                  const SizedBox(height: 16),
                  _buildEmailField(),
                  const SizedBox(height: 16),
                  _buildPhoneField(),
                  const SizedBox(height: 16),
                  _buildPasswordField(),
                  const SizedBox(height: 16),
                  _buildConfirmPasswordField(),
                  const SizedBox(height: 16),
                  _buildTermsAndConditions(),
                  const SizedBox(height: 24),
                  _buildSignUpButton(),
                  const SizedBox(height: 24),
                  const SocialAuthSection(),
                  const SizedBox(height: 32),
                  _buildSignInLink(),
                ],
              ),
            ),
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

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            Icons.person_add_outlined,
            size: 40,
            color: AppColors.primary,
          ),
        ).animate(effects: fadeInScaleUp(duration: 600.ms, begin: 0.5)),
        const SizedBox(height: 16),
        Text(
          'إنشاء حساب جديد',
          style: getBoldStyle(fontSize: 24, fontFamily: FontConstant.cairo),
          textAlign: TextAlign.center,
        ).animate(
          effects: fadeInSlide(duration: 600.ms, delay: 200.ms, beginY: 0.2),
        ),
        const SizedBox(height: 12),
        Text(
          'انضم إلينا وابدأ رحلتك في العناية بالبشرة',
          style: getRegularStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontFamily: FontConstant.cairo,
          ),
          textAlign: TextAlign.center,
        ).animate(
          effects: fadeInSlide(duration: 600.ms, delay: 300.ms, beginY: 0.2),
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return CustomTextField(
      controller: _nameController,
      labelText: AppLocalizations.of(context)!.fullName,
      hintText: AppLocalizations.of(context)!.enterFullName,
      prefixIcon: Icons.person_outline,
      validator: (value) => FormValidators.validateFullName(value, context),
    ).animate(
      effects: fadeInSlide(duration: 600.ms, delay: 400.ms, beginY: 0.2),
    );
  }

  Widget _buildEmailField() {
    return CustomTextField(
      controller: _emailController,
      labelText: AppLocalizations.of(context)!.email,
      hintText: AppLocalizations.of(context)!.enterEmail,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => FormValidators.validateEmail(value, context),
    ).animate(
      effects: fadeInSlide(duration: 600.ms, delay: 500.ms, beginY: 0.2),
    );
  }

  Widget _buildPhoneField() {
    return CustomTextField(
      controller: _phoneController,
      labelText: AppLocalizations.of(context)!.phoneNumber,
      hintText: AppLocalizations.of(context)!.enterPhoneNumber,
      prefixIcon: Icons.phone_outlined,
      keyboardType: TextInputType.phone,
      validator: (value) => FormValidators.validatePhoneNumber(value, context),
    ).animate(
      effects: fadeInSlide(duration: 600.ms, delay: 550.ms, beginY: 0.2),
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      controller: _passwordController,
      labelText: AppLocalizations.of(context)!.password,
      hintText: AppLocalizations.of(context)!.enterPassword,
      prefixIcon: Icons.lock_outline,
      obscureText: _obscurePassword,
      suffixIcon: Icons.visibility_off,
      validator: (value) => FormValidators.validatePassword(value, context),
    ).animate(
      effects: fadeInSlide(duration: 600.ms, delay: 600.ms, beginY: 0.2),
    );
  }

  Widget _buildConfirmPasswordField() {
    return CustomTextField(
      controller: _confirmPasswordController,
      labelText: AppLocalizations.of(context)!.confirmPassword,
      hintText: AppLocalizations.of(context)!.enterConfirmPassword,
      prefixIcon: Icons.lock_outline,
      obscureText: _obscureConfirmPassword,
      suffixIcon: Icons.visibility_off,
      validator: (value) => FormValidators.validatePasswordConfirmation(
        value,
        _passwordController.text,
        context,
      ),
    ).animate(
      effects: fadeInSlide(duration: 600.ms, delay: 700.ms, beginY: 0.2),
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: _acceptTerms,
          onChanged: (value) {
            setState(() {
              _acceptTerms = value ?? false;
            });
          },
          activeColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: RichText(
              text: TextSpan(
                style: getRegularStyle(fontFamily: FontConstant.cairo),
                children: [
                  TextSpan(
                    text: AppLocalizations.of(context)!.iAgreeToThe,
                    style: getMediumStyle(
                      fontFamily: FontConstant.cairo,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  TextSpan(
                    text: ' ${AppLocalizations.of(context)!.termsOfService}',
                    style: getSemiBoldStyle(
                      color: AppColors.primary,
                      fontFamily: FontConstant.cairo,
                    ),
                  ),
                  TextSpan(
                    text: ' ${AppLocalizations.of(context)!.and} ',
                    style: getMediumStyle(
                      fontFamily: FontConstant.cairo,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  TextSpan(
                    text: AppLocalizations.of(context)!.privacyPolicy,
                    style: getSemiBoldStyle(
                      color: AppColors.primary,
                      fontFamily: FontConstant.cairo,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ).animate(effects: fadeIn(duration: 600.ms, delay: 800.ms));
  }

  Widget _buildSignUpButton() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        
        return Animate(
          effects: [
            FadeEffect(duration: 600.ms, delay: 900.ms),
            SlideEffect(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
              duration: 600.ms,
              delay: 900.ms,
            ),
          ],
          child: CustomButton(
            text: 'إنشاء حساب',
            onPressed: isLoading ? () {} : () => _register(),
            type: ButtonType.primary,
            width: double.infinity,
            height: 56,
          ),
        );
      },
    );
  }

  Widget _buildSignInLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.alreadyHaveAccount,
          style: getRegularStyle(
            color: AppColors.textSecondary,
            fontFamily: FontConstant.cairo,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.login);
          },
          child: Text(
            AppLocalizations.of(context)!.login,
            style: getBoldStyle(
              color: AppColors.primary,
              fontFamily: FontConstant.cairo,
            ),
          ),
        ),
      ],
    ).animate(effects: fadeIn(duration: 600.ms, delay: 1200.ms));
  }
}
