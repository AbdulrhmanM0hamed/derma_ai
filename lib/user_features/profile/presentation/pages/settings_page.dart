import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _biometricEnabled = false;
  bool _locationEnabled = true;
  String _selectedLanguage = 'العربية';
  String _selectedTheme = 'فاتح';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildAccountSection(),
            const SizedBox(height: 16),
            _buildNotificationSection(),
            const SizedBox(height: 16),
            _buildSecuritySection(),
            const SizedBox(height: 16),
            _buildAppearanceSection(),
            const SizedBox(height: 16),
            _buildSupportSection(),
            const SizedBox(height: 16),
            _buildAboutSection(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.grey[700]),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'الإعدادات',
        style: getBoldStyle(
          fontFamily: FontConstant.cairo,
          fontSize: 18,
          color: Colors.black87,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildAccountSection() {
    return _buildSection(
      title: 'الحساب',
      icon: Icons.person_outline,
      children: [
        _buildSettingItem(
          icon: Icons.edit_outlined,
          title: 'تعديل الملف الشخصي',
          subtitle: 'تحديث معلوماتك الشخصية',
          onTap: () {},
          showArrow: true,
        ),
        _buildSettingItem(
          icon: Icons.lock_outline,
          title: 'تغيير كلمة المرور',
          subtitle: 'تحديث كلمة المرور الخاصة بك',
          onTap: () {},
          showArrow: true,
        ),
        _buildSettingItem(
          icon: Icons.email_outlined,
          title: 'تغيير البريد الإلكتروني',
          subtitle: 'تحديث عنوان البريد الإلكتروني',
          onTap: () {},
          showArrow: true,
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3);
  }

  Widget _buildNotificationSection() {
    return _buildSection(
      title: 'الإشعارات',
      icon: Icons.notifications_outlined,
      children: [
        _buildSwitchItem(
          icon: Icons.notifications_active_outlined,
          title: 'إشعارات التطبيق',
          subtitle: 'تلقي إشعارات حول المواعيد والتذكيرات',
          value: _notificationsEnabled,
          onChanged: (value) {
            setState(() {
              _notificationsEnabled = value;
            });
          },
        ),
        _buildSettingItem(
          icon: Icons.schedule_outlined,
          title: 'تذكيرات المواعيد',
          subtitle: 'إدارة تذكيرات المواعيد',
          onTap: () {},
          showArrow: true,
        ),
        _buildSettingItem(
          icon: Icons.medical_services_outlined,
          title: 'تذكيرات الأدوية',
          subtitle: 'إعداد تذكيرات تناول الأدوية',
          onTap: () {},
          showArrow: true,
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.3);
  }

  Widget _buildSecuritySection() {
    return _buildSection(
      title: 'الأمان والخصوصية',
      icon: Icons.security_outlined,
      children: [
        _buildSwitchItem(
          icon: Icons.fingerprint_outlined,
          title: 'المصادقة البيومترية',
          subtitle: 'استخدام بصمة الإصبع أو الوجه',
          value: _biometricEnabled,
          onChanged: (value) {
            setState(() {
              _biometricEnabled = value;
            });
          },
        ),
        _buildSwitchItem(
          icon: Icons.location_on_outlined,
          title: 'خدمات الموقع',
          subtitle: 'السماح بالوصول لموقعك',
          value: _locationEnabled,
          onChanged: (value) {
            setState(() {
              _locationEnabled = value;
            });
          },
        ),
        _buildSettingItem(
          icon: Icons.privacy_tip_outlined,
          title: 'سياسة الخصوصية',
          subtitle: 'اقرأ سياسة الخصوصية',
          onTap: () {},
          showArrow: true,
        ),
        _buildSettingItem(
          icon: Icons.description_outlined,
          title: 'شروط الاستخدام',
          subtitle: 'مراجعة شروط وأحكام الاستخدام',
          onTap: () {},
          showArrow: true,
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.3);
  }

  Widget _buildAppearanceSection() {
    return _buildSection(
      title: 'المظهر واللغة',
      icon: Icons.palette_outlined,
      children: [
        _buildDropdownItem(
          icon: Icons.language_outlined,
          title: 'اللغة',
          subtitle: 'اختر لغة التطبيق',
          value: _selectedLanguage,
          items: ['العربية', 'English'],
          onChanged: (value) {
            setState(() {
              _selectedLanguage = value!;
            });
          },
        ),
        _buildDropdownItem(
          icon: Icons.brightness_6_outlined,
          title: 'المظهر',
          subtitle: 'اختر مظهر التطبيق',
          value: _selectedTheme,
          items: ['فاتح', 'داكن', 'تلقائي'],
          onChanged: (value) {
            setState(() {
              _selectedTheme = value!;
            });
          },
        ),
        _buildSettingItem(
          icon: Icons.text_fields_outlined,
          title: 'حجم الخط',
          subtitle: 'تخصيص حجم النص',
          onTap: () {},
          showArrow: true,
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 600.ms).slideY(begin: 0.3);
  }

  Widget _buildSupportSection() {
    return _buildSection(
      title: 'الدعم والمساعدة',
      icon: Icons.help_outline,
      children: [
        _buildSettingItem(
          icon: Icons.help_center_outlined,
          title: 'مركز المساعدة',
          subtitle: 'الأسئلة الشائعة والمساعدة',
          onTap: () {},
          showArrow: true,
        ),
        _buildSettingItem(
          icon: Icons.contact_support_outlined,
          title: 'تواصل معنا',
          subtitle: 'احصل على المساعدة من فريق الدعم',
          onTap: () {},
          showArrow: true,
        ),
        _buildSettingItem(
          icon: Icons.bug_report_outlined,
          title: 'الإبلاغ عن مشكلة',
          subtitle: 'أخبرنا عن أي مشاكل تواجهها',
          onTap: () {},
          showArrow: true,
        ),
        _buildSettingItem(
          icon: Icons.star_outline,
          title: 'تقييم التطبيق',
          subtitle: 'قيم تجربتك مع التطبيق',
          onTap: () {},
          showArrow: true,
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 800.ms).slideY(begin: 0.3);
  }

  Widget _buildAboutSection() {
    return _buildSection(
      title: 'حول التطبيق',
      icon: Icons.info_outline,
      children: [
        _buildSettingItem(
          icon: Icons.info_outlined,
          title: 'معلومات التطبيق',
          subtitle: 'الإصدار 1.0.0',
          onTap: () {},
          showArrow: true,
        ),
        _buildSettingItem(
          icon: Icons.update_outlined,
          title: 'التحديثات',
          subtitle: 'البحث عن تحديثات جديدة',
          onTap: () {},
          showArrow: true,
        ),
        _buildSettingItem(
          icon: Icons.logout,
          title: 'تسجيل الخروج',
          subtitle: 'الخروج من الحساب الحالي',
          onTap: () => _showLogoutDialog(),
          showArrow: false,
          titleColor: Colors.red,
          iconColor: Colors.red,
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 1000.ms).slideY(begin: 0.3);
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
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
                const SizedBox(width: 12),
                Text(
                  title,
                  style: getBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool showArrow = false,
    Color? titleColor,
    Color? iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[200]!, width: 0.5),
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (iconColor ?? Colors.grey[600])!.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: iconColor ?? Colors.grey[600],
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: getSemiBoldStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 14,
            color: titleColor ?? Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        trailing: showArrow
            ? Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              )
            : null,
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[200]!, width: 0.5),
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[600]!.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.grey[600],
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: getSemiBoldStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildDropdownItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[200]!, width: 0.5),
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[600]!.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.grey[600],
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: getSemiBoldStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        trailing: DropdownButton<String>(
          value: value,
          underline: const SizedBox(),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: getRegularStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 12,
                  color: Colors.black87,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'تسجيل الخروج',
            style: getBoldStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          content: Text(
            'هل أنت متأكد من أنك تريد تسجيل الخروج من حسابك؟',
            style: getRegularStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'إلغاء',
                style: getSemiBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Handle logout logic here
              },
              child: Text(
                'تسجيل الخروج',
                style: getSemiBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
