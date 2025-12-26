import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/l10n/app_localizations.dart';
import 'package:derma_ai/user_features/location/presentation/bloc/location_cubit.dart';
import 'package:derma_ai/user_features/location/presentation/bloc/location_state.dart';
import 'package:derma_ai/user_features/location/presentation/widgets/location_selection_sheet.dart';
import 'package:derma_ai/user_features/notifications/data/datasources/notifications_static_data.dart';
import 'package:derma_ai/user_features/notifications/presentation/pages/notifications_page.dart';
import 'package:derma_ai/user_features/profile/presentation/bloc/profile_cubit.dart';
import 'package:derma_ai/user_features/profile/presentation/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildAppBarContent(BuildContext context) {
  return Row(
    children: [
      const SizedBox(width: 16),
      // User Info Section
      Expanded(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, profileState) {
            final l10n = AppLocalizations.of(context)!;
            String userName = l10n.user;

            if (profileState is ProfileSuccess) {
              userName =
                  profileState.userProfile.fullName.isNotEmpty
                      ? profileState.userProfile.fullName
                      : l10n.user;
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, $userName',
                  style: getBoldStyle(
                    color: AppColors.textPrimary,
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
                      final locale =
                          Localizations.localeOf(context).languageCode;
                      final locationText = context
                          .read<LocationCubit>()
                          .getLocalizedDisplayLocation(locale);
                      return Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: AppColors.primary,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              locationText,
                              style: getMediumStyle(
                                color: AppColors.primary,
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
            );
          },
        ),
      ),
      // Notification Icon with modern design
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color.fromARGB(96, 225, 225, 225),
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
                color: AppColors.black,
                size: 26,
              ),
              if (NotificationsStaticData.getUnreadCount() > 0)
                Positioned(
                  right: 3,
                  top: 3.5,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ],
  );
}
