import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../../core/utils/constant/font_manger.dart';
import '../../../../../core/utils/constant/styles_manger.dart';
import '../../../../../l10n/app_localizations.dart';
import '../pages/settings_page.dart';

class ProfileMenuItems extends StatelessWidget {
  const ProfileMenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final menuItems = [
      {
        'id': 'personal',
        'icon': Icons.person_outline,
        'label': l10n.personalInfo,
        'color': Colors.blue,
      },
      {
        'id': 'appointments',
        'icon': Icons.calendar_today_outlined,
        'label': l10n.myAppointments,
        'color': Colors.green,
      },
      {
        'id': 'saved',
        'icon': Icons.favorite_outline,
        'label': l10n.savedDoctors,
        'color': Colors.red,
      },
      {
        'id': 'settings',
        'icon': Icons.settings_outlined,
        'label': l10n.settings,
        'color': Colors.purple,
      },
    ];

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children:
            menuItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isLast = index == menuItems.length - 1;

              return Container(
                decoration: BoxDecoration(
                  border:
                      isLast
                          ? null
                          : Border(
                            bottom: BorderSide(color: Colors.grey[200]!),
                          ),
                ),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: (item['color'] as Color).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: item['color'] as Color,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    item['label'] as String,
                    style: getSemiBoldStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey[400],
                  ),
                  onTap: () {
                    if (item['id'] == 'settings') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ),
                      );
                    }
                    // Handle other navigation
                  },
                ),
              );
            }).toList(),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: 0.3);
  }
}
