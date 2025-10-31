import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/widgets/custom_snackbar.dart';
import '../utils/helper/on_genrated_routes.dart';
import '../utils/common/custom_progress_indicator.dart';
import '../utils/constant/font_manger.dart';
import '../utils/constant/styles_manger.dart';
import '../../user_features/auth/presentation/bloc/auth_cubit.dart';
import '../../user_features/auth/presentation/bloc/auth_state.dart';
import '../../l10n/app_localizations.dart';
import '../services/service_locatores.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  final AuthCubit authCubit;

  const LogoutConfirmationDialog({super.key, required this.authCubit});

  static Future<void> show(BuildContext context) async {
    final authCubit = sl<AuthCubit>();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LogoutConfirmationDialog(authCubit: authCubit);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authCubit,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            // Store context before closing dialog
            final navigatorContext = Navigator.of(context, rootNavigator: true).context;
            
            // Close dialog first
            Navigator.of(context).pop();

            // Show success message
            CustomSnackbar.showSuccess(
              context: navigatorContext,
              message: CustomSnackbar.getLocalizedMessage(
                context: navigatorContext,
                messageAr: state.messageAr,
                messageEn: state.messageEn,
              ),
            );

            // Add a small delay to ensure token is cleared
            Future.delayed(const Duration(milliseconds: 1500), () {
              Navigator.of(navigatorContext).pushNamedAndRemoveUntil(
                AppRoutes.login, 
                (route) => false,
              );
            });
          } else if (state is LogoutFailure) {
            Navigator.of(context).pop(); // Close dialog
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
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final isLoading = state is AuthLoading;
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
                        // Header with icon
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

                        // Content
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

                              // Action buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      onPressed: isLoading
                                          ? null
                                          : () {
                                              Navigator.of(context).pop();
                                            },
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
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
                                          : () {
                                              context.read<AuthCubit>().logout();
                                            },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red.shade500,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
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
                  // Loading overlay
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
