import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../user_features/location/presentation/bloc/location_cubit.dart';
import '../../../../user_features/location/presentation/bloc/location_state.dart';
import '../../../../user_features/location/presentation/widgets/location_selection_sheet.dart';
import '../../../notifications/presentation/pages/notifications_page.dart';
import '../../../notifications/data/datasources/notifications_static_data.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100 + MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            const Color.fromARGB(255, 35, 102, 196).withValues(alpha: 0.8),
            const Color.fromARGB(255, 2, 83, 150),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              // Profile Avatar with elegant design
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  child: SvgPicture.asset(
                    'assets/images/onboarding1.svg',
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // User Info Section
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مرحباً بك 👋',
                      style: getRegularStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 14,
                        fontFamily: FontConstant.cairo,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'أحمد محمد',
                      style: getBoldStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: FontConstant.cairo,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Location Selector
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const LocationSelectionSheet(),
                        );
                      },
                      child: BlocBuilder<LocationCubit, LocationState>(
                        builder: (context, state) {
                          final locationText =
                              context
                                  .read<LocationCubit>()
                                  .currentDisplayLocation;
                          return Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  locationText,
                                  style: getMediumStyle(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontSize: 12,
                                    fontFamily: FontConstant.cairo,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: 14,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Notification Icon with modern design
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationsPage(),
                      ),
                    );
                  },
                  icon: Stack(
                    children: [
                      Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                        size: 26,
                      ),
                      if (NotificationsStaticData.getUnreadCount() > 0)
                        Positioned(
                          right: 2,
                          top: 2,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
