import 'package:derma_ai/core/constants/app_constants.dart';
import 'package:derma_ai/user_features/ai_diagnosis/presentation/pages/ai_skin_diagnosis.dart';
import 'package:derma_ai/user_features/ai_diagnosis_info/presentation/pages/ai_diagnosis_info_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          // Notch/cutout for center button
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Center(
              child: Container(
                width: 70,
                height: 35,
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
              ),
            ),
          ),
          // Center AI Diagnosis button
          Positioned(
            left: 0,
            right: 0,
            top: -15,
            child: Center(
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AiSkinDiagnosis(),
                    ),
                  );
                },
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
          ),
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
