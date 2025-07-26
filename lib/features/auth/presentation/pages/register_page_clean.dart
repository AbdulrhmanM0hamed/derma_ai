import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/core/widgets/custom_button.dart';
import 'package:derma_ai/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';

import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/utils/helper/on_genrated_routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _acceptTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.pleaseAcceptTerms),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Simulate registration process
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                _buildPasswordField(),
                const SizedBox(height: 16),
                _buildConfirmPasswordField(),
                const SizedBox(height: 16),
                _buildTermsAndConditions(),
                const SizedBox(height: 24),
                _buildRegisterButton(),
                const SizedBox(height: 24),
                _buildDivider(),
                const SizedBox(height: 24),
                _buildSocialLogin(),
                const SizedBox(height: 24),
                _buildSignInLink(),
              ],
            ),
          ),
        ),
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
          child: Center(
            child: Text(
              'D',
              style: getBoldStyle(
                color: AppColors.primary,
                fontSize: 36,
                fontFamily: FontConstant.cairo,
              ),
            ),
          ),
        ).animate(effects: fadeInScaleUp(
          duration: 600.ms,
          begin: 0.5,
        )),
        const SizedBox(height: 32),
        Text(
          AppLocalizations.of(context)!.createAccount,
          style: getBoldStyle(
            color: AppColors.textPrimary,
            fontSize: 32,
            fontFamily: FontConstant.cairo,
          ),
          textAlign: TextAlign.center,
        ).animate(effects: fadeInSlide(
          duration: 600.ms,
          delay: 200.ms,
          beginY: 0.2,
        )),
        const SizedBox(height: 12),
        Text(
          AppLocalizations.of(context)!.signUpToGetStarted,
          style: getRegularStyle(
            color: AppColors.textSecondary,
            fontSize: 16,
            fontFamily: FontConstant.cairo,
          ),
          textAlign: TextAlign.center,
        ).animate(effects: fadeInSlide(
          duration: 600.ms,
          delay: 300.ms,
          beginY: 0.2,
        )),
      ],
    );
  }

  Widget _buildNameField() {
    return CustomTextField(
      controller: _nameController,
      labelText: AppLocalizations.of(context)!.fullName,
      hintText: AppLocalizations.of(context)!.enterFullName,
      prefixIcon: Icons.person_outline,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.pleaseEnterName;
        }
        if (value.length < 2) {
          return 'Name must be at least 2 characters';
        }
        return null;
      },
    ).animate(effects: fadeInSlide(
      duration: 600.ms,
      delay: 400.ms,
      beginY: 0.2,
    ));
  }

  Widget _buildEmailField() {
    return CustomTextField(
      controller: _emailController,
      labelText: AppLocalizations.of(context)!.email,
      hintText: AppLocalizations.of(context)!.enterEmail,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.pleaseEnterEmail;
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$').hasMatch(value)) {
          return AppLocalizations.of(context)!.pleaseEnterValidEmail;
        }
        return null;
      },
    ).animate(effects: fadeInSlide(
      duration: 600.ms,
      delay: 500.ms,
      beginY: 0.2,
    ));
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      controller: _passwordController,
      labelText: AppLocalizations.of(context)!.password,
      hintText: AppLocalizations.of(context)!.enterPassword,
      prefixIcon: Icons.lock_outline,
      obscureText: _obscurePassword,
      suffixIcon: Icons.visibility_off,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.pleaseEnterPassword;
        }
        if (value.length < 6) {
          return AppLocalizations.of(context)!.passwordMustBe;
        }
        return null;
      },
    ).animate(effects: fadeInSlide(
      duration: 600.ms,
      delay: 600.ms,
      beginY: 0.2,
    ));
  }

  Widget _buildConfirmPasswordField() {
    return CustomTextField(
      controller: _confirmPasswordController,
      labelText: AppLocalizations.of(context)!.confirmPassword,
      hintText: 'Enter confirm password',
      prefixIcon: Icons.lock_outline,
      obscureText: _obscureConfirmPassword,
      suffixIcon: Icons.visibility_off,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.pleaseConfirmPassword;
        }
        if (value != _passwordController.text) {
          return AppLocalizations.of(context)!.passwordsDoNotMatch;
        }
        return null;
      },
    ).animate(effects: fadeInSlide(
      duration: 600.ms,
      delay: 700.ms,
      beginY: 0.2,
    ));
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: RichText(
              text: TextSpan(
                style: getRegularStyle(
                  color: AppColors.textSecondary,
                  fontFamily: FontConstant.cairo,
                ),
                children: [
                  TextSpan(
                    text: AppLocalizations.of(context)!.iAgreeToThe,
                  ),
                  TextSpan(
                    text: 'Terms and Conditions',
                    style: getSemiBoldStyle(
                      color: AppColors.primary,
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
                      fontFamily: FontConstant.cairo,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ).animate(effects: fadeIn(
      duration: 600.ms,
      delay: 800.ms,
    ));
  }

  Widget _buildRegisterButton() {
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: CustomButton(
          text: AppLocalizations.of(context)!.signUp,
          onPressed: _register,
          isLoading: _isLoading,
          type: ButtonType.primary,
          width: double.infinity,
          height: 56,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: AppColors.border),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            AppLocalizations.of(context)!.orContinueWith,
            style: getRegularStyle(
              color: AppColors.textSecondary,
              fontFamily: FontConstant.cairo,
            ),
          ),
        ),
        const Expanded(
          child: Divider(color: AppColors.border),
        ),
      ],
    ).animate(effects: fadeIn(
      duration: 600.ms,
      delay: 1000.ms,
    ));
  }

  Widget _buildSocialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          icon: Icons.g_mobiledata,
          onPressed: () {
            // Register with Google
          },
        ),
        const SizedBox(width: 16),
        _buildSocialButton(
          icon: Icons.facebook,
          onPressed: () {
            // Register with Facebook
          },
        ),
        const SizedBox(width: 16),
        _buildSocialButton(
          icon: Icons.apple,
          onPressed: () {
            // Register with Apple
          },
        ),
      ],
    ).animate(effects: fadeIn(
      duration: 600.ms,
      delay: 1100.ms,
    ));
  }

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: AppColors.textSecondary,
            size: 24,
          ),
        ),
      ),
    ).animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scaleXY(begin: 1, end: 1.05, duration: 2000.ms, curve: Curves.easeInOut);
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
    ).animate(effects: fadeIn(
      duration: 600.ms,
      delay: 1200.ms,
    ));
  }
}
