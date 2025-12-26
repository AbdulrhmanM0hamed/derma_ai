import 'package:derma_ai/core/network/api_service.dart';
import 'package:derma_ai/core/utils/constant/api_endpoints.dart';
import '../models/location_model.dart';

abstract class LocationRepository {
  Future<List<LocationModel>> getCountries();
  Future<List<LocationModel>> getCities(int countryId);
  Future<List<LocationModel>> getRegions(int cityId);
}

class LocationRepositoryImpl implements LocationRepository {
  final ApiService _apiService;

  LocationRepositoryImpl(this._apiService);

  @override
  Future<List<LocationModel>> getCountries() async {
    final response = await _apiService.get<Map<String, dynamic>>(
      ApiEndpoints.countries,
    );

    if (response['success'] == true && response['data'] != null) {
      return (response['data'] as List)
          .map((e) => LocationModel.fromJson(e))
          .toList();
    }
    return [];
  }

  @override
  Future<List<LocationModel>> getCities(int countryId) async {
    final response = await _apiService.get<Map<String, dynamic>>(
      ApiEndpoints.cities(countryId),
    );

    if (response['success'] == true && response['data'] != null) {
      return (response['data'] as List)
          .map((e) => LocationModel.fromJson(e))
          .toList();
    }
    return [];
  }

  @override
  Future<List<LocationModel>> getRegions(int cityId) async {
    final response = await _apiService.get<Map<String, dynamic>>(
      ApiEndpoints.regions(cityId),
    );

    if (response['success'] == true && response['data'] != null) {
      return (response['data'] as List)
          .map((e) => LocationModel.fromJson(e))
          .toList();
    }
    return [];
  }
}
