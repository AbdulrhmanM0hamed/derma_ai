import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/token_storage_service.dart';
import '../../data/models/location_model.dart';
import '../../data/repositories/location_repository.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationRepository _repository;
  final TokenStorageService _tokenStorage;

  LocationModel? _selectedCountry;
  LocationModel? _selectedCity;
  LocationModel? _selectedRegion;
  List<LocationModel> _cachedCountries = [];

  LocationCubit(this._repository, this._tokenStorage)
    : super(LocationInitial()) {
    _loadSavedLocation();
  }

  Future<void> _loadSavedLocation() async {
    try {
      final countryJson = _tokenStorage.savedCountry;
      final cityJson = _tokenStorage.savedCity;
      final regionJson = _tokenStorage.savedRegion;

      if (countryJson != null) {
        _selectedCountry = LocationModel.fromJson(jsonDecode(countryJson));
      }
      if (cityJson != null) {
        _selectedCity = LocationModel.fromJson(jsonDecode(cityJson));
      }
      if (regionJson != null) {
        _selectedRegion = LocationModel.fromJson(jsonDecode(regionJson));
      }

      if (_selectedCountry != null) {
        _emitSelectionUpdate();
      } else {
        // If no saved location, just load countries for the first time or stay initial
        loadCountries();
      }
    } catch (e) {
      // If error loading saved data, just reset
      resetSelection();
    }
  }

  // Getters for current selection
  LocationModel? get selectedCountry => _selectedCountry;
  LocationModel? get selectedCity => _selectedCity;
  LocationModel? get selectedRegion => _selectedRegion;

  String get currentDisplayLocation {
    if (_selectedCountry != null) {
      if (_selectedCity != null) {
        if (_selectedRegion != null) {
          return '${_selectedCity!.name}, ${_selectedRegion!.name}';
        }
        return '${_selectedCountry!.name}, ${_selectedCity!.name}';
      }
      return _selectedCountry!.name;
    }
    return 'Select Location';
  }

  // Initial load
  Future<void> loadCountries() async {
    emit(LocationLoading());
    try {
      final countries = await _repository.getCountries();
      _cachedCountries = countries;
      emit(CountriesLoaded(countries));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  // Initialize selection for sheet (preserves existing selection)
  Future<void> initLocationSelection() async {
    emit(LocationLoading());
    try {
      // 1. Fetch countries if not already cached, or refresh them
      final countries = await _repository.getCountries();
      _cachedCountries = countries;

      // 2. If we have a selected country, we must also show its cities
      if (_selectedCountry != null) {
        final cities = await _repository.getCities(_selectedCountry!.id);
        emit(CitiesLoaded(cities, _cachedCountries));
      } else {
        emit(CountriesLoaded(_cachedCountries));
      }
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  // When country is selected
  Future<void> selectCountry(LocationModel country) async {
    _selectedCountry = country;
    _selectedCity = null;
    _selectedRegion = null;

    emit(LocationLoading());
    try {
      final cities = await _repository.getCities(country.id);
      emit(CitiesLoaded(cities, _cachedCountries));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  // When city is selected
  Future<void> selectCity(LocationModel city) async {
    _selectedCity = city;
    _selectedRegion = null;

    emit(LocationLoading());
    try {
      final regions = await _repository.getRegions(city.id);
      emit(RegionsLoaded(regions));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  // When region is selected
  void selectRegion(LocationModel region) {
    _selectedRegion = region;
    _emitSelectionUpdate();
  }

  // Finalize selection and update UI
  void _emitSelectionUpdate() {
    String display = 'Select Location';
    if (_selectedCountry != null) {
      display = _selectedCountry!.name;
      if (_selectedCity != null) {
        display += ', ${_selectedCity!.name}';
        if (_selectedRegion != null) {
          display = '${_selectedCity!.name}, ${_selectedRegion!.name}';
        }
      }
    }

    // Save to storage
    _tokenStorage.saveSelectedLocation(
      countryJson:
          _selectedCountry != null
              ? jsonEncode(_selectedCountry!.toJson())
              : null,
      cityJson:
          _selectedCity != null ? jsonEncode(_selectedCity!.toJson()) : null,
      regionJson:
          _selectedRegion != null
              ? jsonEncode(_selectedRegion!.toJson())
              : null,
    );

    emit(
      LocationSelectionUpdated(
        selectedCountry: _selectedCountry,
        selectedCity: _selectedCity,
        selectedRegion: _selectedRegion,
        displayLocation: display,
      ),
    );
  }

  // Reset to country selection
  void resetSelection() {
    _selectedCountry = null;
    _selectedCity = null;
    _selectedRegion = null;
    _tokenStorage.clearSavedLocation();
    loadCountries();
  }
}
