import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FilterBottomSheetWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onApplyFilters;

  const FilterBottomSheetWidget({
    super.key,
    required this.onApplyFilters,
  });

  @override
  State<FilterBottomSheetWidget> createState() =>
      _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  String selectedSpecialty = "";
  double locationRadius = 10.0;
  String selectedAvailability = "";
  RangeValues priceRange = RangeValues(50, 500);
  double minRating = 0.0;

  final List<String> specialties = [
    "جميع التخصصات",
    "أمراض جلدية عامة",
    "جراحة تجميلية",
    "أمراض الشعر",
    "الأمراض الجلدية للأطفال",
    "علاج الليزر",
  ];

  final List<String> availabilityOptions = [
    "جميع الأوقات",
    "متاح اليوم",
    "متاح هذا الأسبوع",
    "متاح الشهر القادم",
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.8,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "تصفية النتائج",
                  style: getBoldStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontFamily: FontConstant.cairo,
                  ),
                ),
                TextButton(
                  onPressed: () => _resetFilters(),
                  child: Text(
                    "إعادة تعيين",
                    style: getMediumStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontFamily: FontConstant.cairo,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSpecialtySection(screenHeight),
                  SizedBox(height: screenHeight * 0.04),
                  _buildLocationSection(screenHeight),
                  SizedBox(height: screenHeight * 0.04),
                  _buildAvailabilitySection(screenHeight),
                  SizedBox(height: screenHeight * 0.04),
                  _buildPriceRangeSection(screenHeight),
                  SizedBox(height: screenHeight * 0.04),
                  _buildRatingSection(screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.06),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.border),
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "إلغاء",
                      style: getMediumStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontFamily: FontConstant.cairo,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _applyFilters(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "تطبيق",
                      style: getMediumStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: FontConstant.cairo,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialtySection(double screenHeight) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "التخصص",
          style: getBoldStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontFamily: FontConstant.cairo,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Wrap(
          spacing: screenWidth * 0.02,
          runSpacing: screenHeight * 0.01,
          children: specialties.map((specialty) {
            final isSelected = selectedSpecialty == specialty;
            return GestureDetector(
              onTap: () => setState(() => selectedSpecialty = specialty),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.015,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.border,
                  ),
                ),
                child: Text(
                  specialty,
                  style: getRegularStyle(
                    fontSize: 14,
                    fontFamily: FontConstant.cairo,
                    color: isSelected
                        ? Colors.white
                        : AppColors.textSecondary,
                
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLocationSection(double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "نطاق الموقع",
          style: getSemiBoldStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontFamily: FontConstant.cairo,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "1 كم",
              style: getRegularStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontFamily: FontConstant.cairo,
              ),
            ),
            Text(
              "${locationRadius.round()} كم",
              style: getSemiBoldStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontFamily: FontConstant.cairo,
              ),
            ),
            Text(
              "50 كم",
              style: getRegularStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontFamily: FontConstant.cairo,
              ),
            ),
          ],
        ),
        Slider(
          value: locationRadius,
          min: 1.0,
          max: 50.0,
          divisions: 49,
          onChanged: (value) => setState(() => locationRadius = value),
        ),
      ],
    );
  }

  Widget _buildAvailabilitySection(double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "التوفر",
          style: getSemiBoldStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontFamily: FontConstant.cairo,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Column(
          children: availabilityOptions.map((option) {
            return RadioListTile<String>(
              title: Text(
                option,
                style: getRegularStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontFamily: FontConstant.cairo,
                ),
              ),
              value: option,
              groupValue: selectedAvailability,
              onChanged: (value) =>
                  setState(() => selectedAvailability = value ?? ""),
              contentPadding: EdgeInsets.zero,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPriceRangeSection(double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "نطاق السعر",
          style: getSemiBoldStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontFamily: FontConstant.cairo,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${priceRange.start.round()} ريال",
              style: getSemiBoldStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontFamily: FontConstant.cairo,
              ),
            ),
            Text(
              "${priceRange.end.round()} ريال",
              style: getSemiBoldStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontFamily: FontConstant.cairo,
              ),
            ),
          ],
        ),
        RangeSlider(
          values: priceRange,
          min: 50.0,
          max: 1000.0,
          divisions: 19,
          onChanged: (values) => setState(() => priceRange = values),
        ),
      ],
    );
  }

  Widget _buildRatingSection(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "التقييم الأدنى",
          style: getSemiBoldStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontFamily: FontConstant.cairo,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Row(
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => setState(() => minRating = index + 1.0),
              child: Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.01),
                child: Icon(
                  Icons.star,
                  color: index < minRating
                      ? Colors.amber
                      : AppColors.border,
                  size: screenWidth * 0.08,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  void _resetFilters() {
    setState(() {
      selectedSpecialty = "";
      locationRadius = 10.0;
      selectedAvailability = "";
      priceRange = RangeValues(50, 500);
      minRating = 0.0;
    });
  }

  void _applyFilters() {
    final filters = {
      "specialty": selectedSpecialty,
      "locationRadius": locationRadius,
      "availability": selectedAvailability,
      "priceRange": priceRange,
      "minRating": minRating,
    };
    widget.onApplyFilters(filters);
    Navigator.pop(context);
  }
}
