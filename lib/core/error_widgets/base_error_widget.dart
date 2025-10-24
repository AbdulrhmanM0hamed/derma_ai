import 'package:derma_ai/core/widgets/custom_button.dart';
import 'package:derma_ai/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class BaseErrorWidget extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback? onRetry;
  final VoidCallback? onSecondaryAction;
  final String? secondaryActionText;
  final Color? primaryColor;

  const BaseErrorWidget({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.onRetry,
    this.onSecondaryAction,
    this.secondaryActionText,
    this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: (primaryColor ?? colorScheme.error).withValues(alpha:0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 64,
                  color: primaryColor ?? colorScheme.error,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface.withValues(alpha:0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              if (onRetry != null) ...[
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    onPressed: onRetry,
                    text: getRetryButtonText(context),
                  ),
                ),
                if (onSecondaryAction != null && secondaryActionText != null) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      onPressed: onSecondaryAction,
                      text: secondaryActionText!,
                    ),
                  ),
                ],
              ],
          ],
          )
        ),
      ),
    );
  }

  String getRetryButtonText(BuildContext context) {
    // This should be overridden in concrete implementations
    return AppLocalizations.of(context)?.retry ?? 'Retry';
  }
}
