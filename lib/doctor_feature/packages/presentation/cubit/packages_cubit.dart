import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/package_model.dart';
import '../../data/models/package_feature_model.dart';
import '../../data/repositories/packages_repository.dart';
import 'packages_state.dart';

class PackagesCubit extends Cubit<PackagesState> {
  final PackagesRepository _repository;

  List<PackageModel>? _packages;
  List<PackageFeatureModel>? _features;
  PackageModel? _selectedPackage;

  PackagesCubit(this._repository) : super(PackagesInitial());

  // Getters
  List<PackageModel>? get packages => _packages;
  List<PackageFeatureModel>? get features => _features;
  PackageModel? get selectedPackage => _selectedPackage;

  // Safe emit - only emit if cubit is not closed
  void _safeEmit(PackagesState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  // Get All Packages and Features
  Future<void> getPackagesAndFeatures() async {
    try {
      _safeEmit(PackagesLoading());

      final packagesResult = await _repository.getPackages();
      final featuresResult = await _repository.getPackageFeatures();

      _packages = packagesResult;
      _features = featuresResult;

      _safeEmit(
        PackagesLoaded(packages: packagesResult, features: featuresResult),
      );
    } catch (e) {
      _safeEmit(PackagesError(e.toString()));
    }
  }

  // Get Featured Packages
  Future<void> getFeaturedPackages() async {
    try {
      _safeEmit(PackagesLoading());

      final packagesResult = await _repository.getFeaturedPackages();
      final featuresResult = await _repository.getPackageFeatures();

      _packages = packagesResult;
      _features = featuresResult;

      _safeEmit(
        PackagesLoaded(packages: packagesResult, features: featuresResult),
      );
    } catch (e) {
      _safeEmit(PackagesError(e.toString()));
    }
  }

  // Get Packages Comparison
  Future<void> getPackagesComparison() async {
    try {
      _safeEmit(PackagesComparisonLoading());

      final comparison = await _repository.getPackagesComparison();

      _safeEmit(PackagesComparisonLoaded(comparison));
    } catch (e) {
      _safeEmit(PackagesComparisonError(e.toString()));
    }
  }

  // Get Package By ID
  Future<void> getPackageById(int id) async {
    try {
      _safeEmit(PackageDetailLoading());

      final package = await _repository.getPackageById(id);
      _selectedPackage = package;

      _safeEmit(PackageDetailLoaded(package));
    } catch (e) {
      _safeEmit(PackageDetailError(e.toString()));
    }
  }

  // Get Cheapest Package
  Future<void> getCheapestPackage() async {
    try {
      _safeEmit(PackageDetailLoading());

      final package = await _repository.getCheapestPackage();
      _selectedPackage = package;

      _safeEmit(PackageDetailLoaded(package));
    } catch (e) {
      _safeEmit(PackageDetailError(e.toString()));
    }
  }

  // Get Premium Package
  Future<void> getPremiumPackage() async {
    try {
      _safeEmit(PackageDetailLoading());

      final package = await _repository.getPremiumPackage();
      _selectedPackage = package;

      _safeEmit(PackageDetailLoaded(package));
    } catch (e) {
      _safeEmit(PackageDetailError(e.toString()));
    }
  }

  // Reset State
  void reset() {
    _packages = null;
    _features = null;
    _selectedPackage = null;
    _safeEmit(PackagesInitial());
  }
}
