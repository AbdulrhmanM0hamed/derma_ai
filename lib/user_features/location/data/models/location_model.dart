class LocationModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String name;
  final String levelType;
  final int? parentId;
  final String? image;

  const LocationModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.name,
    required this.levelType,
    this.parentId,
    this.image,
  });

  /// Returns the localized name based on the provided locale
  String getLocalizedName(String locale) {
    return locale == 'ar' ? nameAr : nameEn;
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['countries_cities_id'] as int,
      nameAr: json['name_ar'] as String,
      nameEn: json['name_en'] as String,
      name: json['name'] as String,
      levelType: json['level_type'] as String,
      parentId: json['parent_id'] as int?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'countries_cities_id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'name': name,
      'level_type': levelType,
      'parent_id': parentId,
      'image': image,
    };
  }
}
