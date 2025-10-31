import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class ProductRecommendationCard extends StatelessWidget {
  const ProductRecommendationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'name': 'غسول CeraVe المرطب',
        'category': 'تنظيف',
        'price': '120 ج.م',
        'rating': 4.8,
        'description': 'غسول لطيف للبشرة الجافة والحساسة',
        'benefits': [
          'يحتوي على السيراميد',
          'خالي من العطور',
          'مناسب للاستخدام اليومي',
        ],
        'color': const Color(0xFF4CAF50),
        'icon': Icons.soap_outlined,
      },
      {
        'name': 'سيروم The Ordinary Niacinamide',
        'category': 'علاج',
        'price': '85 ج.م',
        'rating': 4.6,
        'description': 'سيروم لتقليل حجم المسام والتحكم في الزيوت',
        'benefits': [
          'يقلل من المسام الواسعة',
          'ينظم إفراز الزيوت',
          'يحسن ملمس البشرة',
        ],
        'color': const Color(0xFF2196F3),
        'icon': Icons.opacity_outlined,
      },
      {
        'name': 'كريم Neutrogena المرطب',
        'category': 'ترطيب',
        'price': '95 ج.م',
        'rating': 4.7,
        'description': 'كريم مرطب للوجه والجسم',
        'benefits': [
          'ترطيب يدوم 24 ساعة',
          'امتصاص سريع',
          'مناسب لجميع أنواع البشرة',
        ],
        'color': const Color(0xFF9C27B0),
        'icon': Icons.favorite_outline,
      },
      {
        'name': 'واقي الشمس La Roche-Posay',
        'category': 'حماية',
        'price': '180 ج.م',
        'rating': 4.9,
        'description': 'واقي شمس SPF 50 للبشرة الحساسة',
        'benefits': [
          'حماية عالية من الأشعة',
          'مقاوم للماء',
          'لا يترك أثر أبيض',
        ],
        'color': const Color(0xFFFF9800),
        'icon': Icons.wb_sunny_outlined,
      },
    ];

    return Column(
      children:
          products.asMap().entries.map((entry) {
            final index = entry.key;
            final product = entry.value;

            return Card(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      // Product header
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              (product['color'] as Color).withValues(
                                alpha: 0.1,
                              ),
                              (product['color'] as Color).withValues(
                                alpha: 0.05,
                              ),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: (product['color'] as Color).withValues(
                                  alpha: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                product['icon'] as IconData,
                                color: product['color'] as Color,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name'] as String,
                                    style: getBoldStyle(
                                      fontSize: 16,
                                      fontFamily: FontConstant.cairo,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: (product['color'] as Color)
                                              .withValues(alpha: 0.2),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          product['category'] as String,
                                          style: getRegularStyle(
                                            color: product['color'] as Color,
                                            fontSize: 12,
                                            fontFamily: FontConstant.cairo,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${product['rating']}',
                                            style: getSemiBoldStyle(
                                              fontSize: 14,
                                              fontFamily: FontConstant.cairo,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  product['price'] as String,
                                  style: getBoldStyle(
                                    color: product['color'] as Color,
                                    fontSize: 16,
                                    fontFamily: FontConstant.cairo,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Product details
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['description'] as String,
                              style: getRegularStyle(
                                color: AppColors.textSecondary,
                                fontSize: 14,
                                fontFamily: FontConstant.cairo,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'الفوائد:',
                              style: getSemiBoldStyle(
                                color: AppColors.textPrimary,
                                fontSize: 14,
                                fontFamily: FontConstant.cairo,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ...(product['benefits'] as List<String>).map(
                              (benefit) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      margin: const EdgeInsets.only(
                                        top: 6,
                                        left: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: product['color'] as Color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        benefit,
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
                            const SizedBox(height: 16),

                            // Action buttons
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      // Add to favorites
                                    },
                                    icon: const Icon(
                                      Icons.favorite_border,
                                      size: 18,
                                    ),
                                    label: Text(
                                      'إضافة للمفضلة',
                                      style: getSemiBoldStyle(
                                        fontSize: 14,
                                        fontFamily: FontConstant.cairo,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: (product['color']
                                              as Color)
                                          .withValues(alpha: 0.1),
                                      foregroundColor:
                                          product['color'] as Color,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      // View product details
                                    },
                                    icon: const Icon(
                                      Icons.info_outline,
                                      size: 18,
                                    ),
                                    label: Text(
                                      'تفاصيل أكثر',
                                      style: getSemiBoldStyle(
                                        fontSize: 14,
                                        fontFamily: FontConstant.cairo,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          product['color'] as Color,
                                      foregroundColor: Colors.white,
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(delay: Duration(milliseconds: 200 * index))
                .slideY(begin: 0.1);
          }).toList(),
    );
  }
}
