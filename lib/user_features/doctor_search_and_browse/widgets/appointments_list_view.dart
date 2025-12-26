import 'package:flutter/material.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';

class AppointmentsListView extends StatelessWidget {
  final TabController tabController;

  const AppointmentsListView({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            color: AppColors.textSecondary,
            size: MediaQuery.of(context).size.width * 0.2,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Text(
            "لا توجد حجوزات",
            style: getBoldStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontFamily: FontConstant.cairo,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Text(
            "احجز موعدك الأول مع أحد الأطباء المتخصصين",
            style: getRegularStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
              fontFamily: FontConstant.cairo,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ElevatedButton(
            onPressed: () => tabController.animateTo(0),
            child: Text("تصفح الأطباء"),
          ),
        ],
      ),
    );
  }
}
