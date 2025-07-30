import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class SkinTypeCard extends StatelessWidget {
  const SkinTypeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final skinTypes = [
      {
        'title': 'البشرة الدهنية',
        'description': 'تتميز بإفراز الزيوت الزائدة',
        'icon': Icons.water_drop_outlined,
        'color': const Color(0xFF4CAF50),
        'tips': [
          'استخدم غسول خالي من الزيوت',
          'استخدم تونر مناسب',
          'رطب بكريم خفيف',
        ],
      },
      {
        'title': 'البشرة الجافة',
        'description': 'تحتاج للترطيب المستمر',
        'icon': Icons.dry_cleaning_outlined,
        'color': const Color(0xFF2196F3),
        'tips': [
          'استخدم كريم مرطب غني',
          'تجنب الماء الساخن',
          'استخدم زيوت طبيعية',
        ],
      },
      {
        'title': 'البشرة المختلطة',
        'description': 'دهنية في المنطقة T وجافة في الباقي',
        'icon': Icons.balance_outlined,
        'color': const Color(0xFF9C27B0),
        'tips': ['استخدم منتجات مختلفة للمناطق', 'نظف بلطف', 'رطب حسب الحاجة'],
      },
      {
        'title': 'البشرة الحساسة',
        'description': 'تتأثر بسهولة بالمنتجات',
        'icon': Icons.favorite_outline,
        'color': const Color(0xFFFF9800),
        'tips': [
          'استخدم منتجات خالية من العطور',
          'اختبر المنتج أولاً',
          'تجنب المواد الكيميائية القاسية',
        ],
      },
    ];

    return Column(
      children:
          skinTypes.asMap().entries.map((entry) {
            final index = entry.key;
            final skinType = entry.value;

            return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Card(
                    margin: EdgeInsets.zero,

                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ExpansionTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: (skinType['color'] as Color).withValues(
                            alpha: 0.1,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          skinType['icon'] as IconData,
                          color: skinType['color'] as Color,
                          size: 24,
                        ),
                      ),
                      title: Text(
                        skinType['title'] as String,
                        style: getBoldStyle(
                          fontSize: 16,
                          fontFamily: FontConstant.cairo,
                        ),
                      ),
                      subtitle: Text(
                        skinType['description'] as String,
                        style: getRegularStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          fontFamily: FontConstant.cairo,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'نصائح للعناية:',
                                style: getSemiBoldStyle(
                                  fontSize: 14,
                                  fontFamily: FontConstant.cairo,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...(skinType['tips'] as List<String>).map(
                                (tip) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        margin: const EdgeInsets.only(
                                          top: 6,
                                          left: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: skinType['color'] as Color,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          tip,
                                          style: getRegularStyle(
                                            color: AppColors.textSecondary,
                                            fontSize: 13,
                                            fontFamily: FontConstant.cairo,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .animate()
                .fadeIn(delay: Duration(milliseconds: 200 * index))
                .slideX(begin: 0.1);
          }).toList(),
    );
  }
}
