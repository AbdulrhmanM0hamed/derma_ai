import 'package:equatable/equatable.dart';
import 'package_item_feature_model.dart';
import 'package_type_config.dart';

// Package Model
class PackageModel extends Equatable {
  final int id;
  final String name;
  final String nameAr;
  final String nameEn;
  final String secondaryName;
  final String secondaryNameAr;
  final String secondaryNameEn;
  final int durationDays;
  final double price;
  final String currencyCode;
  final bool isFeatured;
  final List<PackageItemFeatureModel> features;

  const PackageModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.nameEn,
    required this.secondaryName,
    required this.secondaryNameAr,
    required this.secondaryNameEn,
    required this.durationDays,
    required this.price,
    required this.currencyCode,
    required this.isFeatured,
    required this.features,
  });

  // Helper getters
  String get displayPrice => '$price $currencyCode';
  String get displayDuration => '$durationDays days';

  // Package type helpers
  bool get isPremium => nameEn.toLowerCase().contains('premium');
  bool get isCheapest => nameEn.toLowerCase().contains('basic');

  PackageType get packageType {
    if (isFeatured) return PackageType.featured;
    if (isPremium) return PackageType.premium;
    if (isCheapest) return PackageType.cheapest;
    return PackageType.standard;
  }

  // Get package type config
  PackageTypeConfig get typeConfig => PackageTypeConfig.getConfig(packageType);

  // From JSON
  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      nameAr: json['name_ar'] as String? ?? '',
      nameEn: json['name_en'] as String? ?? '',
      secondaryName: json['secondary_name'] as String? ?? '',
      secondaryNameAr: json['secondary_name_ar'] as String? ?? '',
      secondaryNameEn: json['secondary_name_en'] as String? ?? '',
      durationDays: json['duration_days'] as int? ?? 0,
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      currencyCode: json['currency_code'] as String? ?? 'SAR',
      isFeatured: json['is_featured'] == true || json['is_featured'] == 1,
      features:
          (json['features'] as List<dynamic>?)
              ?.map(
                (e) =>
                    PackageItemFeatureModel.fromJson(e as Map<String, dynamic>),
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
      'secondary_name_ar': secondaryNameAr,
      'secondary_name_en': secondaryNameEn,
      'duration_days': durationDays,
      'price': price,
      'currency_code': currencyCode,
      'is_featured': isFeatured,
      'features': features.map((e) => e.toJson()).toList(),
    };
  }

  // Copy With
  PackageModel copyWith({
    int? id,
    String? name,
    String? nameAr,
    String? nameEn,
    String? secondaryName,
    String? secondaryNameAr,
    String? secondaryNameEn,
    int? durationDays,
    double? price,
    String? currencyCode,
    bool? isFeatured,
    List<PackageItemFeatureModel>? features,
  }) {
    return PackageModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      secondaryName: secondaryName ?? this.secondaryName,
      secondaryNameAr: secondaryNameAr ?? this.secondaryNameAr,
      secondaryNameEn: secondaryNameEn ?? this.secondaryNameEn,
      durationDays: durationDays ?? this.durationDays,
      price: price ?? this.price,
      currencyCode: currencyCode ?? this.currencyCode,
      isFeatured: isFeatured ?? this.isFeatured,
      features: features ?? this.features,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    nameAr,
    nameEn,
    secondaryName,
    secondaryNameAr,
    secondaryNameEn,
    durationDays,
    price,
    currencyCode,
    isFeatured,
    features,
  ];
}
