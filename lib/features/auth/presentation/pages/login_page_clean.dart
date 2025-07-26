import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/core/widgets/custom_button.dart';
import 'package:derma_ai/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/animations/app_animations.dart';
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
  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Simulate login process
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
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
                _buildEmailField(),
                const SizedBox(height: 16),
                _buildPasswordField(),
                const SizedBox(height: 16),
                _buildRememberMeAndForgotPassword(),
                const SizedBox(height: 24),
                _buildLoginButton(),
                const SizedBox(height: 24),
                _buildDivider(),
                const SizedBox(height: 24),
                _buildSocialLogin(),
                const SizedBox(height: 24),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          
          ),
          child: Center(
            child:SvgPicture.asset(
              'assets/images/logo.svg',
              width: 80,
              height: 80,
            ),
          ),
        ).animate(effects: fadeInScaleUp(
          duration: 600.ms,
          begin: 0.5,
        )),
        const SizedBox(height: 32),
        Text(
          AppLocalizations.of(context)!.welcomeBack,
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
          AppLocalizations.of(context)!.signInToContinue,
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

  Widget _buildEmailField() {
    return CustomTextField(
      controller: _emailController,
      labelText: AppLocalizations.of(context)!.email,
      hintText: AppLocalizations.of(context)!.enterEmail,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return AppLocalizations.of(context)!.pleaseEnterEmail;
      //   }
      //   if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}\$').hasMatch(value)) {
      //     return AppLocalizations.of(context)!.pleaseEnterValidEmail;
      //   }
      //   return null;
      // },
    ).animate(effects: fadeInSlide(
      duration: 600.ms,
      delay: 400.ms,
      beginY: 0.2,
    ));
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      controller: _passwordController,
      labelText: AppLocalizations.of(context)!.password,
      hintText: AppLocalizations.of(context)!.enterPassword,
      prefixIcon: Icons.lock_outline,
      obscureText: true,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return AppLocalizations.of(context)!.pleaseEnterPassword;
      //   }
      //   if (value.length < 6) {
      //     return AppLocalizations.of(context)!.passwordMustBe;
      //   }
      //   return null;
      // },
    ).animate(effects: fadeInSlide(
      duration: 600.ms,
      delay: 500.ms,
      beginY: 0.2,
    ));
  }

  Widget _buildRememberMeAndForgotPassword() {
    return Row(
      children: [
        Checkbox(
          value: _rememberMe,
          onChanged: (value) {
            setState(() {
              _rememberMe = value ?? false;
            });
          },
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
    ).animate(effects: fadeIn(
      duration: 600.ms,
      delay: 600.ms,
    ));
  }

  Widget _buildLoginButton() {
    return Animate(
      effects: [
        FadeEffect(duration: 600.ms, delay: 700.ms),
        SlideEffect(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
          duration: 600.ms,
          delay: 700.ms,
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
          text: AppLocalizations.of(context)!.login,
          onPressed: _login,
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
      delay: 800.ms,
    ));
  }

  Widget _buildSocialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          icon: Icons.g_mobiledata,
          onPressed: () {
            // Login with Google
          },
        ),
        const SizedBox(width: 16),
        _buildSocialButton(
          icon: Icons.facebook,
          onPressed: () {
            // Login with Facebook
          },
        ),
        const SizedBox(width: 16),
        _buildSocialButton(
          icon: Icons.apple,
          onPressed: () {
            // Login with Apple
          },
        ),
      ],
    ).animate(effects: fadeIn(
      duration: 600.ms,
      delay: 900.ms,
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
    ).animate(effects: fadeIn(
      duration: 600.ms,
      delay: 1000.ms,
    ));
  }
}
