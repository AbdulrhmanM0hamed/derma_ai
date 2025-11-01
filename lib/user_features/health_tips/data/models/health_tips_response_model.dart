import 'package:equatable/equatable.dart';
import 'health_tip_model.dart';

class PaginationModel extends Equatable {
  final int page;
  final int limit;
  final int total;
  final int pages;

  const PaginationModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.pages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      page: json['page'] as int,
      limit: json['limit'] as int,
      total: json['total'] as int,
      pages: json['pages'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
      'pages': pages,
    };
  }

  @override
  List<Object?> get props => [page, limit, total, pages];
}

class HealthTipsResponseModel extends Equatable {
  final bool success;
  final List<HealthTipModel> data;
  final PaginationModel? pagination;
  final String message;

  const HealthTipsResponseModel({
    required this.success,
    required this.data,
    this.pagination,
    required this.message,
  });

  factory HealthTipsResponseModel.fromJson(Map<String, dynamic> json) {
    return HealthTipsResponseModel(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((item) => HealthTipModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.map((tip) => tip.toJson()).toList(),
      if (pagination != null) 'pagination': pagination!.toJson(),
      'message': message,
    };
  }

  @override
  List<Object?> get props => [success, data, pagination, message];
}

class SingleHealthTipResponseModel extends Equatable {
  final bool success;
  final HealthTipModel data;
  final String message;

  const SingleHealthTipResponseModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory SingleHealthTipResponseModel.fromJson(Map<String, dynamic> json) {
    return SingleHealthTipResponseModel(
      success: json['success'] as bool,
      data: HealthTipModel.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
      'message': message,
    };
  }

  @override
  List<Object?> get props => [success, data, message];
}

class HealthTipsResult extends Equatable {
  final List<HealthTipModel> tips;
  final bool hasMore;
  final int currentPage;
  final int lastPage;
  final int total;

  const HealthTipsResult({
    required this.tips,
    required this.hasMore,
    required this.currentPage,
    required this.lastPage,
    required this.total,
  });

  @override
  List<Object?> get props => [tips, hasMore, currentPage, lastPage, total];
}
