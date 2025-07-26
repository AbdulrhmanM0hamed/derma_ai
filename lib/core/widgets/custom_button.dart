import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';

enum ButtonType { primary, secondary, outline, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final IconData? icon;
  final bool isLoading;
  final bool fullWidth;
  final double? width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final bool animate;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
    this.width,
    this.height = 50,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    Widget buttonWidget;
    
    switch (type) {
      case ButtonType.primary:
        buttonWidget = _buildElevatedButton(theme);
        break;
      case ButtonType.secondary:
        buttonWidget = _buildSecondaryButton(theme);
        break;
      case ButtonType.outline:
        buttonWidget = _buildOutlinedButton(theme);
        break;
      case ButtonType.text:
        buttonWidget = _buildTextButton(theme);
        break;
    }
    
    if (animate) {
      return buttonWidget
        .animate()
        .scale(duration: 200.ms, curve: Curves.easeInOut, begin: const Offset(1, 1), end: const Offset(1.05, 1.05))
        .animate()
        .scale(duration: 100.ms, curve: Curves.easeInOut, begin: const Offset(1, 1), end: const Offset(0.95, 0.95));
    }
    
    return buttonWidget;
  }

  Widget _buildElevatedButton(ThemeData theme) {
    return SizedBox(
      width: fullWidth ? double.infinity : width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child: _buildButtonContent(Colors.white),
      ),
    );
  }

  Widget _buildSecondaryButton(ThemeData theme) {
    return SizedBox(
      width: fullWidth ? double.infinity : width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child: _buildButtonContent(Colors.white),
      ),
    );
  }

  Widget _buildOutlinedButton(ThemeData theme) {
    return SizedBox(
      width: fullWidth ? double.infinity : width,
      height: height,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: _buildButtonContent(AppColors.primary),
      ),
    );
  }

  Widget _buildTextButton(ThemeData theme) {
    return SizedBox(
      width: fullWidth ? double.infinity : width,
      height: height,
      child: TextButton(
        onPressed: isLoading ? null : onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: _buildButtonContent(AppColors.primary),
      ),
    );
  }

  Widget _buildButtonContent(Color color) {
    if (isLoading) {
      return SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(text),
        ],
      );
    }

    return Text(text);
  }
}