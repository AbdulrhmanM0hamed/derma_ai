import 'dart:developer';

import 'package:derma_ai/core/network/api_service.dart';
import 'package:derma_ai/core/utils/constant/api_endpoints.dart';
import '../models/package_model.dart';
import '../models/package_feature_model.dart';
import '../models/package_comparison_model.dart';

abstract class PackagesRepository {
  Future<List<PackageFeatureModel>> getPackageFeatures();
  Future<List<PackageModel>> getPackages();
  Future<PackageModel> getPackageById(int id);
  Future<PackageComparisonModel> getPackagesComparison();
  Future<List<PackageModel>> getFeaturedPackages();
  Future<PackageModel> getCheapestPackage();
  Future<PackageModel> getPremiumPackage();
}

class PackagesRepositoryImpl implements PackagesRepository {
  final ApiService _apiService;

  PackagesRepositoryImpl(this._apiService);

  // Get Package Features
  @override
  Future<List<PackageFeatureModel>> getPackageFeatures() async {
    final response = await _apiService.get<Map<String, dynamic>>(
      ApiEndpoints.packageFeatures,
    );

    if (response['success'] == true && response['data'] != null) {
      final List<dynamic> data = response['data'] as List<dynamic>;
      log(data.toString());
      return data
          .map((e) => PackageFeatureModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception(response['message'] ?? 'Failed to load package features');
  }

  // Get All Packages
  @override
  Future<List<PackageModel>> getPackages() async {
    final response = await _apiService.get<Map<String, dynamic>>(
      ApiEndpoints.packages,
    );

    if (response['success'] == true && response['data'] != null) {
      final List<dynamic> data = response['data'] as List<dynamic>;
      log(data.toString());
      return data
          .map((e) => PackageModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception(response['message'] ?? 'Failed to load packages');
  }

  // Get Package By ID
  @override
  Future<PackageModel> getPackageById(int id) async {
    final response = await _apiService.get<Map<String, dynamic>>(
      ApiEndpoints.packageById(id),
    );

    if (response['success'] == true && response['data'] != null) {
      return PackageModel.fromJson(response['data'] as Map<String, dynamic>);
    }
    throw Exception(response['message'] ?? 'Failed to load package');
  }

  // Get Packages Comparison
  @override
  Future<PackageComparisonModel> getPackagesComparison() async {
    final response = await _apiService.get<Map<String, dynamic>>(
      ApiEndpoints.packagesComparison,
    );

    if (response['success'] == true && response['data'] != null) {
      return PackageComparisonModel.fromJson(
        response['data'] as Map<String, dynamic>,
      );
    }
    throw Exception(
      response['message'] ?? 'Failed to load packages comparison',
    );
  }

  // Get Featured Package (returns single package)
  @override
  Future<List<PackageModel>> getFeaturedPackages() async {
    final response = await _apiService.get<Map<String, dynamic>>(
      ApiEndpoints.packagesFeatured,
    );

    if (response['success'] == true && response['data'] != null) {
      // Featured endpoint returns a single package object, not an array
      final package = PackageModel.fromJson(
        response['data'] as Map<String, dynamic>,
      );
      return [package]; // Return as list for consistency
    }
    throw Exception(response['message'] ?? 'Failed to load featured package');
  }

  // Get Cheapest Package
  @override
  Future<PackageModel> getCheapestPackage() async {
    final response = await _apiService.get<Map<String, dynamic>>(
      ApiEndpoints.packagesCheapest,
    );

    if (response['success'] == true && response['data'] != null) {
      return PackageModel.fromJson(response['data'] as Map<String, dynamic>);
    }
    throw Exception(response['message'] ?? 'Failed to load cheapest package');
  }

  // Get Premium Package
  @override
  Future<PackageModel> getPremiumPackage() async {
    final response = await _apiService.get<Map<String, dynamic>>(
      ApiEndpoints.packagesPremium,
    );

    if (response['success'] == true && response['data'] != null) {
      return PackageModel.fromJson(response['data'] as Map<String, dynamic>);
    }
    throw Exception(response['message'] ?? 'Failed to load premium package');
  }
}
