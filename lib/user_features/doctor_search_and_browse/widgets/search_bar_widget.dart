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
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.015),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: Colors.grey.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: TextField(
                controller: controller,
                textDirection: TextDirection.rtl,
                onChanged: onSearchChanged,
                style: getRegularStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 14,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  hintText: "ابحث عن طبيب أو تخصص...",
                  hintStyle: getRegularStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                    fontFamily: FontConstant.cairo,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.03),
                    child: Icon(
                      Icons.search_rounded,
                      color: Colors.grey[500],
                      size: 22,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04, 
                    vertical: screenHeight * 0.018,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              width: screenWidth * 0.13,
              height: screenWidth * 0.13,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.tune_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
