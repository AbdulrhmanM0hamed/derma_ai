import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/validators/form_validators.dart';
import '../../../../core/widgets/custom_text_field.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool acceptTerms;
  final ValueChanged<bool> onAcceptTermsChanged;

  const RegisterForm({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.acceptTerms,
    required this.onAcceptTermsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFullNameField(context),
        const SizedBox(height: 16),
        _buildEmailField(context),
        const SizedBox(height: 16),
        _buildPasswordField(context),
        const SizedBox(height: 16),
        _buildConfirmPasswordField(context),
        const SizedBox(height: 24),
        _buildTermsAndConditions(context),
      ],
    );
  }

  Widget _buildFullNameField(BuildContext context) {
    return Animate(
      effects: fadeInSlide(
        duration: 300.ms,
        delay: 200.ms,
        beginY: 0.2,
      ),
      child: CustomTextField(
        controller: fullNameController,
        labelText: AppLocalizations.of(context)!.fullName,
        hintText: AppLocalizations.of(context)!.enterFullName,
        prefixIcon: Icons.person_outline,
        validator: (value) => FormValidators.validateFullName(value, context),
      ),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return Animate(
      effects: fadeInSlide(
        duration: 300.ms,
        delay: 300.ms,
        beginY: 0.2,
      ),
      child: CustomTextField(
        controller: emailController,
        labelText: AppLocalizations.of(context)!.email,
        hintText: AppLocalizations.of(context)!.enterEmail,
        prefixIcon: Icons.email_outlined,
        keyboardType: TextInputType.emailAddress,
        validator: (value) => FormValidators.validateEmail(value, context),
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return Animate(
      effects: fadeInSlide(
        duration: 300.ms,
        delay: 400.ms,
        beginY: 0.2,
      ),
      child: CustomTextField(
        controller: passwordController,
        labelText: AppLocalizations.of(context)!.password,
        hintText: AppLocalizations.of(context)!.enterPassword,
        prefixIcon: Icons.lock_outline,
        obscureText: true,
        validator: (value) => FormValidators.validatePassword(value, context),
      ),
    );
  }

  Widget _buildConfirmPasswordField(BuildContext context) {
    return Animate(
      effects: fadeInSlide(
        duration: 300.ms,
        delay: 500.ms,
        beginY: 0.2,
      ),
      child: CustomTextField(
        controller: confirmPasswordController,
        labelText: AppLocalizations.of(context)!.confirmPassword,
        hintText: AppLocalizations.of(context)!.confirmYourPassword,
        prefixIcon: Icons.lock_outline,
        obscureText: true,
        validator: (value) => FormValidators.validatePasswordConfirmation(
          value,
          passwordController.text,
          context,
        ),
      ),
    );
  }

  Widget _buildTermsAndConditions(BuildContext context) {
    return Animate(
      effects: fadeIn(
        duration: 300.ms,
        delay: 600.ms,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: acceptTerms,
            onChanged: (value) => onAcceptTermsChanged(value ?? false),
            activeColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: AppLocalizations.of(context)!.iAgreeToThe,
                style: getRegularStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  fontFamily: FontConstant.cairo,
                ),
                children: [
                  TextSpan(
                    text: AppLocalizations.of(context)!.termsOfService,
                    style: getSemiBoldStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontFamily: FontConstant.cairo,
                    ),
                  ),
                  TextSpan(
                    text: ' ${AppLocalizations.of(context)!.and} ',
                  ),
                  TextSpan(
                    text: AppLocalizations.of(context)!.privacyPolicy,
                    style: getSemiBoldStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontFamily: FontConstant.cairo,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
