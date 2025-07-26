import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/widgets/custom_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: getBoldStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontFamily: FontConstant.cairo,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildStats(),
            const SizedBox(height: 24),
            _buildMenuItems(),
            const SizedBox(height: 24),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 2,
                  ),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://randomuser.me/api/portraits/women/44.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ).animate(effects: fadeInScaleUp(
                duration: 300.ms,
                begin: 0.8,
              )),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ).animate(effects: fadeIn(
                duration: 300.ms,
              )),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Sarah Johnson',
            style: getBoldStyle(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontFamily: FontConstant.cairo,
            ),
          ).animate(effects: fadeIn(
            duration: 300.ms,
            delay: 150.ms,
          )),
          const SizedBox(height: 4),
          Text(
            'sarah.johnson@example.com',
            style: getRegularStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontFamily: FontConstant.cairo,
            ),
          ).animate(effects: fadeIn(
            duration: 300.ms,
            delay: 150.ms,
          )),
          const SizedBox(height: 16),
          Animate(
            effects: fadeIn(
              duration: 300.ms,
              delay: 200.ms,
            ),
            child: CustomButton(
              text: 'Edit Profile',
              onPressed: () {
                // Navigate to edit profile
              },
              type: ButtonType.outline,
              height: 40,
              width: 150,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          _buildStatItem('Appointments', '12'),
          _buildStatItem('Diagnoses', '8'),
          _buildStatItem('Doctors', '5'),
        ],
      ),
    ).animate(effects: fadeIn(
      duration: 300.ms,
      delay: 300.ms,
    ));
  }

  Widget _buildStatItem(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            Text(
              value,
              style: getBoldStyle(
                color: AppColors.primary,
                fontSize: 24,
                fontFamily: FontConstant.cairo,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: getRegularStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontFamily: FontConstant.cairo,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.calendar_today_outlined,
            title: 'My Appointments',
            onTap: () {
              // Navigate to appointments
            },
          ),
          _buildMenuItem(
            icon: Icons.medical_services_outlined,
            title: 'My Diagnoses',
            onTap: () {
              // Navigate to diagnoses
            },
          ),
          _buildMenuItem(
            icon: Icons.favorite_border,
            title: 'Favorite Doctors',
            onTap: () {
              // Navigate to favorite doctors
            },
          ),
          _buildMenuItem(
            icon: Icons.payment_outlined,
            title: 'Payment Methods',
            onTap: () {
              // Navigate to payment methods
            },
          ),
          _buildMenuItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {
              // Navigate to help & support
            },
          ),
          _buildMenuItem(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () {
              // Navigate to privacy policy
            },
          ),
        ],
      ),
    ).animate(effects: fadeIn(
      duration: 300.ms,
      delay: 400.ms,
    ));
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: getRegularStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontFamily: FontConstant.cairo,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textSecondary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomButton(
        text: 'Logout',
        onPressed: () {
          _showLogoutDialog();
        },
        type: ButtonType.outline,
        width: double.infinity,
        height: 56,
        icon: Icons.logout,
      ),
    ).animate(effects: fadeIn(
      duration: 300.ms,
      delay: 500.ms,
    ));
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Logout',
          style: getBoldStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontFamily: FontConstant.cairo,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: getRegularStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontFamily: FontConstant.cairo,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: getSemiBoldStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontFamily: FontConstant.cairo,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate to login
              context.go('/login');
            },
            child: Text(
              'Logout',
              style: getSemiBoldStyle(
                color: AppColors.error,
                fontSize: 14,
                fontFamily: FontConstant.cairo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}