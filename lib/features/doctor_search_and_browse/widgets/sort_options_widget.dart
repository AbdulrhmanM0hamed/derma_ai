import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SortOptionsWidget extends StatelessWidget {
  final Function(String) onSortSelected;

  const SortOptionsWidget({Key? key, required this.onSortSelected})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final sortOptions = [
      {"key": "nearest", "label": "الأقرب", "icon": "location_on"},
      {"key": "rating", "label": "الأعلى تقييماً", "icon": "star"},
      {"key": "availability", "label": "الأسرع موعداً", "icon": "schedule"},
      {"key": "price", "label": "الأقل سعراً", "icon": "attach_money"},
    ];

    return Container(
      height: screenHeight * 0.4,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            width: screenWidth * 0.12,
            height: screenHeight * 0.005,
            margin: EdgeInsets.only(top: screenHeight * 0.02),
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Text(
              "ترتيب النتائج",
              style: getSemiBoldStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontFamily: FontConstant.cairo,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              itemCount: sortOptions.length,
              separatorBuilder:
                  (context, index) => Divider(
                    color: AppColors.border.withValues(alpha: 0.2),
                  ),
              itemBuilder: (context, index) {
                final option = sortOptions[index];
                return ListTile(
                  leading: Icon(
                    _getIconForOption(option["key"] as String),
                    color: AppColors.primary,
                    size: screenWidth * 0.06,
                  ),
                  title: Text(
                    option["label"] as String,
                    style: getRegularStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontFamily: FontConstant.cairo,
                    ),
                  ),
                  onTap: () {
                    onSortSelected(option["key"] as String);
                    Navigator.pop(context);
                  },
                  contentPadding: EdgeInsets.zero,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForOption(String key) {
    switch (key) {
      case "nearest":
        return Icons.location_on;
      case "rating":
        return Icons.star;
      case "availability":
        return Icons.schedule;
      case "price":
        return Icons.attach_money;
      default:
        return Icons.sort;
    }
  }
}
