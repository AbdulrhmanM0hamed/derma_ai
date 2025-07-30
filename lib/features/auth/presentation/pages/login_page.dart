import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/widgets/custom_button.dart';
import 'package:derma_ai/core/widgets/custom_text_field.dart';
import 'package:derma_ai/features/auth/presentation/widgets/social_auth_section.dart';
import 'package:derma_ai/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/helper/on_genrated_routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        // Simulate login process
        await Future.delayed(const Duration(seconds: 2));

        if (mounted) {
          Navigator.pushReplacementNamed(context, AppRoutes.mainNavigationPage);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Login failed: $e')));
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
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
                _buildHeader(),
                const SizedBox(height: 32),
                _buildEmailField(),
                const SizedBox(height: 16),
                _buildPasswordField(),
                const SizedBox(height: 16),
                _buildRememberMeAndForgotPassword(),
                const SizedBox(height: 32),
                _buildLoginButton(),
                const SizedBox(height: 24),
                const SocialAuthSection(),
                const SizedBox(height: 32),
                _buildSignUpLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha:0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              width: 80,
              height: 80,
            ),
          ),
        ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.5, 0.5)),
        const SizedBox(height: 32),
        Text(
          AppLocalizations.of(context)!.welcomeBack,
          style: getBoldStyle(
            fontSize: 24,
            fontFamily: FontConstant.cairo,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideY(begin: 0.2, delay: 200.ms, duration: 600.ms),
        const SizedBox(height: 12),
        Text(
          AppLocalizations.of(context)!.signInToContinue,
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 300.ms, duration: 600.ms).slideY(begin: 0.2, delay: 300.ms, duration: 600.ms),
      ],
    );
  }

  Widget _buildEmailField() {
    return CustomTextField(
      controller: _emailController,
      labelText: AppLocalizations.of(context)!.email,
      hintText: AppLocalizations.of(context)!.enterEmail,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please enter your email';
      //   }
      //   if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      //     return 'Please enter a valid email';
      //   }
      //   return null;
      // },
    ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideY(begin: 0.2, delay: 400.ms, duration: 600.ms);
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      controller: _passwordController,
      labelText: AppLocalizations.of(context)!.password,
      hintText: AppLocalizations.of(context)!.enterPassword,
      prefixIcon: Icons.lock_outline,
      obscureText: _obscurePassword,
      suffixIcon: _obscurePassword ? Icons.visibility_off : Icons.visibility,
      onSuffixIconTap: () {
        setState(() {
          _obscurePassword = !_obscurePassword;
        });
      },
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please enter your password';
      //   }
      //   if (value.length < 6) {
      //     return 'Password must be at least 6 characters';
      //   }
      //   return null;
      // },
    ).animate().fadeIn(delay: 500.ms, duration: 600.ms).slideY(begin: 0.2, delay: 500.ms, duration: 600.ms);
  }

  Widget _buildRememberMeAndForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
              activeColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
            Text(
              AppLocalizations.of(context)!.rememberMe,
              style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            // Navigate to forgot password page
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
    ).animate().fadeIn(delay: 600.ms, duration: 600.ms);
  }

  Widget _buildLoginButton() {
    return Animate(
      effects: [FadeEffect(delay: 700.ms, duration: 600.ms)],
      child: CustomButton(
        text: AppLocalizations.of(context)!.login,
        onPressed: _isLoading ? () {} : () => _login(),
        isLoading: _isLoading,
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.dontHaveAccount,
          style: getRegularStyle(
            color: AppColors.textSecondary,
            fontFamily: FontConstant.cairo,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.register);
          },
          child: Text(
            AppLocalizations.of(context)!.signUp,
            style: getBoldStyle(
              color: AppColors.primary,
              fontFamily: FontConstant.cairo,
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 1000.ms, duration: 600.ms);
  }
}
