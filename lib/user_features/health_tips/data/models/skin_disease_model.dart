import 'package:equatable/equatable.dart';

class SkinDiseaseModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final String? websiteLink;
  final int createdBy;
  final int updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int isActive;

  const SkinDiseaseModel({
    required this.id,
    required this.title,
    required this.description,
    this.websiteLink,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
  });

  factory SkinDiseaseModel.fromJson(Map<String, dynamic> json) {
    return SkinDiseaseModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      websiteLink: json['website_link'] as String?,
      createdBy: json['created_by'] as int,
      updatedBy: json['updated_by'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      isActive: json['is_active'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'website_link': websiteLink,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_active': isActive,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        websiteLink,
        createdBy,
        updatedBy,
        createdAt,
        updatedAt,
        isActive,
      ];
}

class SkinDiseasesResponse extends Equatable {
  final bool success;
  final List<SkinDiseaseModel> diseases;
  final SkinDiseasesPagination pagination;
  final String message;

  const SkinDiseasesResponse({
    required this.success,
    required this.diseases,
    required this.pagination,
    required this.message,
  });

  factory SkinDiseasesResponse.fromJson(Map<String, dynamic> json) {
    return SkinDiseasesResponse(
      success: json['success'] as bool,
      diseases: (json['data'] as List)
          .map((disease) => SkinDiseaseModel.fromJson(disease as Map<String, dynamic>))
          .toList(),
      pagination: SkinDiseasesPagination.fromJson(json['pagination'] as Map<String, dynamic>),
      message: json['message'] as String,
    );
  }

  @override
  List<Object?> get props => [success, diseases, pagination, message];
}

class SkinDiseasesPagination extends Equatable {
  final int page;
  final int limit;
  final int total;
  final int pages;

  const SkinDiseasesPagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.pages,
  });

  factory SkinDiseasesPagination.fromJson(Map<String, dynamic> json) {
    return SkinDiseasesPagination(
      page: json['page'] as int,
      limit: json['limit'] as int,
      total: json['total'] as int,
      pages: json['pages'] as int,
    );
  }

  bool get hasMore => page < pages;

  @override
  List<Object?> get props => [page, limit, total, pages];
}

class SkinDiseasesResult extends Equatable {
  final List<SkinDiseaseModel> diseases;
  final bool hasMore;
  final int currentPage;
  final int lastPage;
  final int total;

  const SkinDiseasesResult({
    required this.diseases,
    required this.hasMore,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  @override
  List<Object?> get props => [diseases, hasMore, currentPage, lastPage, total];
}
