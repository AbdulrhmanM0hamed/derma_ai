import 'package:flutter/material.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class ChatInputField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onSend;
  final bool isSending;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSend,
    this.isSending = false,
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = widget.controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  void _handleSend() {
    if (_hasText && !widget.isSending) {
      widget.onSend(widget.controller.text);
    }
  }

  void _showAttachmentOptions() {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAttachmentOption(
                  icon: Icons.camera_alt,
                  label: 'كاميرا',
                  color: Colors.blue,
                  onTap: () {
                    Navigator.pop(context);
                    // Handle camera
                  },
                ),
                _buildAttachmentOption(
                  icon: Icons.photo_library,
                  label: 'معرض الصور',
                  color: Colors.green,
                  onTap: () {
                    Navigator.pop(context);
                    // Handle gallery
                  },
                ),
                _buildAttachmentOption(
                  icon: Icons.attach_file,
                  label: 'ملف',
                  color: Colors.orange,
                  onTap: () {
                    Navigator.pop(context);
                    // Handle file
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: getRegularStyle(
              fontFamily: FontConstant.cairo,
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Attachment button
            GestureDetector(
              onTap: _showAttachmentOptions,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            
            // Text input field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                  style: getRegularStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    hintText: 'اكتب رسالتك...',
                    hintStyle: getRegularStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onSubmitted: (_) => _handleSend(),
                ),
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Send button
            GestureDetector(
              onTap: _handleSend,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _hasText && !widget.isSending 
                      ? AppColors.primary 
                      : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: widget.isSending
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _hasText ? Colors.white : Colors.grey[600]!,
                          ),
                        ),
                      )
                    : Icon(
                        Icons.send,
                        color: _hasText ? Colors.white : Colors.grey[600],
                        size: 20,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
