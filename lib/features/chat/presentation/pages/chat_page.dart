import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../data/models/chat_model.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/chat_input_field.dart';

class ChatPage extends StatefulWidget {
  final Map<String, dynamic> doctorData;

  const ChatPage({
    super.key,
    required this.doctorData,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  
  bool _isLoading = true;
  bool _isSending = false;
  ChatModel? _chat;
  List<ChatMessageModel> _messages = [];

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _initializeChat() async {
    // Simulate API call to get or create chat
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _chat = ChatModel(
        id: 'chat_${DateTime.now().millisecondsSinceEpoch}',
        doctorId: widget.doctorData['id'] ?? '',
        doctorName: widget.doctorData['arabicName'] ?? '',
        doctorSpecialty: widget.doctorData['specialty'] ?? '',
        doctorPhoto: widget.doctorData['photo'] ?? '',
        patientId: 'patient_123',
        patientName: 'أحمد محمد',
        patientPhoto: '',
        messages: _messages,
        status: ChatStatus.active,
        createdAt: DateTime.now(),
        consultationFee: 100.0,
      );
      
      // Add welcome message from doctor
      _messages = [
        ChatMessageModel(
          id: 'msg_welcome',
          chatId: _chat!.id,
          senderId: _chat!.doctorId,
          senderName: _chat!.doctorName,
          senderType: 'doctor',
          content: 'مرحباً بك! أنا ${_chat!.doctorName}. كيف يمكنني مساعدتك اليوم؟',
          type: ChatMessageType.text,
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          isRead: true,
        ),
      ];
      
      _isLoading = false;
    });
    
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage(String content) async {
    if (content.trim().isEmpty || _isSending) return;

    setState(() {
      _isSending = true;
    });

    final message = ChatMessageModel(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      chatId: _chat!.id,
      senderId: _chat!.patientId,
      senderName: _chat!.patientName,
      senderType: 'patient',
      content: content.trim(),
      type: ChatMessageType.text,
      timestamp: DateTime.now(),
      isRead: false,
    );

    setState(() {
      _messages.add(message);
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Simulate doctor response (in real app, this would come from server)
    await Future.delayed(const Duration(seconds: 2));
    
    final doctorResponse = ChatMessageModel(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      chatId: _chat!.id,
      senderId: _chat!.doctorId,
      senderName: _chat!.doctorName,
      senderType: 'doctor',
      content: _generateDoctorResponse(content),
      type: ChatMessageType.text,
      timestamp: DateTime.now(),
      isRead: true,
    );

    setState(() {
      _messages.add(doctorResponse);
      _isSending = false;
    });

    _scrollToBottom();
  }

  String _generateDoctorResponse(String patientMessage) {
    // Simple response generator for demo
    final responses = [
      'شكراً لك على هذه المعلومات. هل يمكنك إرسال صورة للمنطقة المصابة؟',
      'أفهم ما تقوله. متى بدأت هذه الأعراض؟',
      'هذا يبدو مثيراً للاهتمام. هل جربت أي علاجات من قبل؟',
      'بناءً على وصفك، أنصحك بـ... هل لديك أي حساسية من الأدوية؟',
      'سأحتاج لفحص المنطقة بشكل أفضل. هل يمكنك حجز موعد للفحص؟',
    ];
    
    return responses[DateTime.now().millisecond % responses.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: _isLoading ? _buildLoadingState() : _buildChatContent(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.grey[700]),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: _chat?.doctorPhoto.isNotEmpty == true
                ? NetworkImage(_chat!.doctorPhoto)
                : null,
            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            child: _chat?.doctorPhoto.isEmpty != false
                ? Icon(Icons.person, color: AppColors.primary, size: 20)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _chat?.doctorName ?? 'الطبيب',
                  style: getBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'متاح الآن',
                  style: getRegularStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 12,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.videocam, color: AppColors.primary),
          onPressed: () {
            // Navigate to video call
          },
        ),
        IconButton(
          icon: Icon(Icons.more_vert, color: Colors.grey[700]),
          onPressed: () {
            _showChatOptions();
          },
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildChatContent() {
    return Column(
      children: [
        _buildChatInfo(),
        Expanded(
          child: _buildMessagesList(),
        ),
        ChatInputField(
          controller: _messageController,
          focusNode: _focusNode,
          onSend: _sendMessage,
          isSending: _isSending,
        ),
      ],
    );
  }

  Widget _buildChatInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'رسوم الاستشارة: ${_chat?.consultationFee?.toStringAsFixed(0) ?? '100'} ريال',
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: 14,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.3);
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        final isLastMessage = index == _messages.length - 1;
        
        return ChatMessageBubble(
          message: message,
          isLastMessage: isLastMessage,
        ).animate().fadeIn(
          duration: 300.ms,
          delay: Duration(milliseconds: index * 50),
        ).slideX(
          begin: message.isFromPatient ? 0.3 : -0.3,
        );
      },
    );
  }

  void _showChatOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            _buildOptionItem(
              icon: Icons.videocam,
              title: 'بدء مكالمة فيديو',
              subtitle: 'احجز مكالمة فيديو مع الطبيب',
              onTap: () {
                Navigator.pop(context);
                // Navigate to video call booking
              },
            ),
            _buildOptionItem(
              icon: Icons.image,
              title: 'إرسال صورة',
              subtitle: 'أرسل صورة للمنطقة المصابة',
              onTap: () {
                Navigator.pop(context);
                // Handle image upload
              },
            ),
            _buildOptionItem(
              icon: Icons.archive,
              title: 'أرشفة المحادثة',
              subtitle: 'نقل المحادثة إلى الأرشيف',
              onTap: () {
                Navigator.pop(context);
                // Handle archive
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: getSemiBoldStyle(
          fontFamily: FontConstant.cairo,
          fontSize: 14,
          color: Colors.black87,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: getRegularStyle(
          fontFamily: FontConstant.cairo,
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
      onTap: onTap,
    );
  }
}
