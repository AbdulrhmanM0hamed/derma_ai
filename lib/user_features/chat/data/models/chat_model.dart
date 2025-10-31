class ChatModel {
  final String id;
  final String doctorId;
  final String doctorName;
  final String doctorSpecialty;
  final String doctorPhoto;
  final String patientId;
  final String patientName;
  final String patientPhoto;
  final List<ChatMessageModel> messages;
  final ChatStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? lastMessageAt;
  final bool isActive;
  final double? consultationFee;

  ChatModel({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorPhoto,
    required this.patientId,
    required this.patientName,
    required this.patientPhoto,
    required this.messages,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.lastMessageAt,
    this.isActive = true,
    this.consultationFee,
  });

  ChatModel copyWith({
    String? id,
    String? doctorId,
    String? doctorName,
    String? doctorSpecialty,
    String? doctorPhoto,
    String? patientId,
    String? patientName,
    String? patientPhoto,
    List<ChatMessageModel>? messages,
    ChatStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastMessageAt,
    bool? isActive,
    double? consultationFee,
  }) {
    return ChatModel(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      doctorSpecialty: doctorSpecialty ?? this.doctorSpecialty,
      doctorPhoto: doctorPhoto ?? this.doctorPhoto,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      patientPhoto: patientPhoto ?? this.patientPhoto,
      messages: messages ?? this.messages,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      isActive: isActive ?? this.isActive,
      consultationFee: consultationFee ?? this.consultationFee,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'doctorSpecialty': doctorSpecialty,
      'doctorPhoto': doctorPhoto,
      'patientId': patientId,
      'patientName': patientName,
      'patientPhoto': patientPhoto,
      'messages': messages.map((m) => m.toJson()).toList(),
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'lastMessageAt': lastMessageAt?.toIso8601String(),
      'isActive': isActive,
      'consultationFee': consultationFee,
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] ?? '',
      doctorId: json['doctorId'] ?? '',
      doctorName: json['doctorName'] ?? '',
      doctorSpecialty: json['doctorSpecialty'] ?? '',
      doctorPhoto: json['doctorPhoto'] ?? '',
      patientId: json['patientId'] ?? '',
      patientName: json['patientName'] ?? '',
      patientPhoto: json['patientPhoto'] ?? '',
      messages: (json['messages'] as List<dynamic>?)
          ?.map((m) => ChatMessageModel.fromJson(m))
          .toList() ?? [],
      status: ChatStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ChatStatus.active,
      ),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      lastMessageAt: json['lastMessageAt'] != null ? DateTime.parse(json['lastMessageAt']) : null,
      isActive: json['isActive'] ?? true,
      consultationFee: json['consultationFee']?.toDouble(),
    );
  }

  ChatMessageModel? get lastMessage {
    return messages.isNotEmpty ? messages.last : null;
  }

  int get unreadCount {
    return messages.where((m) => !m.isRead && m.senderId != patientId).length;
  }
}

class ChatMessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final String senderName;
  final String senderType; // 'doctor' or 'patient'
  final String content;
  final ChatMessageType type;
  final DateTime timestamp;
  final bool isRead;
  final String? attachmentUrl;
  final String? attachmentType;
  final String? replyToMessageId;

  ChatMessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.senderName,
    required this.senderType,
    required this.content,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    this.attachmentUrl,
    this.attachmentType,
    this.replyToMessageId,
  });

  ChatMessageModel copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? senderName,
    String? senderType,
    String? content,
    ChatMessageType? type,
    DateTime? timestamp,
    bool? isRead,
    String? attachmentUrl,
    String? attachmentType,
    String? replyToMessageId,
  }) {
    return ChatMessageModel(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderType: senderType ?? this.senderType,
      content: content ?? this.content,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      attachmentType: attachmentType ?? this.attachmentType,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'senderName': senderName,
      'senderType': senderType,
      'content': content,
      'type': type.name,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'attachmentUrl': attachmentUrl,
      'attachmentType': attachmentType,
      'replyToMessageId': replyToMessageId,
    };
  }

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] ?? '',
      chatId: json['chatId'] ?? '',
      senderId: json['senderId'] ?? '',
      senderName: json['senderName'] ?? '',
      senderType: json['senderType'] ?? '',
      content: json['content'] ?? '',
      type: ChatMessageType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ChatMessageType.text,
      ),
      timestamp: DateTime.parse(json['timestamp']),
      isRead: json['isRead'] ?? false,
      attachmentUrl: json['attachmentUrl'],
      attachmentType: json['attachmentType'],
      replyToMessageId: json['replyToMessageId'],
    );
  }

  bool get isFromDoctor => senderType == 'doctor';
  bool get isFromPatient => senderType == 'patient';
}

enum ChatStatus {
  active,
  ended,
  archived,
}

enum ChatMessageType {
  text,
  image,
  file,
  voice,
  system,
}

extension ChatStatusExtension on ChatStatus {
  String get arabicName {
    switch (this) {
      case ChatStatus.active:
        return 'نشط';
      case ChatStatus.ended:
        return 'منتهي';
      case ChatStatus.archived:
        return 'مؤرشف';
    }
  }
}

extension ChatMessageTypeExtension on ChatMessageType {
  String get arabicName {
    switch (this) {
      case ChatMessageType.text:
        return 'نص';
      case ChatMessageType.image:
        return 'صورة';
      case ChatMessageType.file:
        return 'ملف';
      case ChatMessageType.voice:
        return 'رسالة صوتية';
      case ChatMessageType.system:
        return 'رسالة نظام';
    }
  }
}
