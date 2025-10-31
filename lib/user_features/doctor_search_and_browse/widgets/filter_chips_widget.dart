import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FilterChipsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> activeFilters;
  final Function(int) onRemoveFilter;

  const FilterChipsWidget({
    super.key,
    required this.activeFilters,
    required this.onRemoveFilter,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (activeFilters.isEmpty) {
      return SizedBox.shrink();
    }

    return Container(
      height: screenHeight * 0.06,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: activeFilters.length,
        separatorBuilder: (context, index) => SizedBox(width: screenWidth * 0.02),
        itemBuilder: (context, index) {
          final filter = activeFilters[index];
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.03, 
              vertical: screenHeight * 0.01,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primary,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  filter["label"] as String,
                  style: getMediumStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontFamily: FontConstant.cairo,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                GestureDetector(
                  onTap: () => onRemoveFilter(index),
                  child: Icon(
                    Icons.close,
                    color: AppColors.primary,
                    size: screenWidth * 0.04,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
