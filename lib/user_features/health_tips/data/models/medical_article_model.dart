import 'package:equatable/equatable.dart';

class MedicalArticleModel extends Equatable {
  final int id;
  final String title;
  final String subTitle;
  final String description;
  final int createdBy;
  final int updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int isActive;

  const MedicalArticleModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
  });

  factory MedicalArticleModel.fromJson(Map<String, dynamic> json) {
    return MedicalArticleModel(
      id: json['id'] as int,
      title: json['title'] as String,
      subTitle: json['sub_title'] as String,
      description: json['description'] as String,
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
      'sub_title': subTitle,
      'description': description,
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
        subTitle,
        description,
        createdBy,
        updatedBy,
        createdAt,
        updatedAt,
        isActive,
      ];
}

class MedicalArticlesResponse extends Equatable {
  final bool success;
  final List<MedicalArticleModel> articles;
  final Pagination pagination;
  final String message;

  const MedicalArticlesResponse({
    required this.success,
    required this.articles,
    required this.pagination,
    required this.message,
  });

  factory MedicalArticlesResponse.fromJson(Map<String, dynamic> json) {
    return MedicalArticlesResponse(
      success: json['success'] as bool,
      articles: (json['data'] as List)
          .map((article) => MedicalArticleModel.fromJson(article as Map<String, dynamic>))
          .toList(),
      pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      message: json['message'] as String,
    );
  }

  @override
  List<Object?> get props => [success, articles, pagination, message];
}

class SingleMedicalArticleResponse extends Equatable {
  final bool success;
  final MedicalArticleModel article;
  final String message;

  const SingleMedicalArticleResponse({
    required this.success,
    required this.article,
    required this.message,
  });

  factory SingleMedicalArticleResponse.fromJson(Map<String, dynamic> json) {
    return SingleMedicalArticleResponse(
      success: json['success'] as bool,
      article: MedicalArticleModel.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
    );
  }

  @override
  List<Object?> get props => [success, article, message];
}

class Pagination extends Equatable {
  final int page;
  final int limit;
  final int total;
  final int pages;

  const Pagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.pages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
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

class MedicalArticlesResult extends Equatable {
  final List<MedicalArticleModel> articles;
  final bool hasMore;
  final int currentPage;
  final int lastPage;
  final int total;

  const MedicalArticlesResult({
    required this.articles,
    required this.hasMore,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  @override
  List<Object?> get props => [articles, hasMore, currentPage, lastPage, total];
}
