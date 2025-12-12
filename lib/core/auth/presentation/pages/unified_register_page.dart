import 'package:derma_ai/core/utils/validators/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../services/service_locatores.dart';
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

class UnifiedRegisterPage extends StatefulWidget {
  const UnifiedRegisterPage({super.key});

  @override
  State<UnifiedRegisterPage> createState() => _UnifiedRegisterPageState();
}

class _UnifiedRegisterPageState extends State<UnifiedRegisterPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _licenseNumberController =
      TextEditingController(); // رقم الترخيص للدكتور
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = false;
  UserType _selectedUserType = UserType.user;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _licenseNumberController.dispose();
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

  void _handleRegister(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    if (!_acceptTerms) {
      CustomSnackbar.showError(
        context: context,
        message: AppLocalizations.of(context)!.pleaseAcceptTerms,
      );
      return;
    }

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();
    final licenseNumber = _licenseNumberController.text.trim();

    if (_selectedUserType == UserType.user) {
      context.read<AuthCubit>().register(
        fullName: name,
        email: email,
        phone: phone,
        password: password,
      );
    } else {
      context.read<DoctorAuthCubit>().register(
        fullName: name,
        email: email,
        phone: phone,
        password: password,
        specialization: 'General', // Default value
        licenseNumber: licenseNumber.toUpperCase(), // رقم الترخيص بأحرف كبيرة
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => sl<AuthCubit>()),
        BlocProvider<DoctorAuthCubit>(
          create: (context) => sl<DoctorAuthCubit>(),
        ),
      ],
      child: Scaffold(
        body: MultiBlocListener(
          listeners: [
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is RegisterSuccess) {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.otpVerification,
                    arguments: {
                      'userId': state.entity.id,
                      'email': _emailController.text.trim(),
                      'phone': _phoneController.text.trim(),
                      'type': 'email',
                    },
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
            ),
            BlocListener<DoctorAuthCubit, DoctorAuthState>(
              listener: (context, state) {
                if (state is DoctorRegisterSuccess) {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.doctorOtpVerification,
                    arguments: {
                      'userId': state.entity.id,
                      'email': _emailController.text.trim(),
                      'phone': _phoneController.text.trim(),
                      'type': 'email',
                    },
                  );
                } else if (state is DoctorRegisterFailure) {
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
                    _buildRegisterForm(),
                    const SizedBox(height: 20),
                  ],
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
      title: l10n.createAccount,
      subtitle: l10n.welcomeToDermaAI,
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

  Widget _buildRegisterForm() {
    final l10n = AppLocalizations.of(context)!;
    
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, userState) {
        return BlocBuilder<DoctorAuthCubit, DoctorAuthState>(
          builder: (context, doctorState) {
            final isLoading =
                userState is AuthLoading || doctorState is DoctorAuthLoading;

            return Stack(
              children: [
                AuthFormCard(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _nameController,
                          labelText: l10n.fullName,
                          hintText: l10n.enterFullName,
                          prefixIcon: Icons.person_rounded,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.pleaseEnterName;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
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
                          controller: _phoneController,
                          labelText: l10n.phoneNumber,
                          hintText: l10n.enterPhoneNumber,
                          prefixIcon: Icons.phone_rounded,
                          keyboardType: TextInputType.phone,
                          validator: (value) => FormValidators.validatePhoneNumber(value, context),
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
                            if (value.length < 6) {
                              return l10n.passwordMustBe;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: _confirmPasswordController,
                          labelText: l10n.confirmPassword,
                          hintText: l10n.confirmYourPassword,
                          prefixIcon: Icons.lock_rounded,
                          obscureText: _obscureConfirmPassword,
                          suffixIcon: _obscureConfirmPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                          onSuffixIconTap: () {
                            setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.pleaseConfirmPassword;
                            }
                            if (value != _passwordController.text) {
                              return l10n.passwordsDoNotMatch;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // Doctor license number field
                        if (_selectedUserType == UserType.doctor) ...[
                          CustomTextField(
                            controller: _licenseNumberController,
                            labelText: l10n.medicalLicenseNumber,
                            hintText: l10n.enterMedicalLicenseNumber,
                            prefixIcon: Icons.badge_rounded,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.characters,
                            validator: (value) => FormValidators.validateMedicalLicenseNumber(value, context),
                          ),
                          const SizedBox(height: 20),
                        ],
                        TermsCheckbox(
                          value: _acceptTerms,
                          agreeText: l10n.iAgreeToThe,
                          termsText: l10n.termsOfService,
                          andText: l10n.and,
                          privacyText: l10n.privacyPolicy,
                          onChanged: (value) {
                            setState(() => _acceptTerms = value);
                          },
                          onTermsTap: () {
                            // TODO: Navigate to terms
                          },
                          onPrivacyTap: () {
                            // TODO: Navigate to privacy policy
                          },
                        ),
                        const SizedBox(height: 28),
                        CustomButton(
                          text: l10n.createAccount,
                          onPressed: () => _handleRegister(context),
                          backgroundColor: AppColors.primary,
                        ),
                        const SizedBox(height: 20),
                        AuthNavLink(
                          text: l10n.alreadyHaveAccount,
                          linkText: l10n.login,
                          onLinkTap: () {
                            Navigator.pushNamed(context, AppRoutes.login);
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
