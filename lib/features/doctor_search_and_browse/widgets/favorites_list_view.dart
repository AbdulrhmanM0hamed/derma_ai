import 'package:flutter/material.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'doctor_card_widget.dart';

class FavoritesListView extends StatelessWidget {
  final List<Map<String, dynamic>> doctors;
  final void Function(Map<String, dynamic>) onDoctorTap;
  final void Function(Map<String, dynamic>) onFavoriteToggle;
  final void Function(Map<String, dynamic>) onShareDoctor;
  final void Function(Map<String, dynamic>) onMessageDoctor;

  const FavoritesListView({
    super.key,
    required this.doctors,
    required this.onDoctorTap,
    required this.onFavoriteToggle,
    required this.onShareDoctor,
    required this.onMessageDoctor,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final favoriteDoctors = doctors.where((doctor) => doctor["isFavorite"] as bool).toList();

    if (favoriteDoctors.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              color: AppColors.textSecondary,
              size: MediaQuery.of(context).size.width * 0.2,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Text(
              "لا توجد أطباء مفضلين",
              style: getBoldStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontFamily: FontConstant.cairo,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              "أضف الأطباء إلى المفضلة لسهولة الوصول إليهم",
              style: getRegularStyle(
                color: AppColors.textSecondary,
                fontSize: 16,
                fontFamily: FontConstant.cairo,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(bottom: screenHeight * 0.2),
      itemCount: favoriteDoctors.length,
      itemBuilder: (context, index) {
        final doctor = favoriteDoctors[index];
        return DoctorCardWidget(
          doctor: doctor,
          heroTagSuffix: "_favorites",
          onTap: () => onDoctorTap(doctor),
          onFavorite: () => onFavoriteToggle(doctor),
          onShare: () => onShareDoctor(doctor),
          onMessage: () => onMessageDoctor(doctor),
        );
      },
    );
  }
}
