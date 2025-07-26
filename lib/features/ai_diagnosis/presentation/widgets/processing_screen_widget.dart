import 'package:flutter/material.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class ProcessingScreenWidget extends StatefulWidget {
  final String currentStatus;

  const ProcessingScreenWidget({
    Key? key,
    required this.currentStatus,
  }) : super(key: key);

  @override
  State<ProcessingScreenWidget> createState() => _ProcessingScreenWidgetState();
}

class _ProcessingScreenWidgetState extends State<ProcessingScreenWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _rotationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.14159,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated Processing Icon
          AnimatedBuilder(
            animation: Listenable.merge([_pulseAnimation, _rotationAnimation]),
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.secondary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary
                              .withValues(alpha: 0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.psychology_outlined,
                        color: AppColors.textLight,
                        size: 48,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.04),

          // Status Text
          Text(
            widget.currentStatus,
            style: getSemiBoldStyle(
              color: AppColors.primary,
              fontSize: 20,
              fontFamily: FontConstant.cairo,
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.02),

          // Progress Steps
          _buildProgressSteps(),

          SizedBox(height: MediaQuery.of(context).size.height * 0.04),

          // Processing Details
          Container(
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.06),
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.border
                    .withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Text(
                  'يتم الآن تحليل الصورة باستخدام الذكاء الاصطناعي المتقدم',
                  style: getRegularStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                    fontFamily: FontConstant.cairo,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.security,
                      color: AppColors.third,
                      size: 16,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Text(
                      'آمن ومشفر بالكامل',
                      style: getRegularStyle(
                        color: AppColors.third,
                        fontSize: 12,
                        fontFamily: FontConstant.cairo,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSteps() {
    final steps = [
      {'label': 'تحليل الصورة', 'completed': true},
      {'label': 'فحص الأنماط', 'completed': true},
      {'label': 'مقارنة البيانات', 'completed': false},
      {'label': 'إنتاج النتائج', 'completed': false},
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: steps.asMap().entries.map((entry) {
          final index = entry.key;
          final step = entry.value;
          final isCompleted = step['completed'] as bool;
          final isActive = index == 2; // Currently processing step

          return Expanded(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.08,
                  height: MediaQuery.of(context).size.width * 0.08,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? AppColors.third
                        : isActive
                            ? AppColors.primary
                            : AppColors.border,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: isCompleted
                        ? Icon(
                            Icons.check,
                            color: AppColors.textLight,
                            size: 16,
                          )
                        : isActive
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                                height: MediaQuery.of(context).size.width * 0.04,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color:
                                      AppColors.textLight,
                                ),
                              )
                            : null,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  step['label'] as String,
                  style: getRegularStyle(
                    fontFamily: FontConstant.cairo,
                    color: isCompleted || isActive
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                    fontSize: MediaQuery.of(context).size.width * 0.0225,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
