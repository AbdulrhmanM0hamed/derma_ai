import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../data/models/chat_model.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessageModel message;
  final bool isLastMessage;

  const ChatMessageBubble({
    super.key,
    required this.message,
    this.isLastMessage = false,
  });

  @override
  Widget build(BuildContext context) {
    final isFromPatient = message.isFromPatient;
    
    return Container(
      margin: EdgeInsets.only(
        bottom: isLastMessage ? 16 : 8,
        left: isFromPatient ? 0 : 60,
        right: isFromPatient ? 60 : 0,
      ),
      child: Column(
        crossAxisAlignment: isFromPatient 
            ? CrossAxisAlignment.end 
            : CrossAxisAlignment.start,
        children: [
          if (!isFromPatient) _buildDoctorHeader(),
          _buildMessageBubble(isFromPatient),
          const SizedBox(height: 4),
          _buildMessageTime(isFromPatient),
        ],
      ),
    );
  }

  Widget _buildDoctorHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, right: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            message.senderName,
            style: getSemiBoldStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 12,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(bool isFromPatient) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isFromPatient 
            ? AppColors.primary 
            : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: Radius.circular(isFromPatient ? 16 : 4),
          bottomRight: Radius.circular(isFromPatient ? 4 : 16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: _buildMessageContent(isFromPatient),
    );
  }

  Widget _buildMessageContent(bool isFromPatient) {
    switch (message.type) {
      case ChatMessageType.text:
        return _buildTextMessage(isFromPatient);
      case ChatMessageType.image:
        return _buildImageMessage(isFromPatient);
      case ChatMessageType.file:
        return _buildFileMessage(isFromPatient);
      case ChatMessageType.voice:
        return _buildVoiceMessage(isFromPatient);
      case ChatMessageType.system:
        return _buildSystemMessage();
    }
  }

  Widget _buildTextMessage(bool isFromPatient) {
    return Text(
      message.content,
      style: getRegularStyle(
        fontFamily: FontConstant.cairo,
        fontSize: 14,
        color: isFromPatient ? Colors.white : Colors.black87,
      ),
    );
  }

  Widget _buildImageMessage(bool isFromPatient) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (message.content.isNotEmpty) ...[
          Text(
            message.content,
            style: getRegularStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 14,
              color: isFromPatient ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            message.attachmentUrl ?? '',
            width: 200,
            height: 150,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.image, size: 50),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFileMessage(bool isFromPatient) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isFromPatient 
                ? Colors.white.withValues(alpha: 0.2)
                : AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.attach_file,
            color: isFromPatient ? Colors.white : AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.content,
                style: getSemiBoldStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 14,
                  color: isFromPatient ? Colors.white : Colors.black87,
                ),
              ),
              Text(
                message.attachmentType ?? 'ملف',
                style: getRegularStyle(
                  fontFamily: FontConstant.cairo,
                  fontSize: 12,
                  color: isFromPatient 
                      ? Colors.white.withValues(alpha: 0.8)
                      : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVoiceMessage(bool isFromPatient) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isFromPatient 
                ? Colors.white.withValues(alpha: 0.2)
                : AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.play_arrow,
            color: isFromPatient ? Colors.white : AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: isFromPatient 
                  ? Colors.white.withValues(alpha: 0.3)
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.6,
              child: Container(
                decoration: BoxDecoration(
                  color: isFromPatient ? Colors.white : AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '0:45',
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 12,
            color: isFromPatient 
                ? Colors.white.withValues(alpha: 0.8)
                : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildSystemMessage() {
    return Text(
      message.content,
      style: getRegularStyle(
        fontFamily: FontConstant.cairo,
        fontSize: 12,
        color: Colors.grey[600],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildMessageTime(bool isFromPatient) {
    return Padding(
      padding: EdgeInsets.only(
        right: isFromPatient ? 12 : 0,
        left: isFromPatient ? 0 : 12,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DateFormat('HH:mm').format(message.timestamp),
            style: getRegularStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 11,
              color: Colors.grey[500],
            ),
          ),
          if (isFromPatient) ...[
            const SizedBox(width: 4),
            Icon(
              message.isRead ? Icons.done_all : Icons.done,
              size: 14,
              color: message.isRead ? AppColors.primary : Colors.grey[400],
            ),
          ],
        ],
      ),
    );
  }
}
