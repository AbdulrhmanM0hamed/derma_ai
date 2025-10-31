import 'package:flutter/material.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/logout_confirmation_dialog.dart';

class DoctorProfilePage extends StatelessWidget {
  const DoctorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.profile ?? "Profile",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to edit profile page
            },
            icon: const Icon(Icons.edit_outlined, color: AppColors.textSecondary),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(context),
            const SizedBox(height: 24),
            _buildStatsRow(),
            const SizedBox(height: 24),
            _buildSectionTitle(context, "Personal Information"),
            _buildInfoCard([
              _buildInfoItem(Icons.person_outline, "Name", "Dr. Mohammed Ahmed"),
              _buildInfoItem(Icons.medical_services_outlined, "Speciality", "Dermatologist"),
              _buildInfoItem(Icons.email_outlined, "Email", "dr.mohammed@dermaai.com"),
              _buildInfoItem(Icons.phone_outlined, "Phone", "+201234567890"),
            ]),
            const SizedBox(height: 16),
            _buildSectionTitle(context, "Professional Information"),
            _buildInfoCard([
              _buildInfoItem(Icons.school_outlined, "Education", "Cairo University, Faculty of Medicine"),
              _buildInfoItem(Icons.work_outline, "Experience", "15 years"),
              _buildInfoItem(Icons.language_outlined, "Languages", "Arabic, English"),
              _buildInfoItem(Icons.location_on_outlined, "Clinic Location", "Cairo, Egypt"),
            ]),
            const SizedBox(height: 16),
            _buildSectionTitle(context, "Account Settings"),
            _buildSettingsCard(context),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary,
              backgroundImage: null, // Replace with actual image
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              "Dr. Mohammed Ahmed",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Dermatologist",
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRatingInfo(),
                Container(
                  height: 24,
                  width: 1,
                  color: Colors.grey[300],
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                ),
                _buildExperienceInfo(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingInfo() {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
          size: 20,
        ),
        const SizedBox(width: 4),
        const Text(
          "4.9",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          "(124 reviews)",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceInfo() {
    return Row(
      children: [
        const Icon(
          Icons.work_outlined,
          color: AppColors.primary,
          size: 20,
        ),
        const SizedBox(width: 4),
        const Text(
          "15+",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          "years exp.",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    final stats = [
      {"value": "1,240", "label": "Patients"},
      {"value": "3,250", "label": "Consultations"},
      {"value": "15", "label": "Years Exp."},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: stats.map((stat) {
        return Expanded(
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Text(
                    stat["value"]!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stat["label"]!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.primary,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context) {
    final settings = [
      {
        "icon": Icons.notifications_outlined,
        "title": "Notifications",
        "onTap": () {},
      },
      {
        "icon": Icons.lock_outlined,
        "title": "Privacy & Security",
        "onTap": () {},
      },
      {
        "icon": Icons.language_outlined,
        "title": "Language",
        "onTap": () {},
      },
      {
        "icon": Icons.help_outline,
        "title": "Help & Support",
        "onTap": () {},
      },
      {
        "icon": Icons.logout,
        "title": "Logout",
        "onTap": () {
          LogoutConfirmationDialog.show(context);
        },
      },
    ];

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Column(
        children: settings.asMap().entries.map((entry) {
          final index = entry.key;
          final setting = entry.value;
          
          return Column(
            children: [
              ListTile(
                leading: Icon(
                  setting["icon"] as IconData,
                  color: setting["title"] == "Logout" 
                      ? Colors.red 
                      : AppColors.primary,
                ),
                title: Text(
                  setting["title"] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: setting["title"] == "Logout" 
                        ? Colors.red 
                        : AppColors.textPrimary,
                  ),
                ),
                trailing: setting["title"] != "Logout"
                    ? const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: AppColors.textSecondary,
                      )
                    : null,
                onTap: setting["onTap"] as void Function(),
              ),
              if (index < settings.length - 1)
                const Divider(height: 1, indent: 56),
            ],
          );
        }).toList(),
      ),
    );
  }
}
