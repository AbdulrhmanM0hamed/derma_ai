import 'package:derma_ai/core/utils/validators/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../services/service_locatores.dart';
import '../../../services/token_storage_service.dart';
import '../../../utils/constant/font_manger.dart';
import '../../../utils/constant/styles_manger.dart';
import '../../../utils/helper/on_genrated_routes.dart';
import '../../../utils/theme/app_colors.dart';
import '../../../utils/widgets/custom_snackbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../../user_features/auth/presentation/bloc/auth_cubit.dart';
import '../../../../user_features/auth/presentation/bloc/auth_state.dart';
import '../../../../doctor_feature/auth/presentation/bloc/doctor_auth_cubit.dart';
import '../../../../doctor_feature/auth/presentation/bloc/doctor_auth_state.dart';

enum UserType { user, doctor }

class UnifiedLoginPage extends StatefulWidget {
  const UnifiedLoginPage({super.key});

  @override
  State<UnifiedLoginPage> createState() => _UnifiedLoginPageState();
}

class _UnifiedLoginPageState extends State<UnifiedLoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;
  UserType _selectedUserType = UserType.user;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _loadRememberedData();
  }

  void _loadRememberedData() async {
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
      // Handle error silently or show a message if needed
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleUserTypeChange(UserType type) {
    if (type != _selectedUserType) {
      setState(() {
        _selectedUserType = type;
      });

      if (type == UserType.doctor) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
      
      // لا نقوم بمسح البيانات المدخلة عند التبديل
      // البيانات ستبقى في الـ TextEditingController
    }
  }

  void _handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        // Save remember me preference
        final email = _emailController.text.trim();
        final password = _passwordController.text.trim();
        
        await sl<TokenStorageService>().setRememberMe(
          remember: _rememberMe,
          email: _rememberMe ? email : null,
        );

        // Call appropriate login method based on user type
        if (_selectedUserType == UserType.user) {
          // Use user endpoints
          context.read<AuthCubit>().login(
            email: email,
            password: password,
          );
        } else {
          // Use doctor endpoints
          context.read<DoctorAuthCubit>().login(
            email: email,
            password: password,
          );
        }
      } catch (e) {
        CustomSnackbar.showError(
          context: context,
          message: CustomSnackbar.getLocalizedMessage(
            context: context,
            messageAr: AppLocalizations.of(context)!.rememberMeError,
            messageEn: AppLocalizations.of(context)!.rememberMeError,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<AuthCubit>()),
          BlocProvider(create: (context) => sl<DoctorAuthCubit>()),
        ],
        child: Builder(
          builder:
              (context) => MultiBlocListener(
                listeners: [
                  // User Auth Listener
                  BlocListener<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        CustomSnackbar.showSuccess(
                          context: context,
                          message: CustomSnackbar.getLocalizedMessage(
                            context: context,
                            messageAr: state.messageAr,
                            messageEn: state.messageEn,
                          ),
                        );
                        // Navigate to main navigation page
                        Navigator.pushReplacementNamed(context, AppRoutes.mainNavigationPage);
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
                  ),
                  // Doctor Auth Listener
                  BlocListener<DoctorAuthCubit, DoctorAuthState>(
                    listener: (context, state) {
                      if (state is DoctorLoginSuccess) {
                        CustomSnackbar.showSuccess(
                          context: context,
                          message: CustomSnackbar.getLocalizedMessage(
                            context: context,
                            messageAr: state.messageAr,
                            messageEn: state.messageEn,
                          ),
                        );
                        // Navigate to main navigation page (doctors will have different navigation logic)
                        Navigator.pushReplacementNamed(context, AppRoutes.mainNavigationPage);
                      } else if (state is DoctorLoginFailure) {
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
                  ),
                ],
                child: Container(
                  decoration: BoxDecoration(
                    
                  ),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          _buildHeader(),
                          const SizedBox(height: 32),
                          _buildUserTypeSelector(),
                          const SizedBox(height: 16),
                          _buildLoginForm(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.bounceOut,
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color:
                _selectedUserType == UserType.doctor
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color:
                    _selectedUserType == UserType.doctor
                        ? AppColors.primary.withValues(alpha: 0.2)
                        : AppColors.primary.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 8),
                spreadRadius: 2,
              ),
            ],
          ),
          child: SvgPicture.asset(
            _selectedUserType == UserType.doctor
                ? 'assets/images/doctor_login.svg'
                : 'assets/images/user_login.svg',
            width: 60,
            height: 60,
         
          ),
        ),
        const SizedBox(height: 24),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          style: getBoldStyle(
            color:
                _selectedUserType == UserType.doctor
                    ? AppColors.black
                    : AppColors.textPrimary,
            fontSize: 24,
            fontFamily: FontConstant.cairo,
          ),
          child: Text(
            _selectedUserType == UserType.doctor
                ? AppLocalizations.of(context)!.login
                : AppLocalizations.of(context)!.login,
          ),
        ),
        const SizedBox(height: 12),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          style: getRegularStyle(
            color:
                _selectedUserType == UserType.doctor
                    ? AppColors.textSecondary
                    : AppColors.textSecondary,
            fontSize: 15,
            fontFamily: FontConstant.cairo,
          ),
          child: Text(
            _selectedUserType == UserType.doctor
                ? AppLocalizations.of(context)!.welcomeBack
                : AppLocalizations.of(context)!.welcomeBack,
          ),
        ),
      ],
    );
  }

  Widget _buildUserTypeSelector() {
    return Container(
      height: 56,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppColors.secondary.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Animated background slider
          AnimatedPositioned(
            duration: const Duration(milliseconds: 5000),
            curve: Curves.easeInOutCubic,
            right: _selectedUserType == UserType.user ? 4 : null,
            left: _selectedUserType == UserType.doctor ? 4 : null,
            top: 4,
            bottom: 4,
            child: Container(
              width: (MediaQuery.of(context).size.width - 48 - 40) / 2,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          // User and Doctor buttons
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _handleUserTypeChange(UserType.user),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                          child:Icon(
                            Icons.person_outline,
                            size: 20,
                            color: _selectedUserType == UserType.user
                                ? Colors.black
                                : AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                          style: getMediumStyle(
                            color:
                                _selectedUserType == UserType.user
                                    ? AppColors.black
                                    : AppColors.textSecondary,
                            fontSize: 14,
                            fontFamily: FontConstant.cairo,
                          ),
                          child: const Text('مستخدم'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _handleUserTypeChange(UserType.doctor),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                          child: Icon(
                            Icons.medical_services_outlined,
                            size: 20,
                            color: _selectedUserType == UserType.doctor
                                ? Colors.black
                                : AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                          style: getMediumStyle(
                            color:
                                _selectedUserType == UserType.doctor
                                      ? AppColors.black
                                    : AppColors.textSecondary,
                            fontSize: 14,
                            fontFamily: FontConstant.cairo,
                          ),
                          child: const Text('دكتور'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, userState) {
        return BlocBuilder<DoctorAuthCubit, DoctorAuthState>(
          builder: (context, doctorState) {
            final isLoading =
                (_selectedUserType == UserType.user &&
                    userState is AuthLoading) ||
                (_selectedUserType == UserType.doctor &&
                    doctorState is DoctorAuthLoading);

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      labelText: AppLocalizations.of(context)!.email,
                      hintText: AppLocalizations.of(context)!.enterEmail,
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator:
                          (value) =>
                              FormValidators.validateEmail(value, context),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: _passwordController,
                      labelText: AppLocalizations.of(context)!.password,
                      hintText: AppLocalizations.of(context)!.enterPassword,
                      prefixIcon: Icons.lock_outline,
                      obscureText: _obscurePassword,
                      suffixIcon:
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                      onSuffixIconTap: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.pleaseEnterPassword;
                        }
                        if (value.length < 6) {
                          return AppLocalizations.of(context)!.passwordMustBe;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildRememberMeAndForgotPassword(),
                    const SizedBox(height: 28),
                    CustomButton(
                      text: AppLocalizations.of(context)!.login,
                      onPressed: isLoading ? null : () => _handleLogin(context),
                      isLoading: isLoading,
                      backgroundColor: AppColors.primary,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.dontHaveAccount,
                          style: getRegularStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            fontFamily: FontConstant.cairo,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.register);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.createNewAccount,
                            style: getMediumStyle(
                              color: AppColors.primary,
                              fontSize: 14,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
                fontFamily: FontConstant.cairo,
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.forgotPassword);
          },
          child: Text(
            AppLocalizations.of(context)!.forgotPassword,
            style: getMediumStyle(
              color: AppColors.primary,
              fontFamily: FontConstant.cairo,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
