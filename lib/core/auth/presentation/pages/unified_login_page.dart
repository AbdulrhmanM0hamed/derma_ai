import 'package:derma_ai/core/utils/validators/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../services/service_locatores.dart';
import '../../../services/token_storage_service.dart';
import '../../../network/app_state_service.dart';
import '../../../utils/common/custom_progress_indicator.dart';
import '../../../utils/helper/on_genrated_routes.dart';
import '../../../utils/theme/app_colors.dart';
import '../../../utils/widgets/custom_snackbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../../user_features/auth/presentation/bloc/auth_cubit.dart';
import '../../../../user_features/auth/presentation/bloc/auth_state.dart';
import '../../../../doctor_feature/auth/presentation/bloc/doctor_auth_cubit.dart';
import '../../../../doctor_feature/auth/presentation/bloc/doctor_auth_state.dart';
import '../widgets/auth_widgets.dart';

// Re-export UserType from auth_header.dart for backward compatibility
export '../widgets/auth_header.dart' show UserType;

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
          password: _rememberMe ? password : null,
        );

        // Call appropriate login method based on user type
        if (_selectedUserType == UserType.user) {
          // Use user endpoints
          context.read<AuthCubit>().login(email: email, password: password);
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
                        // Save last active user type
                        sl<AppStateService>().setLastActiveUserType(LastActiveUserType.user);
                        
                        CustomSnackbar.showSuccess(
                          context: context,
                          message: CustomSnackbar.getLocalizedMessage(
                            context: context,
                            messageAr: state.messageAr,
                            messageEn: state.messageEn,
                          ),
                        );
                        // Navigate to main navigation page
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.mainNavigationPage,
                        );
                      } else if (state is AccountNotVerified) {
                        // Show message then navigate to OTP page
                        CustomSnackbar.showWarning(
                          context: context,
                          message: CustomSnackbar.getLocalizedMessage(
                            context: context,
                            messageAr: state.messageAr,
                            messageEn: state.messageEn,
                          ),
                        );

                        // Auto navigate to OTP verification
                        final userId = state.userId;
                        final email = _emailController.text.trim();
                        final verificationType =
                            state.requiresVerification?['email'] == true
                                ? 'email'
                                : 'phone';

                        Future.delayed(const Duration(milliseconds: 800), () {
                          if (context.mounted) {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.otpVerification,
                              arguments: {
                                'userId': userId,
                                'email': email,
                                'phone': '',
                                'type': verificationType,
                              },
                            );
                          }
                        });
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
                        // Save last active user type
                        sl<AppStateService>().setLastActiveUserType(LastActiveUserType.doctor);
                        
                        CustomSnackbar.showSuccess(
                          context: context,
                          message: CustomSnackbar.getLocalizedMessage(
                            context: context,
                            messageAr: state.messageAr,
                            messageEn: state.messageEn,
                          ),
                        );
                        // Navigate to doctor navigation page
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.doctorNavigation,
                        );
                      } else if (state is DoctorAccountNotVerified) {
                        // Show message then navigate to doctor OTP page
                        //print('🔴 DoctorAccountNotVerified state received');
                        //print('🔴 UserId: ${state.userId}');
                        //print('🔴 Email: ${_emailController.text.trim()}');

                        CustomSnackbar.showWarning(
                          context: context,
                          message: CustomSnackbar.getLocalizedMessage(
                            context: context,
                            messageAr: state.messageAr,
                            messageEn: state.messageEn,
                          ),
                        );

                        // Auto navigate to doctor OTP verification
                        final userId = state.userId;
                        final email = _emailController.text.trim();
                        final verificationType =
                            state.requiresVerification?['email'] == true
                                ? 'email'
                                : 'phone';

                        //print(
                        //   '🔴 Scheduling navigation with userId: $userId, email: $email',
                        // );

                        Future.delayed(const Duration(milliseconds: 800), () {
                          //print(
                          //   '🔴 Delay completed, context.mounted: ${context.mounted}',
                          // );
                          if (context.mounted) {
                            //print('🔴 Navigating to doctorOtpVerification...');
                            Navigator.pushNamed(
                                  context,
                                  AppRoutes.doctorOtpVerification,
                                  arguments: {
                                    'userId': userId,
                                    'email': email,
                                    'phone': '',
                                    'type': verificationType,
                                  },
                                )
                                .then((_) {
                                  //print('🔴 Navigation completed');
                                })
                                .catchError((error) {
                                  //print('🔴 Navigation error: $error');
                                });
                          } else {
                            //print('🔴 Context not mounted, navigation skipped');
                          }
                        });
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
                  decoration: BoxDecoration(),
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
    final l10n = AppLocalizations.of(context)!;
    return AuthHeader(
      selectedUserType: _selectedUserType,
      title: l10n.login,
      subtitle: l10n.welcomeBack,
    );
  }

  Widget _buildUserTypeSelector() {
    final l10n = AppLocalizations.of(context)!;
    return UserTypeSelector(
      selectedUserType: _selectedUserType,
      userLabel: l10n.user,
      doctorLabel: l10n.doctor,
      onUserTypeChanged: _handleUserTypeChange,
    );
  }

  Widget _buildLoginForm() {
    final l10n = AppLocalizations.of(context)!;
    
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, userState) {
        return BlocBuilder<DoctorAuthCubit, DoctorAuthState>(
          builder: (context, doctorState) {
            final isLoading =
                (_selectedUserType == UserType.user && userState is AuthLoading) ||
                (_selectedUserType == UserType.doctor && doctorState is DoctorAuthLoading);

            return Stack(
              children: [
                AuthFormCard(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: _emailController,
                          labelText: l10n.email,
                          hintText: l10n.enterEmail,
                          prefixIcon: Icons.email_rounded,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => FormValidators.validateEmail(value, context),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: _passwordController,
                          labelText: l10n.password,
                          hintText: l10n.enterPassword,
                          prefixIcon: Icons.lock_rounded,
                          obscureText: _obscurePassword,
                          suffixIcon: _obscurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                          onSuffixIconTap: () {
                            setState(() => _obscurePassword = !_obscurePassword);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.pleaseEnterPassword;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            RememberMeCheckbox(
                              value: _rememberMe,
                              label: l10n.rememberMe,
                              onChanged: (value) {
                                setState(() => _rememberMe = value);
                              },
                            ),
                            const Spacer(),
                            ForgotPasswordLink(
                              text: l10n.forgotPassword,
                              onTap: () {
                                Navigator.pushNamed(context, '/forgot-password');
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        CustomButton(
                          text: l10n.login,
                          onPressed: isLoading ? null : () => _handleLogin(context),
                          isLoading: false,
                          backgroundColor: AppColors.primary,
                        ),
                        const SizedBox(height: 20),
                        AuthNavLink(
                          text: l10n.dontHaveAccount,
                          linkText: l10n.signUp,
                          onLinkTap: () {
                            Navigator.pushReplacementNamed(context, '/register');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                if (isLoading) const CustomProgressIndicator(),
              ],
            );
          },
        );
      },
    );
  }
}
