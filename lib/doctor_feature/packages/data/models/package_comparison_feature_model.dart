import 'package:equatable/equatable.dart';

// Package Comparison Feature Model
class PackageComparisonFeatureModel extends Equatable {
  final int featureId;
  final String featureName;
  final String featureUnit;
  final String value;
  final int isIncluded;

  const PackageComparisonFeatureModel({
    required this.featureId,
    required this.featureName,
    required this.featureUnit,
    required this.value,
    required this.isIncluded,
  });

  // Helper getters
  bool get included => isIncluded == 1;

  // From JSON
  factory PackageComparisonFeatureModel.fromJson(Map<String, dynamic> json) {
    return PackageComparisonFeatureModel(
      featureId: json['feature_id'] as int,
      featureName: json['feature_name'] as String? ?? '',
      featureUnit: json['feature_unit'] as String? ?? '',
      value: json['value'] as String? ?? '',
      isIncluded: json['is_included'] as int? ?? 0,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'feature_id': featureId,
      'feature_name': featureName,
      'feature_unit': featureUnit,
      'value': value,
      'is_included': isIncluded,
    };
  }

  @override
  List<Object?> get props => [
    featureId,
    featureName,
    featureUnit,
    value,
    isIncluded,
  ];
}
