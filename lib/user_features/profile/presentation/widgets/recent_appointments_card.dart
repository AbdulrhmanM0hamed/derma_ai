import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/utils/constant/font_manger.dart';
import '../../../../../core/utils/constant/styles_manger.dart';
import '../../../../../core/utils/theme/app_colors.dart';
import '../../../../../l10n/app_localizations.dart';

class RecentAppointmentsCard extends StatelessWidget {
  const RecentAppointmentsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final appointments = [
      {
        'doctor': 'د. سارة أحمد',
        'date': '20 أكتوبر 2025',
        'time': '10:00 ص',
        'type': l10n.videoCall,
        'status': l10n.upcoming,
        'statusColor': Colors.green,
      },
      {
        'doctor': 'د. محمد حسان',
        'date': '18 أكتوبر 2025',
        'time': '2:00 م',
        'type': l10n.clinicVisit,
        'status': l10n.completed,
        'statusColor': Colors.grey,
      },
    ];

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.recentAppointments,
                  style: getBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        l10n.viewAllButton,
                        style: getSemiBoldStyle(
                          fontFamily: FontConstant.cairo,
                          fontSize: 12,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            ...appointments.map(
              (apt) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            apt['doctor'] as String,
                            style: getSemiBoldStyle(
                              fontFamily: FontConstant.cairo,
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: (apt['statusColor'] as Color).withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              apt['status'] as String,
                              style: getSemiBoldStyle(
                                fontFamily: FontConstant.cairo,
                                fontSize: 10,
                                color: apt['statusColor'] as Color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            apt['date'] as String,
                            style: getRegularStyle(
                              fontFamily: FontConstant.cairo,
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            ' • ',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Text(
                            apt['time'] as String,
                            style: getRegularStyle(
                              fontFamily: FontConstant.cairo,
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            ' • ',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Text(
                            apt['type'] as String,
                            style: getRegularStyle(
                              fontFamily: FontConstant.cairo,
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideX(begin: 0.3);
  }
}
