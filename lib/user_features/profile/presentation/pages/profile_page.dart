import 'package:derma_ai/core/widgets/logout_confirmation_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/service_locatores.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/helpers/image_picker_helper.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/widgets/custom_snackbar.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/profile_cubit.dart';
import '../bloc/profile_state.dart';
import 'edit_profile_page.dart';
import 'settings_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = sl<ProfileCubit>();
    //print('🔵 [ProfilePage] initState - Cubit instance: ${_profileCubit.hashCode}');
    //print('🔵 [ProfilePage] Current state: ${_profileCubit.state.runtimeType}');
    
    // Only fetch if we don't have data yet
    if (_profileCubit.state is! ProfileSuccess) {
      //print('🔵 [ProfilePage] State is NOT ProfileSuccess, fetching data...');
      _profileCubit.getUserProfile();
    } else {
      //print('🔵 [ProfilePage] State is ProfileSuccess, using cached data');
      final successState = _profileCubit.state as ProfileSuccess;
      //print('🔵 [ProfilePage] Cached data - Phone: ${successState.userProfile.phone}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _profileCubit,
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // Listener for state changes - UI rebuilds automatically
        },
        child: Scaffold(
          backgroundColor: Colors.grey[50],
          body: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return RefreshIndicator(
              onRefresh: () async {
                await _profileCubit.refreshProfile();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    if (state is ProfileFailure)
                      Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.error_outline, color: Colors.red.shade600),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'خطأ في تحميل البيانات',
                                    style: getBoldStyle(
                                      color: Colors.red.shade700,
                                      fontSize: 14,
                                      fontFamily: FontConstant.cairo,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    state.message,
                                    style: getRegularStyle(
                                      color: Colors.red.shade600,
                                      fontSize: 12,
                                      fontFamily: FontConstant.cairo,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<ProfileCubit>().getUserProfile();
                              },
                              child: Text(
                                'إعادة المحاولة',
                                style: getBoldStyle(
                                  color: Colors.red.shade700,
                                  fontSize: 12,
                                  fontFamily: FontConstant.cairo,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    _buildHeader(context, state),
                    _buildContactInfo(state),
                    _buildRecentAppointments(context),
                    _buildMenuItems(context),
                    _buildLogoutButton(context),
                    const SizedBox(height: 20), // Space for bottom navigation
                  ],
                ),
              ),
            );
          },
        ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ProfileState state) {
    return SizedBox(
      height: 320, // Fixed height to ensure full visibility
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Cover gradient
          Container(
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary,
                  AppColors.primary.withValues(alpha: 0.8),
                ],
              ),
            ),
          ),
          
          // Back button
    
          // Profile card
          Positioned(
            top: 100,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Avatar with edit button
                      Stack(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                // Use key to force rebuild when picture changes
                                CircleAvatar(
                                  key: ValueKey(state is ProfileSuccess 
                                      ? state.userProfile.profilePictureUrl ?? 'no-picture'
                                      : 'loading'),
                                  radius: 32,
                                  backgroundColor: Colors.grey[200],
                                  backgroundImage: state is ProfileSuccess && 
                                      state.userProfile.profilePictureUrl != null
                                      ? CachedNetworkImageProvider(
                                          state.userProfile.profilePictureUrl!,
                                        )
                                      : null,
                                  child: state is ProfileSuccess && 
                                      state.userProfile.profilePictureUrl == null
                                      ? Text(
                                          state.userProfile.fullName.isNotEmpty 
                                              ? state.userProfile.fullName[0].toUpperCase()
                                              : 'U',
                                          style: getBoldStyle(
                                            fontSize: 24,
                                            color: AppColors.primary,
                                            fontFamily: FontConstant.cairo,
                                          ),
                                        )
                                      : state is ProfileLoading
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(strokeWidth: 2),
                                            )
                                          : Icon(
                                              Icons.person,
                                              size: 35,
                                              color: Colors.grey[600],
                                            ),
                                ),
                                // Loading overlay during update
                                if (state is ProfileUpdating)
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withValues(alpha: 0.5),
                                    ),
                                    child: const Center(
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          // Edit button
                          if (state is ProfileSuccess)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => _showProfilePictureOptions(context, state.userProfile.profilePictureUrl),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      
                      // User info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state is ProfileSuccess 
                                  ? state.userProfile.displayName
                                  : state is ProfileLoading 
                                      ? 'جاري التحميل...'
                                      : 'مستخدم',
                              style: getBoldStyle(
                                fontFamily: FontConstant.cairo,
                                fontSize: 18,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              state is ProfileSuccess 
                                  ? 'Patient ID: #${state.userProfile.patientId}'
                                  : 'Patient ID: #---',
                              style: getRegularStyle(
                                fontFamily: FontConstant.cairo,
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: state is ProfileSuccess
                                  ? () async {
                                      final cubit = context.read<ProfileCubit>();
                                      //print('🔵 [ProfilePage] Opening EditProfilePage');
                                      //print('🔵 [ProfilePage] Cubit instance: ${cubit.hashCode}');
                                      //print('🔵 [ProfilePage] Current phone: ${state.userProfile.phone}');
                                      
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BlocProvider.value(
                                            value: cubit,
                                            child: EditProfilePage(
                                              userProfile: state.userProfile,
                                            ),
                                          ),
                                        ),
                                      );
                                      
                                      //print('🔵 [ProfilePage] Returned from EditProfilePage');
                                      //print('🔵 [ProfilePage] Current state: ${cubit.state.runtimeType}');
                                      if (cubit.state is ProfileSuccess) {
                                        final successState = cubit.state as ProfileSuccess;
                                        //print('🔵 [ProfilePage] Current phone after return: ${successState.userProfile.phone}');
                                      }
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppColors.primary,
                                side: BorderSide(color: AppColors.primary),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                minimumSize: const Size(0, 32),
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.editProfile,
                                style: getSemiBoldStyle(
                                  fontFamily: FontConstant.cairo,
                                  fontSize: 11,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  // Stats
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey[200]!),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('12', 'المواعيد'),
                        _buildStatItem('5', 'الأطباء المحفوظون'),
                        _buildStatItem('8', 'التقييمات'),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: getBoldStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 11,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo(ProfileState state) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      padding: const EdgeInsets.all(20),
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
          Text(
            'معلومات الاتصال',
            style: getBoldStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildContactItem(
            icon: Icons.email_outlined,
            label: 'البريد الإلكتروني',
            value: state is ProfileSuccess 
                ? state.userProfile.email
                : 'غير متوفر',
            color: Colors.blue,
          ),
          const SizedBox(height: 12),
          
          _buildContactItem(
            icon: Icons.phone_outlined,
            label: 'رقم الهاتف',
            value: state is ProfileSuccess 
                ? state.userProfile.phone
                : 'غير متوفر',
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          
          _buildContactItem(
            icon: Icons.location_on_outlined,
            label: 'الموقع',
            value: state is ProfileSuccess 
                ? state.userProfile.location
                : 'غير محدد',
            color: Colors.orange,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideX(begin: -0.3);
  }

  Widget _buildContactItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentAppointments(BuildContext context) {
    final appointments = [
      {
        'doctor': 'د. سارة أحمد',
        'date': '20 أكتوبر 2025',
        'time': '10:00 ص',
        'type': 'مكالمة فيديو',
        'status': 'قادم',
        'statusColor': Colors.green,
      },
      {
        'doctor': 'د. محمد حسان',
        'date': '18 أكتوبر 2025',
        'time': '2:00 م',
        'type': 'زيارة عيادة',
        'status': 'مكتمل',
        'statusColor': Colors.grey,
      },
    ];

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المواعيد الأخيرة',
                style: getBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      'عرض الكل',
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
          
          ...appointments.map((apt) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
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
                        color: Colors.black87,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: (apt['statusColor'] as Color).withValues(alpha: 0.1),
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
                    Text(' • ', style: TextStyle(color: Colors.grey[600])),
                    Text(
                      apt['time'] as String,
                      style: getRegularStyle(
                        fontFamily: FontConstant.cairo,
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(' • ', style: TextStyle(color: Colors.grey[600])),
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
          )),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideX(begin: 0.3);
  }

  Widget _buildMenuItems(BuildContext context) {
    final menuItems = [
      {
        'id': 'personal',
        'icon': Icons.person_outline,
        'label': 'المعلومات الشخصية',
        'color': Colors.blue,
      },
      {
        'id': 'appointments',
        'icon': Icons.calendar_today_outlined,
        'label': 'مواعيدي',
        'color': Colors.green,
      },
      {
        'id': 'saved',
        'icon': Icons.favorite_outline,
        'label': 'الأطباء المحفوظون',
        'color': Colors.red,
      },
      {
        'id': 'settings',
        'icon': Icons.settings_outlined,
        'label': 'الإعدادات',
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
        children: menuItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == menuItems.length - 1;
          
          return Container(
            decoration: BoxDecoration(
              border: isLast ? null : Border(
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

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          LogoutConfirmationDialog.show(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.red,
          side: const BorderSide(color: Colors.red, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.logout, size: 20),
            const SizedBox(width: 8),
            Text(
              'تسجيل الخروج',
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 14,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 800.ms).slideY(begin: 0.5);
  }

  void _showProfilePictureOptions(BuildContext context, String? currentPictureUrl) {
    final l10n = AppLocalizations.of(context)!;
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) => BlocBuilder<ProfileCubit, ProfileState>(
        bloc: _profileCubit,
        builder: (context, state) {
          // Get current picture URL from state
          final pictureUrl = state is ProfileSuccess 
              ? state.userProfile.profilePictureUrl 
              : null;
          
          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.changeProfilePicture,
                  style: getBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Upload from gallery
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.photo_library, color: AppColors.primary),
                  ),
                  title: Text(
                    l10n.gallery,
                    style: getSemiBoldStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(bottomSheetContext);
                    await _uploadPictureFromGallery();
                  },
                ),
                
                // Upload from camera
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.camera_alt, color: Colors.blue),
                  ),
                  title: Text(
                    l10n.camera,
                    style: getSemiBoldStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(bottomSheetContext);
                    await _uploadPictureFromCamera();
                  },
                ),
                
                // Delete picture (only if picture exists)
                if (pictureUrl != null)
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.delete, color: Colors.red),
                    ),
                    title: Text(
                      l10n.deletePicture,
                      style: getSemiBoldStyle(
                        fontFamily: FontConstant.cairo,
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(bottomSheetContext);
                      _confirmDeletePicture();
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _uploadPictureFromGallery() async {
    final l10n = AppLocalizations.of(context)!;
    
    try {
      final file = await ImagePickerHelper.pickImageFromGallery();
      if (file != null) {
        // Clear old image from cache if exists
        final currentState = _profileCubit.state;
        if (currentState is ProfileSuccess && 
            currentState.userProfile.profilePictureUrl != null) {
          await CachedNetworkImage.evictFromCache(
            currentState.userProfile.profilePictureUrl!,
          );
        }
        
        await _profileCubit.uploadProfilePicture(file.path);
        if (mounted) {
          CustomSnackbar.showSuccess(
            context: context,
            message: l10n.pictureUploadedSuccessfully,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        CustomSnackbar.showError(
          context: context,
          message: e.toString(),
        );
      }
    }
  }

  Future<void> _uploadPictureFromCamera() async {
    final l10n = AppLocalizations.of(context)!;
    
    try {
      final file = await ImagePickerHelper.pickImageFromCamera();
      if (file != null) {
        // Clear old image from cache if exists
        final currentState = _profileCubit.state;
        if (currentState is ProfileSuccess && 
            currentState.userProfile.profilePictureUrl != null) {
          await CachedNetworkImage.evictFromCache(
            currentState.userProfile.profilePictureUrl!,
          );
        }
        
        await _profileCubit.uploadProfilePicture(file.path);
        if (mounted) {
          CustomSnackbar.showSuccess(
            context: context,
            message: l10n.pictureUploadedSuccessfully,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        CustomSnackbar.showError(
          context: context,
          message: e.toString(),
        );
      }
    }
  }

  void _confirmDeletePicture() {
    final l10n = AppLocalizations.of(context)!;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          l10n.deletePicture,
          style: getBoldStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 18,
          ),
        ),
        content: Text(
          l10n.confirmDeletePicture,
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.cancel,
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _deletePicture();
            },
            child: Text(
              l10n.delete,
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 14,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deletePicture() async {
    final l10n = AppLocalizations.of(context)!;
    
    try {
      await _profileCubit.deleteProfilePicture();
      if (mounted) {
        CustomSnackbar.showSuccess(
          context: context,
          message: l10n.pictureDeletedSuccessfully,
        );
      }
    } catch (e) {
      if (mounted) {
        CustomSnackbar.showError(
          context: context,
          message: l10n.pictureDeleteFailed,
        );
      }
    }
  }
}