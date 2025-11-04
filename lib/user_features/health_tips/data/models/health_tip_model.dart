import 'package:equatable/equatable.dart';

class HealthTipModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final int createdBy;
  final int updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int isActive;

  const HealthTipModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
  });

  factory HealthTipModel.fromJson(Map<String, dynamic> json) {
    return HealthTipModel(
      id: json['id'] as int,
      title: json['title'] as String,
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
        description,
        createdBy,
        updatedBy,
        createdAt,
        updatedAt,
        isActive,
      ];
}
