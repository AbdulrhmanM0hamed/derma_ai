import 'package:equatable/equatable.dart';
import 'package_comparison_item_model.dart';

// Comparison Feature Model (for comparison endpoint)
class ComparisonFeatureModel extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;
  final String unitAr;
  final String unitEn;
  final String featureName;
  final String featureUnit;

  const ComparisonFeatureModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.unitAr,
    required this.unitEn,
    required this.featureName,
    required this.featureUnit,
  });

  factory ComparisonFeatureModel.fromJson(Map<String, dynamic> json) {
    return ComparisonFeatureModel(
      id: json['id'] as int,
      nameAr: json['name_ar'] as String? ?? '',
      nameEn: json['name_en'] as String? ?? '',
      unitAr: json['unit_ar'] as String? ?? '',
      unitEn: json['unit_en'] as String? ?? '',
      featureName: json['feature_name'] as String? ?? '',
      featureUnit: json['feature_unit'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'unit_ar': unitAr,
      'unit_en': unitEn,
      'feature_name': featureName,
      'feature_unit': featureUnit,
    };
  }

  @override
  List<Object?> get props => [
    id,
    nameAr,
    nameEn,
    unitAr,
    unitEn,
    featureName,
    featureUnit,
  ];
}

// Package Comparison Model
class PackageComparisonModel extends Equatable {
  final List<ComparisonFeatureModel> features;
  final List<PackageComparisonItemModel> packages;

  const PackageComparisonModel({
    required this.features,
    required this.packages,
  });

  // From JSON
  factory PackageComparisonModel.fromJson(Map<String, dynamic> json) {
    return PackageComparisonModel(
      features:
          (json['features'] as List<dynamic>?)
              ?.map(
                (e) =>
                    ComparisonFeatureModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      packages:
          (json['packages'] as List<dynamic>?)
              ?.map(
                (e) => PackageComparisonItemModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'features': features.map((e) => e.toJson()).toList(),
      'packages': packages.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [features, packages];
}
