import 'package:equatable/equatable.dart';

class HealthTipModel extends Equatable {
  final int id;
  final String? titleAr;
  final String? titleEn;
  final String? descriptionAr;
  final String? descriptionEn;
  final int createdBy;
  final int updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int isActive;
  final String? createdByEmail;
  final String? updatedByEmail;

  const HealthTipModel({
    required this.id,
    this.titleAr,
    this.titleEn,
    this.descriptionAr,
    this.descriptionEn,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    this.createdByEmail,
    this.updatedByEmail,
  });

  // Helper getters للحصول على النص المناسب
  String get title => titleAr ?? titleEn ?? 'No title';
  String get description => descriptionAr ?? descriptionEn ?? 'No description';

  factory HealthTipModel.fromJson(Map<String, dynamic> json) {
    return HealthTipModel(
      id: json['id'] as int,
      titleAr: json['title_ar'] as String?,
      titleEn: json['title_en'] as String?,
      descriptionAr: json['description_ar'] as String?,
      descriptionEn: json['description_en'] as String?,
      createdBy: json['created_by'] as int,
      updatedBy: json['updated_by'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      isActive: json['is_active'] as int,
      createdByEmail: json['created_by_email'] as String?,
      updatedByEmail: json['updated_by_email'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      if (titleAr != null) 'title_ar': titleAr,
      if (titleEn != null) 'title_en': titleEn,
      if (descriptionAr != null) 'description_ar': descriptionAr,
      if (descriptionEn != null) 'description_en': descriptionEn,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_active': isActive,
      if (createdByEmail != null) 'created_by_email': createdByEmail,
      if (updatedByEmail != null) 'updated_by_email': updatedByEmail,
    };
  }

  @override
  List<Object?> get props => [
        id,
        titleAr,
        titleEn,
        descriptionAr,
        descriptionEn,
        createdBy,
        updatedBy,
        createdAt,
        updatedAt,
        isActive,
        createdByEmail,
        updatedByEmail,
      ];
}
