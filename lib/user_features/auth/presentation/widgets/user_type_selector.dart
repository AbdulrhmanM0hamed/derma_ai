import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/helper/on_genrated_routes.dart';

enum UserType { user, doctor }

class UserTypeSelector extends StatefulWidget {
  final UserType selectedType;
  final Function(UserType) onTypeChanged;

  const UserTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  State<UserTypeSelector> createState() => _UserTypeSelectorState();
}

class _UserTypeSelectorState extends State<UserTypeSelector>
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
        // Navigate to doctor login
        Navigator.pushReplacementNamed(context, AppRoutes.doctorLogin);
      } else {
        _animationController.reverse();
      }
      widget.onTypeChanged(type);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
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
                top: 3,
                bottom: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
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
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 20,
                          color: widget.selectedType == UserType.user
                              ? Colors.white
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'مستخدم',
                          style: getMediumStyle(
                            color: widget.selectedType == UserType.user
                                ? Colors.white
                                : AppColors.textSecondary,
                            fontSize: 14,
                            fontFamily: FontConstant.cairo,
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
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.medical_services_outlined,
                          size: 20,
                          color: widget.selectedType == UserType.doctor
                              ? Colors.white
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'دكتور',
                          style: getMediumStyle(
                            color: widget.selectedType == UserType.doctor
                                ? Colors.white
                                : AppColors.textSecondary,
                            fontSize: 14,
                            fontFamily: FontConstant.cairo,
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
