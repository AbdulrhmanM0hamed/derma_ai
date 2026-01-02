import 'package:equatable/equatable.dart';

// Package Feature Model
class PackageFeatureModel extends Equatable {
  final String featureValue;
  final int isIncluded;
  final int featureId;
  final String nameAr;
  final String nameEn;
  final String unitAr;
  final String unitEn;
  final String featureName;
  final String featureUnit;

  const PackageFeatureModel({
    required this.featureValue,
    required this.isIncluded,
    required this.featureId,
    required this.nameAr,
    required this.nameEn,
    required this.unitAr,
    required this.unitEn,
    required this.featureName,
    required this.featureUnit,
  });

  // Helper getters
  bool get included => isIncluded == 1;

  // From JSON
  factory PackageFeatureModel.fromJson(Map<String, dynamic> json) {
    return PackageFeatureModel(
      featureValue: json['feature_value'] as String? ?? '',
      isIncluded: json['is_included'] as int? ?? 0,
      featureId: json['feature_id'] as int? ?? 0,
      nameAr: json['name_ar'] as String? ?? '',
      nameEn: json['name_en'] as String? ?? '',
      unitAr: json['unit_ar'] as String? ?? '',
      unitEn: json['unit_en'] as String? ?? '',
      featureName: json['feature_name'] as String? ?? '',
      featureUnit: json['feature_unit'] as String? ?? '',
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'feature_value': featureValue,
      'is_included': isIncluded,
      'feature_id': featureId,
      'name_ar': nameAr,
      'name_en': nameEn,
      'unit_ar': unitAr,
      'unit_en': unitEn,
      'feature_name': featureName,
      'feature_unit': featureUnit,
    };
  }

  // Copy With
  PackageFeatureModel copyWith({
    String? featureValue,
    int? isIncluded,
    int? featureId,
    String? nameAr,
    String? nameEn,
    String? unitAr,
    String? unitEn,
    String? featureName,
    String? featureUnit,
  }) {
    return PackageFeatureModel(
      featureValue: featureValue ?? this.featureValue,
      isIncluded: isIncluded ?? this.isIncluded,
      featureId: featureId ?? this.featureId,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      unitAr: unitAr ?? this.unitAr,
      unitEn: unitEn ?? this.unitEn,
      featureName: featureName ?? this.featureName,
      featureUnit: featureUnit ?? this.featureUnit,
    );
  }

  @override
  List<Object?> get props => [
    featureValue,
    isIncluded,
    featureId,
    nameAr,
    nameEn,
    unitAr,
    unitEn,
    featureName,
    featureUnit,
  ];
}
