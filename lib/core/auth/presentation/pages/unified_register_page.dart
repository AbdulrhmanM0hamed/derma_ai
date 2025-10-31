import 'package:derma_ai/core/utils/validators/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../services/service_locatores.dart';
import '../../../utils/common/custom_progress_indicator.dart';
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
        licenseNumber: '000000', // Default value
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => sl<AuthCubit>(),
        ),
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
                  Navigator.pushReplacementNamed(context, AppRoutes.otpVerification);
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
                  Navigator.pushReplacementNamed(context, AppRoutes.otpVerification);
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
                ? AppLocalizations.of(context)!.createAccount
                : AppLocalizations.of(context)!.createAccount,
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
                ? AppLocalizations.of(context)!.welcomeToDermaAI
                : AppLocalizations.of(context)!.welcomeToDermaAI,
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
            duration: const Duration(milliseconds: 1200),
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
                                    ? Colors.black
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
                                    ? Colors.black
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

  Widget _buildRegisterForm() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, userState) {
        return BlocBuilder<DoctorAuthCubit, DoctorAuthState>(
          builder: (context, doctorState) {
            final isLoading = userState is AuthLoading ||
                doctorState is DoctorAuthLoading;

            return Stack(
              children: [
                Container(
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
                      controller: _nameController,
                      labelText: AppLocalizations.of(context)!.fullName,
                      hintText: AppLocalizations.of(context)!.enterFullName,
                      prefixIcon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.pleaseEnterName;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: _emailController,
                      labelText: AppLocalizations.of(context)!.email,
                      hintText: AppLocalizations.of(context)!.enterEmail,
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          FormValidators.validateEmail(value, context),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: _phoneController,
                      labelText: AppLocalizations.of(context)!.phoneNumber,
                      hintText: AppLocalizations.of(context)!.enterPhoneNumber,
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          FormValidators.validatePhoneNumber(value, context),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: _passwordController,
                      labelText: AppLocalizations.of(context)!.password,
                      hintText: AppLocalizations.of(context)!.enterPassword,
                      prefixIcon: Icons.lock_outline,
                      obscureText: _obscurePassword,
                      suffixIcon: _obscurePassword
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
                    CustomTextField(
                      controller: _confirmPasswordController,
                      labelText: AppLocalizations.of(context)!.confirmPassword,
                      hintText: AppLocalizations.of(context)!.confirmYourPassword,
                      prefixIcon: Icons.lock_outline,
                      obscureText: _obscureConfirmPassword,
                      suffixIcon: _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      onSuffixIconTap: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.pleaseConfirmPassword;
                        }
                        if (value != _passwordController.text) {
                          return AppLocalizations.of(context)!.passwordsDoNotMatch;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildTermsAndConditions(),
                    const SizedBox(height: 28),
                    CustomButton(
                      text: AppLocalizations.of(context)!.createAccount,
                      onPressed: isLoading ? null : () => _handleRegister(context),
                      isLoading: isLoading,
                      backgroundColor: AppColors.primary,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.alreadyHaveAccount,
                          style: getRegularStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            fontFamily: FontConstant.cairo,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.login,
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
                // إظهار الـ loading في منتصف الصفحة
                ),if (isLoading)
                  const CustomProgressIndicator(),
              ],
            );
          },
        );
      },
   
  );}

  Widget _buildTermsAndConditions() {
    return Row(
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
          child: Wrap(
            children: [
              Text(
                AppLocalizations.of(context)!.iAgreeToThe,
                style: getRegularStyle(
                  fontFamily: FontConstant.cairo,
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to terms
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  AppLocalizations.of(context)!.termsOfService,
                  style: getMediumStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontFamily: FontConstant.cairo,
                  ),
                ),
              ),
              Text(
                ' ${AppLocalizations.of(context)!.and} ',
                style: getRegularStyle(
                  fontFamily: FontConstant.cairo,
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to privacy policy
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  AppLocalizations.of(context)!.privacyPolicy,
                  style: getMediumStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontFamily: FontConstant.cairo,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
