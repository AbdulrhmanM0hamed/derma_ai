import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/models/comment_model.dart';

class PostDetailComments extends StatelessWidget {
  final List<CommentModel> comments;
  final Function(CommentModel) onLikeComment;

  const PostDetailComments({
    super.key,
    required this.comments,
    required this.onLikeComment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Comments Header
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                Icons.chat_bubble_outline,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'التعليقات (${comments.length})',
                style: getBoldStyle(
                  fontSize: 16,
                  fontFamily: FontConstant.cairo,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),

        // Comments List
        if (comments.isEmpty)
          Container(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                  size: 48,
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
                const SizedBox(height: 8),
                Text(
                  'كن أول من يعلق على هذا المنشور',
                  style: getRegularStyle(
                    fontSize: 14,
                    fontFamily: FontConstant.cairo,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          )
        else
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: comments.length,
            separatorBuilder: (context, index) => Divider(
              color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            itemBuilder: (context, index) {
              final comment = comments[index];
              return Column(
                children: [
                  _CommentItem(
                    comment: comment,
                    onLike: () => onLikeComment(comment),
                    isReply: false,
                  ).animate(delay: Duration(milliseconds: 100 * index))
                      .fadeIn()
                      .slideX(begin: 0.3),
                  
                  // Replies
                  if (comment.replies.isNotEmpty)
                    ...comment.replies.map((reply) => 
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: _CommentItem(
                          comment: reply,
                          onLike: () => onLikeComment(reply),
                          isReply: true,
                        ).animate(delay: Duration(milliseconds: 150 * index))
                            .fadeIn()
                            .slideX(begin: 0.5),
                      ),
                    ).toList(),
                ],
              );
            },
          ),
      ],
    );
  }
}

class _CommentItem extends StatelessWidget {
  final CommentModel comment;
  final VoidCallback onLike;
  final bool isReply;

  const _CommentItem({
    required this.comment,
    required this.onLike,
    this.isReply = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: ClipOval(
              child: Image.network(
                comment.userAvatar,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    child: Icon(
                      Icons.person,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Comment Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Comment Bubble
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: comment.isDoctor 
                        ? AppColors.primary.withValues(alpha: 0.05)
                        : Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: comment.isDoctor 
                          ? AppColors.primary.withValues(alpha: 0.3)
                          : Theme.of(context).dividerColor.withValues(alpha: 0.2),
                      width: comment.isDoctor ? 1.5 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User Name with Doctor Badge
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              comment.userName,
                              style: getSemiBoldStyle(
                                fontSize: 14,
                                fontFamily: FontConstant.cairo,
                                color: comment.isDoctor ? AppColors.primary : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                          if (comment.isDoctor) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.verified,
                                    color: Colors.white,
                                    size: 10,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    'طبيب',
                                    style: getBoldStyle(
                                      fontSize: 9,
                                      fontFamily: FontConstant.cairo,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (comment.isDoctor && comment.doctorSpecialization != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          comment.doctorSpecialization!,
                          style: getRegularStyle(
                            fontSize: 11,
                            fontFamily: FontConstant.cairo,
                            color: AppColors.primary.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                      const SizedBox(height: 4),
                      
                      // Comment Text
                      Text(
                        comment.content,
                        style: getRegularStyle(
                          fontSize: 14,
                          fontFamily: FontConstant.cairo,
                          color: Theme.of(context).colorScheme.onSurface,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                
                // Comment Actions
                Row(
                  children: [
                    // Timestamp
                    Text(
                      _formatTimestamp(comment.timestamp),
                      style: getRegularStyle(
                        fontSize: 12,
                        fontFamily: FontConstant.cairo,
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    // Like Button
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        onLike();
                      },
                      child: Row(
                        children: [
                          Icon(
                            comment.isLiked ? Icons.favorite : Icons.favorite_border,
                            color: comment.isLiked ? AppColors.primary : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                            size: 16,
                          ),
                          if (comment.likes> 0) ...[
                            const SizedBox(width: 4),
                            Text(
                              '${comment.likes}',
                              style: getRegularStyle(
                                fontSize: 12,
                                fontFamily: FontConstant.cairo,
                                color: comment.isLiked ? AppColors.primary : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ).animate(target: comment.isLiked ? 1 : 0)
                        .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2))
                        .then()
                        .scale(begin: const Offset(1.2, 1.2), end: const Offset(1, 1)),
                    
                    const SizedBox(width: 16),
                    
                    // Reply Button (only for main comments)
                    if (!isReply)
                      GestureDetector(
                        onTap: () {
                          // Handle reply
                        },
                        child: Text(
                          'رد',
                          style: getSemiBoldStyle(
                            fontSize: 12,
                            fontFamily: FontConstant.cairo,
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'الآن';
    } else if (difference.inMinutes < 60) {
      return 'منذ ${difference.inMinutes} د';
    } else if (difference.inHours < 24) {
      return 'منذ ${difference.inHours} س';
    } else if (difference.inDays < 7) {
      return 'منذ ${difference.inDays} ي';
    } else {
      return '${timestamp.day}/${timestamp.month}';
    }
  }
}
