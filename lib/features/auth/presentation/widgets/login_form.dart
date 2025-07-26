import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/validators/form_validators.dart';
import '../../../../core/widgets/custom_text_field.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final ValueChanged<bool> onRememberMeChanged;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.rememberMe,
    required this.onRememberMeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildEmailField(context),
        const SizedBox(height: 16),
        _buildPasswordField(context),
        const SizedBox(height: 16),
        _buildRememberMeAndForgotPassword(context),
      ],
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!.pleaseEnterPassword;
          }
          return null;
        },
      ),
    );
  }

  Widget _buildRememberMeAndForgotPassword(BuildContext context) {
    return Animate(
      effects: fadeIn(
        duration: 300.ms,
        delay: 500.ms,
      ),
      child: Row(
        children: [
          Checkbox(
            value: rememberMe,
            onChanged: (value) => onRememberMeChanged(value ?? false),
            activeColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Text(
            AppLocalizations.of(context)!.rememberMe,
            style: getRegularStyle(
              color: AppColors.textPrimary,
              fontFamily: FontConstant.cairo,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              // Navigate to forgot password
            },
            child: Text(
              AppLocalizations.of(context)!.forgotPassword,
              style: getSemiBoldStyle(
                color: AppColors.primary,
                fontFamily: FontConstant.cairo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
