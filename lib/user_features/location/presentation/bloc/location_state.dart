import 'package:derma_ai/user_features/location/data/models/location_model.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class CountriesLoaded extends LocationState {
  final List<LocationModel> countries;
  CountriesLoaded(this.countries);
}

class CitiesLoaded extends LocationState {
  final List<LocationModel> cities;
  final List<LocationModel> countries;
  CitiesLoaded(this.cities, this.countries);
}

class RegionsLoaded extends LocationState {
  final List<LocationModel> regions;
  RegionsLoaded(this.regions);
}

class LocationError extends LocationState {
  final String message;
  LocationError(this.message);
}

class LocationSelectionUpdated extends LocationState {
  final LocationModel? selectedCountry;
  final LocationModel? selectedCity;
  final LocationModel? selectedRegion;
  final String displayLocation;

  LocationSelectionUpdated({
    this.selectedCountry,
    this.selectedCity,
    this.selectedRegion,
    required this.displayLocation,
  });
}
