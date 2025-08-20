class CommentModel {
  final String id;
  final String userName;
  final String userAvatar;
  final String content;
  final DateTime timestamp;
  final int likes;
  final bool isLiked;
  final String? parentId;
  final List<CommentModel> replies;
  final bool isDoctor;
  final String? doctorSpecialization;

  CommentModel({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.content,
    required this.timestamp,
    required this.likes,
    required this.isLiked,
    this.parentId,
    this.replies = const [],
    this.isDoctor = false,
    this.doctorSpecialization,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      userAvatar: json['userAvatar'] ?? '',
      content: json['content'] ?? '',
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      likes: json['likes'] ?? 0,
      isLiked: json['isLiked'] ?? false,
      parentId: json['parentId'],
      replies: (json['replies'] as List<dynamic>?)?.map((e) => CommentModel.fromJson(e)).toList() ?? [],
      isDoctor: json['isDoctor'] ?? false,
      doctorSpecialization: json['doctorSpecialization'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'userAvatar': userAvatar,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'likes': likes,
      'isLiked': isLiked,
      'parentId': parentId,
      'replies': replies.map((e) => e.toJson()).toList(),
      'isDoctor': isDoctor,
      'doctorSpecialization': doctorSpecialization,
    };
  }

  CommentModel copyWith({
    String? id,
    String? userName,
    String? userAvatar,
    String? content,
    DateTime? timestamp,
    int? likes,
    bool? isLiked,
    String? parentId,
    List<CommentModel>? replies,
    bool? isDoctor,
    String? doctorSpecialization,
  }) {
    return CommentModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      likes: likes ?? this.likes,
      isLiked: isLiked ?? this.isLiked,
      parentId: parentId ?? this.parentId,
      replies: replies ?? this.replies,
      isDoctor: isDoctor ?? this.isDoctor,
      doctorSpecialization: doctorSpecialization ?? this.doctorSpecialization,
    );
  }
}
