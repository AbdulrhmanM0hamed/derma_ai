import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onFilterTap;
  final Function(String) onSearchChanged;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onFilterTap,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                textDirection: TextDirection.rtl,
                onChanged: onSearchChanged,
                decoration: InputDecoration(
                  hintText: "ابحث عن طبيب...",
                  hintStyle: getRegularStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    fontFamily: FontConstant.cairo,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Icon(
                      Icons.search,
                      color: AppColors.textSecondary,
                      size: screenWidth * 0.06,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.04),
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              width: screenWidth * 0.12,
              height: screenWidth * 0.12,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.tune,
                  color: Colors.white,
                  size: screenWidth * 0.06,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
