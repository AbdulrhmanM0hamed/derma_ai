import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/widgets/custom_snackbar.dart';
import '../utils/helper/on_genrated_routes.dart';
import '../utils/common/custom_progress_indicator.dart';
import '../utils/constant/font_manger.dart';
import '../utils/constant/styles_manger.dart';
import '../../doctor_feature/auth/presentation/bloc/doctor_auth_cubit.dart';
import '../../doctor_feature/auth/presentation/bloc/doctor_auth_state.dart';
import '../../l10n/app_localizations.dart';
import '../services/service_locatores.dart';

class DoctorLogoutConfirmationDialog extends StatelessWidget {
  final DoctorAuthCubit authCubit;

  const DoctorLogoutConfirmationDialog({super.key, required this.authCubit});

  static Future<void> show(BuildContext context) async {
    final authCubit = sl<DoctorAuthCubit>();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DoctorLogoutConfirmationDialog(authCubit: authCubit);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authCubit,
      child: BlocListener<DoctorAuthCubit, DoctorAuthState>(
        listener: (context, state) {
          if (state is DoctorLogoutSuccess) {
            final navigatorContext =
                Navigator.of(context, rootNavigator: true).context;

            Navigator.of(context).pop();

            CustomSnackbar.showSuccess(
              context: navigatorContext,
              message: CustomSnackbar.getLocalizedMessage(
                context: navigatorContext,
                messageAr: state.messageAr,
                messageEn: state.messageEn,
              ),
            );

            Future.delayed(const Duration(milliseconds: 1500), () {
              Navigator.of(navigatorContext).pushNamedAndRemoveUntil(
                AppRoutes.login,
                (route) => false,
              );
            });
          } else if (state is DoctorLogoutFailure) {
            Navigator.of(context).pop();
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
        child: BlocBuilder<DoctorAuthCubit, DoctorAuthState>(
          builder: (context, state) {
            final isLoading = state is DoctorAuthLoading;
            return Stack(
              children: [
                AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: EdgeInsets.zero,
                  content: Container(
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.red.shade50, Colors.white],
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.red.shade500,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                AppLocalizations.of(context)!.logout,
                                style: getBoldStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontFamily: FontConstant.cairo,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.help_outline,
                                size: 48,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'هل أنت متأكد؟',
                                style: getBoldStyle(
                                  fontSize: 18,
                                  color: Colors.black87,
                                  fontFamily: FontConstant.cairo,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'هل تريد تسجيل الخروج من حسابك؟',
                                style: getRegularStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  fontFamily: FontConstant.cairo,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      onPressed: isLoading
                                          ? null
                                          : () => Navigator.of(context).pop(),
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          side: BorderSide(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'إلغاء',
                                        style: getSemiBoldStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                          fontFamily: FontConstant.cairo,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: isLoading
                                          ? null
                                          : () => context
                                              .read<DoctorAuthCubit>()
                                              .logout(),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red.shade500,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        elevation: 2,
                                      ),
                                      child: Text(
                                        'تسجيل الخروج',
                                        style: getBoldStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontFamily: FontConstant.cairo,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isLoading)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(child: CustomProgressIndicator()),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
