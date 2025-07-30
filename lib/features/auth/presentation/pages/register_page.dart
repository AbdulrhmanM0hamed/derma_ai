import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/core/widgets/custom_button.dart';
import 'package:derma_ai/core/widgets/custom_text_field.dart';
import 'package:derma_ai/features/auth/presentation/widgets/social_auth_section.dart';
import 'package:derma_ai/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:flutter_svg/svg.dart';
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
  final bool _obscurePassword = true;
  final bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() async {
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Registration failed: $e')));
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
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              width: 90,
              height: 90,
            ),
          ),
        ).animate(effects: fadeInScaleUp(duration: 600.ms, begin: 0.5)),
        const SizedBox(height: 16),
        Text(
          AppLocalizations.of(context)!.createAccount,
          style: getBoldStyle(fontSize: 24, fontFamily: FontConstant.cairo),
          textAlign: TextAlign.center,
        ).animate(
          effects: fadeInSlide(duration: 600.ms, delay: 200.ms, beginY: 0.2),
        ),
        const SizedBox(height: 12),
        Text(
          AppLocalizations.of(context)!.signUpToGetStarted,
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.pleaseEnterName;
        }
        if (value.length < 2) {
          return 'Name must be at least 2 characters';
        }
        return null;
      },
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.pleaseEnterEmail;
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$').hasMatch(value)) {
          return AppLocalizations.of(context)!.pleaseEnterValidEmail;
        }
        return null;
      },
    ).animate(
      effects: fadeInSlide(duration: 600.ms, delay: 500.ms, beginY: 0.2),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.pleaseEnterPassword;
        }
        if (value.length < 6) {
          return AppLocalizations.of(context)!.passwordMustBe;
        }
        return null;
      },
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.pleaseConfirmPassword;
        }
        if (value != _passwordController.text) {
          return AppLocalizations.of(context)!.passwordsDoNotMatch;
        }
        return null;
      },
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
        text: AppLocalizations.of(context)!.signUp,
        onPressed: _isLoading ? () {} : () => _register(),
        isLoading: _isLoading,
        type: ButtonType.primary,
        width: double.infinity,
        height: 56,
      ),
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
