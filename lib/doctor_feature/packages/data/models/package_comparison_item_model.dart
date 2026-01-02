import 'package:equatable/equatable.dart';
import 'package_comparison_feature_model.dart';

// Package Comparison Item Model
class PackageComparisonItemModel extends Equatable {
  final int id;
  final String name;
  final String nameAr;
  final String nameEn;
  final String secondaryName;
  final int durationDays;
  final double price;
  final String currencyCode;
  final List<PackageComparisonFeatureModel> features;

  const PackageComparisonItemModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.nameEn,
    required this.secondaryName,
    required this.durationDays,
    required this.price,
    required this.currencyCode,
    required this.features,
  });

  // From JSON
  factory PackageComparisonItemModel.fromJson(Map<String, dynamic> json) {
    return PackageComparisonItemModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      nameAr: json['name_ar'] as String? ?? '',
      nameEn: json['name_en'] as String? ?? '',
      secondaryName: json['secondary_name'] as String? ?? '',
      durationDays: json['duration_days'] as int? ?? 0,
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      currencyCode: json['currency_code'] as String? ?? 'SAR',
      features:
          (json['features'] as List<dynamic>?)
              ?.map(
                (e) => PackageComparisonFeatureModel.fromJson(
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
      'id': id,
      'name': name,
      'name_ar': nameAr,
      'name_en': nameEn,
      'secondary_name': secondaryName,
      'duration_days': durationDays,
      'price': price,
      'currency_code': currencyCode,
      'features': features.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    nameAr,
    nameEn,
    secondaryName,
    durationDays,
    price,
    currencyCode,
    features,
  ];
}
