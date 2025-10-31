import 'comment_model.dart';
import 'doctor_profile_model.dart';

class PostModel {
  final String id;
  final DoctorProfileModel doctor;
  final String content;
  final String? imageUrl;
  final DateTime timestamp;
  final int likes;
  final List<CommentModel> comments;
  final int shares;
  final bool isLiked;
  final List<String> tags;
  
  // Computed properties for post detail page
  String get doctorName => doctor.name;
  String get doctorSpecialty => doctor.specialization;
  String get doctorAvatar => doctor.avatar;
  bool get isVerified => doctor.isVerified;
  int get likesCount => likes;
  int get commentsCount => comments.length;
  List<String> get hashtags => tags;

  PostModel({
    required this.id,
    required this.doctor,
    required this.content,
    this.imageUrl,
    required this.timestamp,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.isLiked,
    required this.tags,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? '',
      doctor: DoctorProfileModel.fromJson(json['doctor'] ?? {}),
      content: json['content'] ?? '',
      imageUrl: json['imageUrl'],
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      likes: json['likes'] ?? 0,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((comment) => CommentModel.fromJson(comment))
          .toList() ?? [],
      shares: json['shares'] ?? 0,
      isLiked: json['isLiked'] ?? false,
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor': doctor.toJson(),
      'content': content,
      'imageUrl': imageUrl,
      'timestamp': timestamp.toIso8601String(),
      'likes': likes,
      'comments': comments.map((comment) => comment.toJson()).toList(),
      'shares': shares,
      'isLiked': isLiked,
      'tags': tags,
    };
  }

  PostModel copyWith({
    String? id,
    DoctorProfileModel? doctor,
    String? content,
    String? imageUrl,
    DateTime? timestamp,
    int? likes,
    List<CommentModel>? comments,
    int? shares,
    bool? isLiked,
    List<String>? tags,
  }) {
    return PostModel(
      id: id ?? this.id,
      doctor: doctor ?? this.doctor,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      timestamp: timestamp ?? this.timestamp,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      isLiked: isLiked ?? this.isLiked,
      tags: tags ?? this.tags,
    );
  }
}
