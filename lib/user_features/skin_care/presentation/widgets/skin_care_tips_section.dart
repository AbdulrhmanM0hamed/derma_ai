import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class SkinCareTipsSection extends StatelessWidget {
  const SkinCareTipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tips = [
      {
        'title': 'اشرب الماء بكثرة',
        'description':
            'شرب 8 أكواب من الماء يومياً يساعد في ترطيب البشرة من الداخل',
        'icon': Icons.local_drink_outlined,
        'color': const Color(0xFF2196F3),
      },
      {
        'title': 'احم بشرتك من الشمس',
        'description': 'استخدم واقي الشمس يومياً حتى في الأيام الغائمة',
        'icon': Icons.wb_sunny_outlined,
        'color': const Color(0xFFFF9800),
      },
      {
        'title': 'نم جيداً',
        'description': 'النوم 7-8 ساعات يساعد في تجديد خلايا البشرة',
        'icon': Icons.bedtime_outlined,
        'color': const Color(0xFF9C27B0),
      },
      {
        'title': 'تناول الفواكه والخضروات',
        'description': 'الأطعمة الغنية بالفيتامينات تغذي البشرة من الداخل',
        'icon': Icons.eco_outlined,
        'color': const Color(0xFF4CAF50),
      },
      {
        'title': 'تجنب لمس الوجه',
        'description': 'لمس الوجه بأيدي غير نظيفة يسبب انتشار البكتيريا',
        'icon': Icons.pan_tool_outlined,
        'color': const Color(0xFFF44336),
      },
      {
        'title': 'مارس الرياضة',
        'description':
            'التمارين تحسن الدورة الدموية وتعطي البشرة إشراقاً طبيعياً',
        'icon': Icons.fitness_center_outlined,
        'color': const Color(0xFF607D8B),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'نصائح للعناية بالبشرة',
          style: getBoldStyle(fontSize: 20, fontFamily: FontConstant.cairo),
        ),
        const SizedBox(height: 16),

        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            childAspectRatio: 0.85,
          ),
          itemCount: tips.length,
          itemBuilder: (context, index) {
            final tip = tips[index];
            return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [
                          (tip['color'] as Color).withValues(alpha: 0.05),
                          (tip['color'] as Color).withValues(alpha: 0.02),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: (tip['color'] as Color).withValues(
                              alpha: 0.15,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            tip['icon'] as IconData,
                            color: tip['color'] as Color,
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          tip['title'] as String,
                          style: getBoldStyle(
                            fontSize: 16,
                            fontFamily: FontConstant.cairo,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            tip['description'] as String,
                            style: getRegularStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                              fontFamily: FontConstant.cairo,
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .animate()
                .fadeIn(delay: Duration(milliseconds: 150 * index))
                .scale(begin: const Offset(0.8, 0.8));
          },
        ),
      ],
    );
  }
}
