import 'package:derma_ai/core/utils/common/custom_progress_indicator.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/location_cubit.dart';
import '../bloc/location_state.dart';
import '../../data/models/location_model.dart';

class LocationSelectionSheet extends StatefulWidget {
  const LocationSelectionSheet({super.key});

  @override
  State<LocationSelectionSheet> createState() => _LocationSelectionSheetState();
}

class _LocationSelectionSheetState extends State<LocationSelectionSheet> {
  int _currentStep = 0; // 0: Country, 1: City, 2: Region

  @override
  void initState() {
    super.initState();
    // Load countries on open if not already loaded or if resetting
    context.read<LocationCubit>().loadCountries();
  }

  void _nextStep() {
    setState(() {
      _currentStep++;
    });
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      // Re-fetch data for previous step if necessary logic requires it,
      // but Cubit holds state so we just need to redisplay list.
      // Actually, if we go back from City to Country, we might want to clear City selection?
      // For now, let's just go back in UI step.
      if (_currentStep == 0) {
        context.read<LocationCubit>().loadCountries();
      } else if (_currentStep == 1) {
        final country = context.read<LocationCubit>().selectedCountry;
        if (country != null) {
          context.read<LocationCubit>().selectCountry(country);
        }
      }
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: BlocBuilder<LocationCubit, LocationState>(
              builder: (context, state) {
                if (state is LocationLoading) {
                  return const Center(child: CustomProgressIndicator());
                } else if (state is LocationError) {
                  return Center(child: Text(state.message)); // Localize later
                } else if (state is CountriesLoaded) {
                  return _buildList(state.countries, (item) {
                    context.read<LocationCubit>().selectCountry(item);
                    _nextStep();
                  });
                } else if (state is CitiesLoaded) {
                  if (state.cities.isEmpty) {
                    // Auto-select empty region or allow skip
                    // For now just show empty state or finish
                    return const Center(child: Text("No cities found"));
                  }
                  return _buildList(state.cities, (item) {
                    context.read<LocationCubit>().selectCity(item);
                    _nextStep();
                  });
                } else if (state is RegionsLoaded) {
                  return Column(
                    children: [
                      /*ListTile(
                        title: const Text('Skip / All Regions', style: TextStyle(fontWeight: FontWeight.bold)),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          // Select city only
                          Navigator.pop(context);
                        },
                      ),
                      const Divider(),*/
                      Expanded(
                        child:
                            state.regions.isEmpty
                                ? const Center(child: Text("No regions found"))
                                : _buildList(state.regions, (item) {
                                  context.read<LocationCubit>().selectRegion(
                                    item,
                                  );
                                  Navigator.pop(context);
                                }),
                      ),
                    ],
                  );
                }

                // Fallback for initial or updated state
                return const Center(child: CustomProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    String title = 'Select Country';
    if (_currentStep == 1) title = 'Select City';
    if (_currentStep == 2) title = 'Select Region';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 20),
              onPressed: _previousStep,
            )
          else
            const SizedBox(width: 40), // Spacer
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<LocationModel> items, Function(LocationModel) onTap) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = items[index];
        bool isSelected = false;
        final cubit = context.read<LocationCubit>();
        if (_currentStep == 0)
          isSelected = cubit.selectedCountry?.id == item.id;
        if (_currentStep == 1) isSelected = cubit.selectedCity?.id == item.id;
        if (_currentStep == 2) isSelected = cubit.selectedRegion?.id == item.id;

        return ListTile(
          title: Text(
            item.name,
          ), // Use localized name from logic if needed, model has name field
          trailing:
              isSelected
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
          onTap: () => onTap(item),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          tileColor:
              isSelected ? AppColors.primary.withValues(alpha: 0.1) : null,
        );
      },
    );
  }
}
