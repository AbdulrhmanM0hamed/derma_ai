import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/constant/font_manger.dart';
import '../utils/constant/styles_manger.dart';
import '../utils/theme/app_colors.dart';

enum UserType { user, doctor }

class UserTypeSwitch extends StatefulWidget {
  final UserType selectedType;
  final Function(UserType) onTypeChanged;
  final bool isDarkMode;

  const UserTypeSwitch({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
    this.isDarkMode = false,
  });

  @override
  State<UserTypeSwitch> createState() => _UserTypeSwitchState();
}

class _UserTypeSwitchState extends State<UserTypeSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.selectedType == UserType.doctor) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTypeChange(UserType type) {
    if (type != widget.selectedType) {
      if (type == UserType.doctor) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
      widget.onTypeChanged(type);
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.isDarkMode ? Colors.white : AppColors.primary;
    final backgroundColor = widget.isDarkMode 
        ? Colors.white.withOpacity(0.1) 
        : Colors.grey.shade100;
    final textColor = widget.isDarkMode ? Colors.white : AppColors.black;
    final selectedTextColor = widget.isDarkMode ? AppColors.primary : Colors.white;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          // Animated background slider
          AnimatedBuilder(
            animation: _slideAnimation,
            builder: (context, child) {
              return Positioned(
                left: _slideAnimation.value * (MediaQuery.of(context).size.width * 0.4),
                top: 4,
                bottom: 4,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          // User and Doctor buttons
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _handleTypeChange(UserType.user),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 20,
                          color: widget.selectedType == UserType.user
                              ? selectedTextColor
                              : textColor.withOpacity(0.6),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'مستخدم',
                          style: getMediumStyle(
                            fontFamily: FontConstant.cairo,
                            color: widget.selectedType == UserType.user
                                ? selectedTextColor
                                : textColor.withOpacity(0.6),
                            fontSize: FontSize.size14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _handleTypeChange(UserType.doctor),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.medical_services_outlined,
                          size: 20,
                          color: widget.selectedType == UserType.doctor
                              ? selectedTextColor
                              : textColor.withOpacity(0.6),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'دكتور',
                          style: getMediumStyle(
                            fontFamily: FontConstant.cairo,
                            color: widget.selectedType == UserType.doctor
                                ? selectedTextColor
                                : textColor.withOpacity(0.6),
                            fontSize: FontSize.size14,
                          ),
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
    ).animate().scale(
      duration: const Duration(milliseconds: 400),
      curve: Curves.elasticOut,
    );
  }
}

// Alternative Compact Switch Design
class CompactUserTypeSwitch extends StatelessWidget {
  final UserType selectedType;
  final Function(UserType) onTypeChanged;
  final bool isDarkMode;

  const CompactUserTypeSwitch({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = isDarkMode ? Colors.white : AppColors.primary;
    final backgroundColor = isDarkMode 
        ? Colors.white.withOpacity(0.1) 
        : Colors.grey.shade100;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTypeButton(
            type: UserType.user,
            icon: Icons.person_outline,
            label: 'مستخدم',
            isSelected: selectedType == UserType.user,
            primaryColor: primaryColor,
          ),
          const SizedBox(width: 4),
          _buildTypeButton(
            type: UserType.doctor,
            icon: Icons.medical_services_outlined,
            label: 'دكتور',
            isSelected: selectedType == UserType.doctor,
            primaryColor: primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildTypeButton({
    required UserType type,
    required IconData icon,
    required String label,
    required bool isSelected,
    required Color primaryColor,
  }) {
    return GestureDetector(
      onTap: () => onTypeChanged(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected
                  ? Colors.white
                  : (isDarkMode ? Colors.white.withOpacity(0.6) : AppColors.grey),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: getMediumStyle(
                fontFamily: FontConstant.cairo,
                color: isSelected
                    ? Colors.white
                    : (isDarkMode ? Colors.white.withOpacity(0.6) : AppColors.grey),
                fontSize: FontSize.size12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
