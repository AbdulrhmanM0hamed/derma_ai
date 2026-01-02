import 'package:derma_ai/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main navigation bar with notch
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  context: context,
                  icon: Iconsax.home,
                  activeIcon: Iconsax.home,
                  label: AppLocalizations.of(context)!.home,
                  index: 0,
                  isActive: currentIndex == 0,
                ),
                _buildNavItem(
                  context: context,
                  icon: Iconsax.user_octagon,
                  activeIcon: Iconsax.user_octagon,
                  label: AppLocalizations.of(context)!.doctors,
                  index: 1,
                  isActive: currentIndex == 1,
                ),
                // Empty space for center button
                const SizedBox(width: 60),
                _buildNavItem(
                  context: context,
                  icon: Iconsax.calendar,
                  activeIcon: Iconsax.calendar,
                  label: AppLocalizations.of(context)!.appointments,
                  index: 3,
                  isActive: currentIndex == 3,
                ),
                _buildNavItem(
                  context: context,
                  icon: Iconsax.profile_circle,
                  activeIcon: Iconsax.profile_circle,
                  label: AppLocalizations.of(context)!.profile,
                  index: 4,
                  isActive: currentIndex == 4,
                ),
              ],
            ),
          ),

          // Center AI Diagnosis button
          CenterAIDiagnosisbutton(onTap: onTap, isSelected: currentIndex == 2),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required bool isActive,
  }) {
    final theme = Theme.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  isActive ? activeIcon : icon,
                  color:
                      isActive
                          ? AppColors.primary
                          : theme.unselectedWidgetColor,
                  size: 25,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color:
                      isActive
                          ? AppColors.primary
                          : theme.unselectedWidgetColor,
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CenterAIDiagnosisbutton extends StatelessWidget {
  const CenterAIDiagnosisbutton({
    super.key,
    required this.onTap,
    required this.isSelected,
  });

  final Function(int p1) onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: isSelected ? -18 : -15,
      child: Center(
        child: MaterialButton(
          onPressed: () => onTap(2),
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(5),
          color: AppColors.primary,
          elevation: 3,
          child: SizedBox(
            height: 50,
            width: 50,
            child: Image.asset(AppConstants.aiLogo),
          ),
        ),
      ),
    );
  }
}
