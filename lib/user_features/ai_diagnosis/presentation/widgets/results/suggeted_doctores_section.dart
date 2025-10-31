import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../core/utils/theme/app_colors.dart';

class SuggestedDoctorsSection extends StatelessWidget {
  final List<Map<String, dynamic>> suggestedDoctors;

  const SuggestedDoctorsSection({super.key, required this.suggestedDoctors});

  @override
  Widget build(BuildContext context) {
    if (suggestedDoctors.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'أطباء مقترحون',
                style: getSemiBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 20,
                  color: AppColors.primary,
                ),
                textDirection: TextDirection.rtl,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/doctor-search-and-browse');
                },
                child: Text('عرض الكل', textDirection: TextDirection.rtl),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:
                suggestedDoctors.length > 5 ? 5 : suggestedDoctors.length,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04,
            ),
            itemBuilder: (context, index) {
              final doctor = suggestedDoctors[index];
              return SuggestedDoctorCard(
                doctor: doctor,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/doctor-profile',
                    arguments: doctor,
                  );
                },
              ).animate().fadeIn(delay: (200 * index).ms).slideX(begin: 0.5);
            },
          ),
        ),
      ],
    );
  }
}

class SuggestedDoctorCard extends StatelessWidget {
  final Map<String, dynamic> doctor;
  final VoidCallback onTap;

  const SuggestedDoctorCard({
    super.key,
    required this.doctor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        margin: const EdgeInsets.only(left: 16 , bottom: 4),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 8,
          shadowColor: AppColors.primary.withValues(alpha: 0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'suggested_doctor_${doctor["id"]}',
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      doctor["profileImage"] as String,
                    ),
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  doctor["name"] as String,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 4),
                Text(
                  doctor["specialty"] as String,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: AppColors.warning, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      doctor["rating"].toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
