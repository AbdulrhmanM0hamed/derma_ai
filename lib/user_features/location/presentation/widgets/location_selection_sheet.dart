import 'package:derma_ai/core/utils/common/custom_progress_indicator.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bloc/location_cubit.dart';
import '../bloc/location_state.dart';
import '../../data/models/location_model.dart';

class LocationSelectionSheet extends StatefulWidget {
  const LocationSelectionSheet({super.key});

  @override
  State<LocationSelectionSheet> createState() => _LocationSelectionSheetState();
}

class _LocationSelectionSheetState extends State<LocationSelectionSheet> {
  List<LocationModel> _countries = [];
  int _currentStep = 0; // 0: Countries & Cities, 1: Regions

  @override
  void initState() {
    super.initState();
    // Load countries on open if not already loaded or if resetting
    context.read<LocationCubit>().initLocationSelection();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          _buildHeader(),
          // Content
          Expanded(
            child: BlocBuilder<LocationCubit, LocationState>(
              builder: (context, state) {
                if (_currentStep == 0) {
                  // Countries & Cities Step
                  if (state is CountriesLoaded) {
                    _countries = state.countries;
                    return _buildCountriesAndCitiesView(_countries);
                  } else if (state is CitiesLoaded) {
                    _countries = state.countries;
                    return _buildCountriesAndCitiesView(_countries);
                  } else if (state is LocationLoading &&
                      state is! CitiesLoaded) {
                    return const Center(child: CustomProgressIndicator());
                  } else if (state is LocationError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: CustomProgressIndicator());
                } else {
                  // Regions Step
                  if (state is RegionsLoaded) {
                    return _buildRegionsView(state.regions);
                  } else if (state is LocationLoading) {
                    return const Center(child: CustomProgressIndicator());
                  } else if (state is LocationError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: CustomProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountriesAndCitiesView(List<LocationModel> countries) {
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
                  AppLocalizations.of(context)!.selectCountry,
                  style: getBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: FontSize.size16,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(
                height: 120, // Adjusted height for the new square design
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
                                  // Gradient Overlay
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
                                  // Text Name
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        country.getLocalizedName(Localizations.localeOf(context).languageCode),
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

              // Cities Section (only show if country is selected)
              if (selectedCountry != null) ...[
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.selectCity,
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
                      AppLocalizations.of(context)!.noCitiesAvailable,
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
                          _showRegionsPage(context, city);
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
                                // Background Image
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
                                // Gradient Overlay
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
                                // City Name + Selected Icon
                                Positioned(
                                  bottom: 16,
                                  left: 16,
                                  right: 16,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          city.getLocalizedName(Localizations.localeOf(context).languageCode),
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

  void _showRegionsPage(BuildContext context, LocationModel city) {
    context.read<LocationCubit>().selectCity(city);
    _nextStep();
  }

  Widget _buildHeader() {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        String title = _currentStep == 0 ? l10n.selectLocation : l10n.selectRegion;
        final cubit = context.read<LocationCubit>();
        final region = cubit.selectedRegion;
        final city = cubit.selectedCity;

        final String? imageUrl = region?.image ?? city?.image;

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              if (_currentStep > 0)
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 20),
                  onPressed: _previousStep,
                )
              else
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child:
                        imageUrl != null && imageUrl.isNotEmpty
                            ? CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.location_on,
                                      color: AppColors.primary,
                                      size: 24,
                                    ),
                                  ),
                              errorWidget:
                                  (context, url, error) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.location_on,
                                      color: AppColors.primary,
                                      size: 24,
                                    ),
                                  ),
                            )
                            : Icon(
                              Icons.location_on,
                              color: AppColors.primary,
                              size: 24,
                            ),
                  ),
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: getBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: FontSize.size18,
                    color: AppColors.black,
                  ),
                ),
              ),
              if (cubit.selectedRegion != null && _currentStep == 1)
                TextButton(
                  onPressed: () {
                    // Clear selection logic implementation if needed, or just remove if not fully implemented in user snippet
                    cubit.selectRegion(
                      cubit.selectedRegion!,
                    ); // Re-selecting might not be 'clear'. User had empty logic.
                    // Actually, let's keep the user's placeholder logic or safely ignore.
                    // User snippet had `// Clear selection logic`.
                  },
                  child: Text(
                    l10n.clear,
                    style: getMediumStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: FontSize.size14,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
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
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: regions.length + 1,
      itemBuilder: (context, index) {
        final cubit = context.read<LocationCubit>();

        // First item is "الكل" (All)
        if (index == 0) {
          final isSelected = cubit.selectedRegion == null;

          return GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
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
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.3),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      l10n.all,
                      style: getBoldStyle(
                        fontFamily: FontConstant.cairo,
                        fontSize: FontSize.size18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
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
            Navigator.pop(context);
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
                  // Background Image
                  if (region.image != null)
                    Positioned.fill(
                      child: CachedNetworkImage(
                        imageUrl: region.image!,
                        fit: BoxFit.cover,
                        placeholder:
                            (context, url) => Container(
                              color: AppColors.primary.withValues(alpha: 0.2),
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
                              color: AppColors.primary.withValues(alpha: 0.2),
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

                  // Dark overlay for text readability
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

                  // Region Name
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
    );
  }
}

Widget _buildRegionsList(List<LocationModel> regions) {
  if (regions.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.map_outlined, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'لا توجد مناطق متاحة',
            style: getMediumStyle(
              fontFamily: FontConstant.cairo,
              fontSize: FontSize.size16,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  return ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    itemCount: regions.length + 1,
    itemBuilder: (context, index) {
      final cubit = context.read<LocationCubit>();

      // First item is "الكل" (All)
      if (index == 0) {
        final isSelected = cubit.selectedRegion == null;

        return GestureDetector(
          onTap: () {
            // Clear region selection
            Navigator.pop(context);
          },
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
                  isSelected ? Border.all(color: Colors.white, width: 3) : null,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.3),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'الكل',
                    style: getBoldStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: FontSize.size18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
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
          Navigator.pop(context);
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
                // Background Image
                if (region.image != null)
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: region.image!,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => Container(
                            color: AppColors.primary.withValues(alpha: 0.2),
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
                            color: AppColors.primary.withValues(alpha: 0.2),
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

                // Dark overlay for text readability
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

                // Region Name
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Text(
                    region.name,
                    style: getBoldStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: FontSize.size16,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
