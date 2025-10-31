import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../data/models/post_model.dart';
import '../data/models/comment_model.dart';

class SimplePostDetailPage extends StatefulWidget {
  final PostModel post;

  const SimplePostDetailPage({
    super.key,
    required this.post,
  });

  @override
  State<SimplePostDetailPage> createState() => _SimplePostDetailPageState();
}

class _SimplePostDetailPageState extends State<SimplePostDetailPage> {
  late PostModel _post;
  final TextEditingController _commentController = TextEditingController();
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _post = widget.post;
    _isLiked = _post.isLiked;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked) {
        _post = _post.copyWith(likes: _post.likes + 1);
      } else {
        _post = _post.copyWith(likes: _post.likes - 1);
      }
    });
    HapticFeedback.lightImpact();
  }

  void _addComment() {
    if (_commentController.text.trim().isEmpty) return;

    final newComment = CommentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userName: 'أنت',
      userAvatar: 'https://via.placeholder.com/40',
      content: _commentController.text.trim(),
      timestamp: DateTime.now(),
      likes: 0,
      isLiked: false,
    );

    setState(() {
      _post = _post.copyWith(
        comments: [..._post.comments, newComment],
      );
    });

    _commentController.clear();
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'تفاصيل المنشور',
          style: getBoldStyle(
            fontSize: 18,
            fontFamily: FontConstant.cairo,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Post Header
                  _buildPostHeader(),
                  const SizedBox(height: 16),
                  
                  // Post Content
                  _buildPostContent(),
                  
                  if (_post.imageUrl != null) ...[
                    const SizedBox(height: 16),
                    _buildPostImage(),
                  ],
                  
                  if (_post.tags.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildHashtags(),
                  ],
                  
                  const SizedBox(height: 20),
                  
                  // Post Actions
                  _buildPostActions(),
                  
                  const SizedBox(height: 24),
                  
                  // Comments Section
                  _buildCommentsSection(),
                ],
              ),
            ),
          ),
          
          // Add Comment Bar
          _buildAddCommentBar(),
        ],
      ),
    );
  }

  Widget _buildPostHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(_post.doctor.avatar),
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    _post.doctor.name,
                    style: getBoldStyle(
                      fontSize: 16,
                      fontFamily: FontConstant.cairo,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  if (_post.doctor.isVerified) ...[
                    const SizedBox(width: 4),
                    Icon(
                      Icons.verified,
                      color: AppColors.primary,
                      size: 16,
                    ),
                  ],
                ],
              ),
              Text(
                _post.doctor.specialization,
                style: getMediumStyle(
                  fontSize: 14,
                  fontFamily: FontConstant.cairo,
                  color: AppColors.primary,
                ),
              ),
              Text(
                _formatTimeAgo(_post.timestamp),
                style: getRegularStyle(
                  fontSize: 12,
                  fontFamily: FontConstant.cairo,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPostContent() {
    return Text(
      _post.content,
      style: getRegularStyle(
        fontSize: 15,
        fontFamily: FontConstant.cairo,
        color: Theme.of(context).colorScheme.onSurface,
        height: 1.6,
      ),
    );
  }

  Widget _buildPostImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        _post.imageUrl!,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                Icons.image_not_supported,
                color: AppColors.primary.withValues(alpha: 0.5),
                size: 48,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHashtags() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _post.tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            '#$tag',
            style: getSemiBoldStyle(
              fontSize: 12,
              fontFamily: FontConstant.cairo,
              color: AppColors.primary,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPostActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Like Button
          GestureDetector(
            onTap: _toggleLike,
            child: Row(
              children: [
                Icon(
                  _isLiked ? Icons.favorite : Icons.favorite_border,
                  color: _isLiked ? Colors.red : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  size: 20,
                ),
                const SizedBox(width: 6),
                Text(
                  '${_post.likes}',
                  style: getSemiBoldStyle(
                    fontSize: 14,
                    fontFamily: FontConstant.cairo,
                    color: _isLiked ? Colors.red : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          
          // Comment Button
          Row(
            children: [
              Icon(
                Icons.chat_bubble_outline,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                size: 20,
              ),
              const SizedBox(width: 6),
              Text(
                '${_post.comments.length}',
                style: getSemiBoldStyle(
                  fontSize: 14,
                  fontFamily: FontConstant.cairo,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          
          // Share Button
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم نسخ الرابط')),
              );
            },
            child: Row(
              children: [
                Icon(
                  Icons.share_outlined,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  size: 20,
                ),
                const SizedBox(width: 6),
                Text(
                  'مشاركة',
                  style: getSemiBoldStyle(
                    fontSize: 14,
                    fontFamily: FontConstant.cairo,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'التعليقات (${_post.comments.length})',
          style: getBoldStyle(
            fontSize: 16,
            fontFamily: FontConstant.cairo,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        
        if (_post.comments.isEmpty)
          Container(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 48,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد تعليقات بعد',
                    style: getMediumStyle(
                      fontSize: 16,
                      fontFamily: FontConstant.cairo,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _post.comments.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final comment = _post.comments[index];
              return _buildCommentItem(comment);
            },
          ),
      ],
    );
  }

  Widget _buildCommentItem(CommentModel comment) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(comment.userAvatar),
          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.userName,
                  style: getSemiBoldStyle(
                    fontSize: 14,
                    fontFamily: FontConstant.cairo,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  comment.content,
                  style: getRegularStyle(
                    fontSize: 14,
                    fontFamily: FontConstant.cairo,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _formatTimeAgo(comment.timestamp),
                  style: getRegularStyle(
                    fontSize: 12,
                    fontFamily: FontConstant.cairo,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddCommentBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _commentController,
                textDirection: TextDirection.rtl,
                style: getRegularStyle(
                  fontSize: 14,
                  fontFamily: FontConstant.cairo,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                  hintText: 'اكتب تعليقاً...',
                  hintStyle: getRegularStyle(
                    fontSize: 14,
                    fontFamily: FontConstant.cairo,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: AppColors.primary,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _addComment,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return 'منذ ${difference.inMinutes} دقيقة';
    } else if (difference.inHours < 24) {
      return 'منذ ${difference.inHours} ساعة';
    } else {
      return 'منذ ${difference.inDays} يوم';
    }
  }
}
