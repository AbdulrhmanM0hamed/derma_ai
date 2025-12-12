import 'package:derma_ai/core/utils/common/custom_progress_indicator.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/core/widgets/custom_button.dart';
import 'package:derma_ai/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bloc/location_cubit.dart';
import '../bloc/location_state.dart';
import '../../data/models/location_model.dart';

/// A professional dialog that requires the user to select a location
/// before they can use the app. This is shown on first launch or when
/// no location is saved.
class LocationRequiredDialog extends StatefulWidget {
  final VoidCallback? onLocationSelected;

  const LocationRequiredDialog({super.key, this.onLocationSelected});

  /// Shows the location required dialog
  static Future<void> show(
    BuildContext context, {
    VoidCallback? onLocationSelected,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder:
          (context) =>
              LocationRequiredDialog(onLocationSelected: onLocationSelected),
    );
  }

  @override
  State<LocationRequiredDialog> createState() => _LocationRequiredDialogState();
}

class _LocationRequiredDialogState extends State<LocationRequiredDialog>
    with SingleTickerProviderStateMixin {
  List<LocationModel> _countries = [];
  int _currentStep = 0; // 0: Welcome, 1: Countries & Cities, 2: Regions
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startLocationSelection() {
    context.read<LocationCubit>().initLocationSelection();
    setState(() {
      _currentStep = 1;
    });
  }

  void _nextStep() {
    setState(() {
      _currentStep++;
    });
  }

  void _previousStep() {
    setState(() {
      _currentStep--;
    });
  }

  void _onLocationConfirmed() {
    Navigator.of(context).pop();
    widget.onLocationSelected?.call();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
            maxWidth: 500,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.2),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: _buildContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_currentStep) {
      case 0:
        return _buildWelcomeStep();
      case 1:
        return _buildCountriesAndCitiesStep();
      case 2:
        return _buildRegionsStep();
      default:
        return _buildWelcomeStep();
    }
  }

  /// Step 0: Welcome screen explaining why location is needed
  Widget _buildWelcomeStep() {
    final l10n = AppLocalizations.of(context)!;
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Location Icon with Animation
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withValues(alpha: 0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.location_on_rounded,
                color: Colors.white,
                size: 50,
              ),
            ),
            const SizedBox(height: 28),

            // Title
            Text(
              l10n.setYourLocation,
              style: getBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: FontSize.size24,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Subtitle
            Text(
              l10n.locationDescription,
              style: getMediumStyle(
                fontFamily: FontConstant.cairo,
                fontSize: FontSize.size14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Features List
            _buildFeatureItem(
              icon: Icons.medical_services_rounded,
              title: l10n.nearbyDoctors,
              subtitle: l10n.nearbyDoctorsDesc,
            ),
            const SizedBox(height: 16),
            _buildFeatureItem(
              icon: Icons.access_time_rounded,
              title: l10n.quickBooking,
              subtitle: l10n.quickBookingDesc,
            ),
            const SizedBox(height: 16),
            _buildFeatureItem(
              icon: Icons.star_rounded,
              title: l10n.bestRatings,
              subtitle: l10n.bestRatingsDesc,
            ),
            const SizedBox(height: 32),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: CustomButton(
                onPressed: _startLocationSelection,
                text: l10n.setLocation,

                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 20,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: FontSize.size14,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: getRegularStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: FontSize.size12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Step 1: Countries and Cities Selection
  Widget _buildCountriesAndCitiesStep() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        _buildHeader(l10n.selectYourLocation, showBack: false),
        Expanded(
          child: BlocBuilder<LocationCubit, LocationState>(
            builder: (context, state) {
              if (state is CountriesLoaded) {
                _countries = state.countries;
                return _buildCountriesAndCitiesView(_countries);
              } else if (state is CitiesLoaded) {
                _countries = state.countries;
                return _buildCountriesAndCitiesView(_countries);
              } else if (state is LocationLoading) {
                return const Center(child: CustomProgressIndicator());
              } else if (state is LocationError) {
                return _buildErrorView(state.message);
              }
              return const Center(child: CustomProgressIndicator());
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCountriesAndCitiesView(List<LocationModel> countries) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        final selectedCountry = context.read<LocationCubit>().selectedCountry;
        final cities = state is CitiesLoaded ? state.cities : <LocationModel>[];

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Countries Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Text(
                  l10n.selectCountry,
                  style: getBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: FontSize.size16,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  itemCount: countries.length,
                  separatorBuilder:
                      (context, index) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final country = countries[index];
                    final isSelected = selectedCountry?.id == country.id;

                    return GestureDetector(
                      onTap: () {
                        context.read<LocationCubit>().selectCountry(country);
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? AppColors.primary
                                        : Colors.transparent,
                                width: isSelected ? 3 : 0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      isSelected
                                          ? AppColors.primary.withValues(
                                            alpha: 0.3,
                                          )
                                          : Colors.black.withValues(alpha: 0.1),
                                  blurRadius: isSelected ? 8 : 4,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(13),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  country.image != null
                                      ? CachedNetworkImage(
                                        imageUrl: country.image!,
                                        fit: BoxFit.cover,
                                        placeholder:
                                            (context, url) => Container(
                                              color: AppColors.primary
                                                  .withValues(alpha: 0.1),
                                            ),
                                        errorWidget:
                                            (context, url, error) => Container(
                                              color: AppColors.primary
                                                  .withValues(alpha: 0.1),
                                              child: Icon(
                                                Icons.flag,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                      )
                                      : Container(
                                        color: AppColors.primary.withValues(
                                          alpha: 0.1,
                                        ),
                                        child: Icon(
                                          Icons.flag,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withValues(alpha: 0.7),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        country.getLocalizedName(locale),
                                        style: getBoldStyle(
                                          fontFamily: FontConstant.cairo,
                                          fontSize: FontSize.size12,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (isSelected)
                            Positioned(
                              top: -6,
                              right: -6,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check_circle,
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Cities Section
              if (selectedCountry != null) ...[
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Text(
                    l10n.selectCity,
                    style: getBoldStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: FontSize.size16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                if (state is LocationLoading)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: CustomProgressIndicator(),
                  )
                else if (cities.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      l10n.noCitiesAvailable,
                      style: getMediumStyle(
                        fontFamily: FontConstant.cairo,
                        fontSize: FontSize.size14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      final city = cities[index];
                      final cubit = context.read<LocationCubit>();
                      final isSelected = cubit.selectedCity?.id == city.id;

                      return GestureDetector(
                        onTap: () {
                          cubit.selectCity(city);
                          _nextStep();
                        },
                        child: Container(
                          height: 80,
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    isSelected
                                        ? AppColors.primary.withValues(
                                          alpha: 0.3,
                                        )
                                        : Colors.black.withValues(alpha: 0.15),
                                blurRadius: isSelected ? 12 : 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            border:
                                isSelected
                                    ? Border.all(
                                      color: AppColors.primary,
                                      width: 3,
                                    )
                                    : null,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child:
                                      city.image != null
                                          ? CachedNetworkImage(
                                            imageUrl: city.image!,
                                            fit: BoxFit.cover,
                                            placeholder:
                                                (context, url) => Container(
                                                  color: AppColors.primary
                                                      .withValues(alpha: 0.2),
                                                  child: Icon(
                                                    Icons.location_city,
                                                    color: AppColors.primary,
                                                    size: 32,
                                                  ),
                                                ),
                                            errorWidget:
                                                (
                                                  context,
                                                  url,
                                                  error,
                                                ) => Container(
                                                  color: AppColors.primary
                                                      .withValues(alpha: 0.2),
                                                  child: Icon(
                                                    Icons.location_city,
                                                    color: AppColors.primary,
                                                    size: 32,
                                                  ),
                                                ),
                                          )
                                          : Container(
                                            color: AppColors.primary.withValues(
                                              alpha: 0.1,
                                            ),
                                            child: Icon(
                                              Icons.location_city,
                                              color: AppColors.primary,
                                              size: 32,
                                            ),
                                          ),
                                ),
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withValues(alpha: 0.7),
                                          Colors.transparent,
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 16,
                                  left: 16,
                                  right: 16,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          city.getLocalizedName(locale),
                                          style: getBoldStyle(
                                            fontFamily: FontConstant.cairo,
                                            fontSize: FontSize.size16,
                                            color: Colors.white,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (isSelected)
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.check_circle,
                                            color: AppColors.primary,
                                            size: 20,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ],
          ),
        );
      },
    );
  }

  /// Step 2: Regions Selection
  Widget _buildRegionsStep() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        _buildHeader(l10n.selectRegion, showBack: true),
        Expanded(
          child: BlocBuilder<LocationCubit, LocationState>(
            builder: (context, state) {
              if (state is RegionsLoaded) {
                return _buildRegionsView(state.regions);
              } else if (state is LocationLoading) {
                return const Center(child: CustomProgressIndicator());
              } else if (state is LocationError) {
                return _buildErrorView(state.message);
              }
              return const Center(child: CustomProgressIndicator());
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRegionsView(List<LocationModel> regions) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    
    if (regions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map_outlined, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              l10n.noRegionsAvailable,
              style: getMediumStyle(
                fontFamily: FontConstant.cairo,
                fontSize: FontSize.size16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            _buildConfirmButton(),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: regions.length + 1,
            itemBuilder: (context, index) {
              final cubit = context.read<LocationCubit>();

              // First item is "الكل" (All)
              if (index == 0) {
                final isSelected = cubit.selectedRegion == null;

                return GestureDetector(
                  onTap: _onLocationConfirmed,
                  child: Container(
                    height: 60,
                    margin: const EdgeInsets.only(top: 12, bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.8),
                          AppColors.primary.withValues(alpha: 0.6),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border:
                          isSelected
                              ? Border.all(color: Colors.white, width: 3)
                              : null,
                    ),
                    child: Center(
                      child: Text(
                        l10n.allRegions,
                        style: getBoldStyle(
                          fontFamily: FontConstant.cairo,
                          fontSize: FontSize.size18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              }

              // Region items
              final region = regions[index - 1];
              final isSelected = cubit.selectedRegion?.id == region.id;

              return GestureDetector(
                onTap: () {
                  cubit.selectRegion(region);
                  _onLocationConfirmed();
                },
                child: Container(
                  height: 80,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color:
                            isSelected
                                ? AppColors.primary.withValues(alpha: 0.3)
                                : Colors.black.withValues(alpha: 0.15),
                        blurRadius: isSelected ? 12 : 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border:
                        isSelected
                            ? Border.all(color: AppColors.primary, width: 3)
                            : null,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        if (region.image != null)
                          Positioned.fill(
                            child: CachedNetworkImage(
                              imageUrl: region.image!,
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => Container(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.2,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.location_on,
                                        color: AppColors.primary,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                              errorWidget:
                                  (context, url, error) => Container(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.2,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.location_on,
                                        color: AppColors.primary,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                            ),
                          )
                        else
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.primary.withValues(alpha: 0.7),
                                    AppColors.primary.withValues(alpha: 0.5),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            ),
                          ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withValues(alpha: 0.6),
                                  Colors.black.withValues(alpha: 0.3),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 16,
                          right: 16,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  region.getLocalizedName(locale),
                                  style: getBoldStyle(
                                    fontFamily: FontConstant.cairo,
                                    fontSize: FontSize.size16,
                                    color: Colors.white,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (isSelected)
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(String title, {bool showBack = false}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (showBack)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 20),
              onPressed: _previousStep,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            )
          else
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withValues(alpha: 0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.location_on_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: getBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: FontSize.size18,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          // Progress indicator
          _buildProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      children: [
        _buildProgressDot(
          isActive: _currentStep >= 1,
          isCompleted: _currentStep > 1,
        ),
        Container(
          width: 20,
          height: 2,
          color:
              _currentStep > 1
                  ? AppColors.primary
                  : Colors.grey.withValues(alpha: 0.3),
        ),
        _buildProgressDot(isActive: _currentStep >= 2, isCompleted: false),
      ],
    );
  }

  Widget _buildProgressDot({
    required bool isActive,
    required bool isCompleted,
  }) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            isCompleted
                ? AppColors.primary
                : isActive
                ? AppColors.primary.withValues(alpha: 0.3)
                : Colors.grey.withValues(alpha: 0.3),
        border: Border.all(
          color:
              isActive ? AppColors.primary : Colors.grey.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child:
          isCompleted
              ? const Icon(Icons.check, size: 8, color: Colors.white)
              : null,
    );
  }

  Widget _buildConfirmButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: _onLocationConfirmed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 4,
            shadowColor: AppColors.primary.withValues(alpha: 0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            'تأكيد الموقع',
            style: getBoldStyle(
              fontFamily: FontConstant.cairo,
              fontSize: FontSize.size16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: Colors.red.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 16),
            Text(
              'حدث خطأ',
              style: getBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: FontSize.size18,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: getMediumStyle(
                fontFamily: FontConstant.cairo,
                fontSize: FontSize.size14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _startLocationSelection,
              icon: const Icon(Icons.refresh),
              label: Text(
                'إعادة المحاولة',
                style: getMediumStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: FontSize.size14,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
