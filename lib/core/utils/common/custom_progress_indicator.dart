import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomProgressIndicator extends StatelessWidget {
  final Color color;
  final double size;

  const CustomProgressIndicator({
    super.key,
    this.color = AppColors.primary,
    this.size = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.black.withValues(alpha: 0.1),
        margin: const EdgeInsets.all(16),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SpinKitWaveSpinner(
            color: color,
            size: size,
          ),
        ),
      ),
    );
  }
}
