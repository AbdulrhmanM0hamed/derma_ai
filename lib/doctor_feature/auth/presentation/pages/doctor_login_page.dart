import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/service_locatores.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/helper/on_genrated_routes.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/widgets/custom_snackbar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../bloc/doctor_auth_cubit.dart';
import '../bloc/doctor_auth_state.dart';

class DoctorLoginPage extends StatefulWidget {
  const DoctorLoginPage({super.key});

  @override
  State<DoctorLoginPage> createState() => _DoctorLoginPageState();
}

class _DoctorLoginPageState extends State<DoctorLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<DoctorAuthCubit>().login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<DoctorAuthCubit>(),
        child: BlocConsumer<DoctorAuthCubit, DoctorAuthState>(
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
              // TODO: Navigate to doctor dashboard
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
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.8),
                  ],
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      _buildHeader(),
                      const SizedBox(height: 40),
                      _buildLoginForm(state),
                      const SizedBox(height: 20),
                      _buildSwitchToUserButton(),
                    ],
                  ),
                ),
              ),
            );
          },
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
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.medical_services_outlined,
            size: 60,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'تسجيل دخول الطبيب',
          style: getBoldStyle(
            color: Colors.white,
            fontSize: 28,
            fontFamily: FontConstant.cairo,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'مرحباً بك في منصة الأطباء',
          style: getRegularStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 16,
            fontFamily: FontConstant.cairo,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(DoctorAuthState state) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              controller: _emailController,
              labelText: 'البريد الإلكتروني',
              hintText: 'أدخل بريدك الإلكتروني',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال البريد الإلكتروني';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'يرجى إدخال بريد إلكتروني صحيح';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _passwordController,
              labelText: 'كلمة المرور',
              hintText: 'أدخل كلمة المرور',
              prefixIcon: Icons.lock_outline,
              obscureText: _obscurePassword,
              suffixIcon: _obscurePassword ? Icons.visibility_off : Icons.visibility,
              onSuffixIconTap: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال كلمة المرور';
                }
                if (value.length < 6) {
                  return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'تسجيل الدخول',
              onPressed: state is DoctorAuthLoading ? null : _handleLogin,
              isLoading: state is DoctorAuthLoading,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ليس لديك حساب؟ ',
                  style: getRegularStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    fontFamily: FontConstant.cairo,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to doctor register
                  },
                  child: Text(
                    'إنشاء حساب جديد',
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
  }

  Widget _buildSwitchToUserButton() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: OutlinedButton.icon(
        onPressed: () {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        },
        icon: const Icon(Icons.person_outline, color: Colors.white),
        label: Text(
          'تسجيل دخول كمستخدم',
          style: getMediumStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: FontConstant.cairo,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
