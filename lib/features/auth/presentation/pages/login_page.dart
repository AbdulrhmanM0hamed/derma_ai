import 'package:derma_ai/core/utils/animations/app_animations.dart';
import 'package:derma_ai/core/utils/widgets/custom_snackbar.dart';
import 'package:derma_ai/core/utils/validators/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/common/custom_progress_indicator.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/helper/on_genrated_routes.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/services/service_locatores.dart';
import '../../../../core/services/token_storage_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import 'forgot_password_page.dart';
import '../widgets/social_auth_section.dart';

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

  @override
  void initState() {
    super.initState();
    _loadRememberedEmail();
  }

  void _loadRememberedEmail() async {
    try {
      final storage = sl<TokenStorageService>();
      final isRememberEnabled = storage.isRememberMeEnabled;
      final rememberedEmail = storage.rememberedEmail;
      final rememberedPassword = storage.rememberedPassword;
      
      if (isRememberEnabled) {
        setState(() {
          if (rememberedEmail != null && rememberedEmail.isNotEmpty) {
            _emailController.text = rememberedEmail;
          }
          if (rememberedPassword != null && rememberedPassword.isNotEmpty) {
            _passwordController.text = rememberedPassword;
          }
          _rememberMe = true;
        });
      
      } 
    } catch (e) {
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Save remember me preference
        final email = _emailController.text.trim();
        final password = _passwordController.text.trim();
        
        await sl<TokenStorageService>().setRememberMe(
          remember: _rememberMe,
          email: _rememberMe ? email : null,
          password: _rememberMe ? password : null,
        );
        
        
        context.read<AuthCubit>().login(
          email: email,
          password: _passwordController.text.trim(),
        );
      } catch (e) {
        // Continue with login even if remember me fails
        context.read<AuthCubit>().login(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
    }
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
                  if (state is LoginSuccess) {
                    CustomSnackbar.showSuccess(
                      context: context,
                      message: CustomSnackbar.getLocalizedMessage(
                        context: context,
                        messageAr: state.entity.messageAr,
                        messageEn: state.entity.messageEn,
                      ),
                    );
                    // Navigate to main page
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.mainNavigationPage,
                    );
                  } else if (state is LoginFailure) {
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
                          const SizedBox(height: 12),
                          _buildSignUpLink(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Progress Indicator Overlay
              if (state is AuthLoading)
                const CustomProgressIndicator(),
            ],
          );
        },
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
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              width: 80,
              height: 80,
            ),
          ),
        ).animate(effects: fadeInScaleUp(duration: 600.ms, begin: 0.5)),
        const SizedBox(height: 16),
        Text(
          AppLocalizations.of(context)!.welcomeBack,
          style: getBoldStyle(fontSize: 24, fontFamily: FontConstant.cairo),
          textAlign: TextAlign.center,
        ).animate(
          effects: fadeInSlide(duration: 600.ms, delay: 200.ms, beginY: 0.2),
        ),
        const SizedBox(height: 12),
        Text(
          AppLocalizations.of(context)!.signInToContinue,
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

  Widget _buildEmailField() {
    return CustomTextField(
      controller: _emailController,
      labelText: AppLocalizations.of(context)!.email,
      hintText: AppLocalizations.of(context)!.enterEmail,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => FormValidators.validateEmail(value, context),
    ).animate(effects: fadeInSlide(duration: 600.ms, delay: 400.ms, beginY: 0.2));
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
      validator: (value) => FormValidators.validatePassword(value, context),
    ).animate(effects: fadeInSlide(duration: 600.ms, delay: 500.ms, beginY: 0.2));
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
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
            Navigator.pushNamed(
              context,
              AppRoutes.forgotPassword,
            );
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
    ).animate(effects: fadeInSlide(duration: 600.ms, delay: 600.ms, beginY: 0.2));
  }

  Widget _buildLoginButton() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        
        return Animate(
          effects: [
            FadeEffect(delay: 700.ms, duration: 600.ms),
            SlideEffect(
              delay: 700.ms,
              duration: 600.ms,
              begin: const Offset(0, 0.2),
              end: Offset.zero,
            ),
          ],
          child: CustomButton(
            text: AppLocalizations.of(context)!.login,
            onPressed: isLoading ? () {} : () => _login(),
            type: ButtonType.primary,
            width: double.infinity,
          ),
        );
      },
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
    ).animate(effects: fadeInSlide(duration: 600.ms, delay: 1000.ms, beginY: 0.2));
  }
}
