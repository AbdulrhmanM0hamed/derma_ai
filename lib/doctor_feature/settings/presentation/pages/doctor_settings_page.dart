import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/animations/app_animations.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_item.dart';
import '../widgets/profile_header.dart';

class DoctorSettingsPage extends StatefulWidget {
  const DoctorSettingsPage({super.key});

  @override
  State<DoctorSettingsPage> createState() => _DoctorSettingsPageState();
}

class _DoctorSettingsPageState extends State<DoctorSettingsPage> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  final bool _darkMode = false;
  bool _autoBackup = true;
  final String _selectedLanguage = 'العربية';
  final String _selectedTheme = 'فاتح';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'الإعدادات',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showSearchDialog(),
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            ProfileHeader(
              doctorName: 'د. محمد أحمد',
              speciality: 'طبيب أمراض جلدية',
              rating: 4.9,
              patientsCount: 1247,
              onEditProfile: () => _editProfile(),
            ),
            
            const SizedBox(height: 20),
            
            // Settings Sections
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Account Settings
                  SettingsSection(
                    title: 'إعدادات الحساب',
                    icon: Icons.person,
                    children: [
                      SettingsItem(
                        title: 'المعلومات الشخصية',
                        subtitle: 'تعديل الاسم والصورة والمعلومات',
                        icon: Icons.edit,
                        onTap: () => _editPersonalInfo(),
                      ),
                      SettingsItem(
                        title: 'المعلومات المهنية',
                        subtitle: 'التخصص والخبرة والشهادات',
                        icon: Icons.work,
                        onTap: () => _editProfessionalInfo(),
                      ),
                      SettingsItem(
                        title: 'تغيير كلمة المرور',
                        subtitle: 'تحديث كلمة المرور الخاصة بك',
                        icon: Icons.lock,
                        onTap: () => _changePassword(),
                      ),
                      SettingsItem(
                        title: 'إعدادات الأمان',
                        subtitle: 'المصادقة الثنائية والأمان',
                        icon: Icons.security,
                        onTap: () => _securitySettings(),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Clinic Settings
                  SettingsSection(
                    title: 'إعدادات العيادة',
                    icon: Icons.local_hospital,
                    children: [
                      SettingsItem(
                        title: 'معلومات العيادة',
                        subtitle: 'العنوان وساعات العمل والاتصال',
                        icon: Icons.location_on,
                        onTap: () => _clinicInfo(),
                      ),
                      SettingsItem(
                        title: 'أوقات العمل',
                        subtitle: 'تحديد أوقات المواعيد المتاحة',
                        icon: Icons.schedule,
                        onTap: () => _workingHours(),
                      ),
                      SettingsItem(
                        title: 'أسعار الخدمات',
                        subtitle: 'تحديد أسعار الاستشارات والخدمات',
                        icon: Icons.attach_money,
                        onTap: () => _servicePrices(),
                      ),
                      SettingsItem(
                        title: 'إعدادات المواعيد',
                        subtitle: 'مدة الجلسة والفترات المتاحة',
                        icon: Icons.calendar_today,
                        onTap: () => _appointmentSettings(),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Notifications
                  SettingsSection(
                    title: 'الإشعارات',
                    icon: Icons.notifications,
                    children: [
                      SettingsItem(
                        title: 'تفعيل الإشعارات',
                        subtitle: 'تلقي إشعارات التطبيق',
                        icon: Icons.notifications_active,
                        trailing: Switch(
                          value: _notificationsEnabled,
                          onChanged: (value) {
                            setState(() {
                              _notificationsEnabled = value;
                            });
                          },
                          activeThumbColor: AppColors.primary,
                        ),
                      ),
                      SettingsItem(
                        title: 'إشعارات البريد الإلكتروني',
                        subtitle: 'تلقي إشعارات عبر البريد الإلكتروني',
                        icon: Icons.email,
                        trailing: Switch(
                          value: _emailNotifications,
                          onChanged: (value) {
                            setState(() {
                              _emailNotifications = value;
                            });
                          },
                          activeThumbColor: AppColors.primary,
                        ),
                      ),
                      SettingsItem(
                        title: 'إشعارات الرسائل النصية',
                        subtitle: 'تلقي إشعارات عبر SMS',
                        icon: Icons.sms,
                        trailing: Switch(
                          value: _smsNotifications,
                          onChanged: (value) {
                            setState(() {
                              _smsNotifications = value;
                            });
                          },
                          activeThumbColor: AppColors.primary,
                        ),
                      ),
                      SettingsItem(
                        title: 'إعدادات الإشعارات المتقدمة',
                        subtitle: 'تخصيص أنواع الإشعارات',
                        icon: Icons.tune,
                        onTap: () => _advancedNotifications(),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // App Settings
                  SettingsSection(
                    title: 'إعدادات التطبيق',
                    icon: Icons.settings,
                    children: [
                      SettingsItem(
                        title: 'اللغة',
                        subtitle: _selectedLanguage,
                        icon: Icons.language,
                        onTap: () => _changeLanguage(),
                      ),
                      SettingsItem(
                        title: 'المظهر',
                        subtitle: _selectedTheme,
                        icon: Icons.palette,
                        onTap: () => _changeTheme(),
                      ),
                      SettingsItem(
                        title: 'النسخ الاحتياطي التلقائي',
                        subtitle: 'نسخ احتياطي للبيانات تلقائياً',
                        icon: Icons.backup,
                        trailing: Switch(
                          value: _autoBackup,
                          onChanged: (value) {
                            setState(() {
                              _autoBackup = value;
                            });
                          },
                          activeThumbColor: AppColors.primary,
                        ),
                      ),
                      SettingsItem(
                        title: 'مسح البيانات المؤقتة',
                        subtitle: 'تحرير مساحة التخزين',
                        icon: Icons.cleaning_services,
                        onTap: () => _clearCache(),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Data & Privacy
                  SettingsSection(
                    title: 'البيانات والخصوصية',
                    icon: Icons.privacy_tip,
                    children: [
                      SettingsItem(
                        title: 'إدارة البيانات',
                        subtitle: 'تصدير أو حذف بياناتك',
                        icon: Icons.data_usage,
                        onTap: () => _dataManagement(),
                      ),
                      SettingsItem(
                        title: 'سياسة الخصوصية',
                        subtitle: 'اطلع على سياسة الخصوصية',
                        icon: Icons.policy,
                        onTap: () => _privacyPolicy(),
                      ),
                      SettingsItem(
                        title: 'شروط الاستخدام',
                        subtitle: 'اطلع على شروط الاستخدام',
                        icon: Icons.description,
                        onTap: () => _termsOfService(),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Support & Help
                  SettingsSection(
                    title: 'المساعدة والدعم',
                    icon: Icons.help,
                    children: [
                      SettingsItem(
                        title: 'مركز المساعدة',
                        subtitle: 'الأسئلة الشائعة والإرشادات',
                        icon: Icons.help_center,
                        onTap: () => _helpCenter(),
                      ),
                      SettingsItem(
                        title: 'التواصل مع الدعم',
                        subtitle: 'تواصل مع فريق الدعم الفني',
                        icon: Icons.support_agent,
                        onTap: () => _contactSupport(),
                      ),
                      SettingsItem(
                        title: 'الإبلاغ عن مشكلة',
                        subtitle: 'أبلغ عن خطأ أو مشكلة',
                        icon: Icons.bug_report,
                        onTap: () => _reportIssue(),
                      ),
                      SettingsItem(
                        title: 'تقييم التطبيق',
                        subtitle: 'قيم التطبيق في المتجر',
                        icon: Icons.star_rate,
                        onTap: () => _rateApp(),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // About
                  SettingsSection(
                    title: 'حول التطبيق',
                    icon: Icons.info,
                    children: [
                      SettingsItem(
                        title: 'معلومات التطبيق',
                        subtitle: 'الإصدار والمطور',
                        icon: Icons.info_outline,
                        onTap: () => _appInfo(),
                      ),
                      SettingsItem(
                        title: 'التحديثات',
                        subtitle: 'البحث عن تحديثات جديدة',
                        icon: Icons.system_update,
                        onTap: () => _checkUpdates(),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Logout Button
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton.icon(
                      onPressed: () => _logout(),
                      icon: const Icon(Icons.logout),
                      label: const Text('تسجيل الخروج'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ).animate(effects: fadeInSlide(delay: const Duration(milliseconds: 800))),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method implementations
  void _editProfile() {}
  void _editPersonalInfo() {}
  void _editProfessionalInfo() {}
  void _changePassword() {}
  void _securitySettings() {}
  void _clinicInfo() {}
  void _workingHours() {}
  void _servicePrices() {}
  void _appointmentSettings() {}
  void _advancedNotifications() {}
  void _changeLanguage() {}
  void _changeTheme() {}
  void _clearCache() {}
  void _dataManagement() {}
  void _privacyPolicy() {}
  void _termsOfService() {}
  void _helpCenter() {}
  void _contactSupport() {}
  void _reportIssue() {}
  void _rateApp() {}
  void _appInfo() {}
  void _checkUpdates() {}
  void _logout() {}
  void _showSearchDialog() {}
}
