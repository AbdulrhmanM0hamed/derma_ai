import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/models/post_model.dart';

class PostDetailActions extends StatelessWidget {
  final PostModel post;
  final bool isLiked;
  final bool isSaved;
  final VoidCallback onLike;
  final VoidCallback onSave;
  final VoidCallback onShare;

  const PostDetailActions({
    super.key,
    required this.post,
    required this.isLiked,
    required this.isSaved,
    required this.onLike,
    required this.onSave,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Stats Row
          Row(
            children: [
              // Likes Count
              if (post.likes > 0) ...[
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${post.likes}',
                      style: getMediumStyle(
                        fontSize: 14,
                        fontFamily: FontConstant.cairo,
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ],
              
              const Spacer(),
              
              // Comments Count
              if (post.comments.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    // Scroll to comments
                  },
                  child: Text(
                    '${post.comments.length} تعليق',
                    style: getMediumStyle(
                      fontSize: 14,
                      fontFamily: FontConstant.cairo,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ),
            ],
          ),
          
          if (post.likes > 0 || post.comments.isNotEmpty) ...[
            const SizedBox(height: 16),
            Divider(
              color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
              thickness: 1,
            ),
            const SizedBox(height: 16),
          ],
          
          // Action Buttons
          Row(
            children: [
              // Like Button
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onLike();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isLiked 
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? AppColors.primary : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isLiked ? 'أعجبني' : 'إعجاب',
                          style: getSemiBoldStyle(
                            fontSize: 14,
                            fontFamily: FontConstant.cairo,
                            color: isLiked ? AppColors.primary : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate(target: isLiked ? 1 : 0)
                    .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05))
                    .then()
                    .scale(begin: const Offset(1.05, 1.05), end: const Offset(1, 1)),
              ),
              
              const SizedBox(width: 8),
              
              // Comment Button
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    // Focus on comment input
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'تعليق',
                          style: getSemiBoldStyle(
                            fontSize: 14,
                            fontFamily: FontConstant.cairo,
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 8),
              
              // Share Button
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onShare();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.share_outlined,
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
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
                ),
              ),
              
              const SizedBox(width: 8),
              
              // Save Button
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  onSave();
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSaved 
                        ? AppColors.secondary.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: isSaved ? AppColors.secondary : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    size: 20,
                  ),
                ),
              ).animate(target: isSaved ? 1 : 0)
                  .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1))
                  .then()
                  .scale(begin: const Offset(1.1, 1.1), end: const Offset(1, 1)),
            ],
          ),
        ],
      ),
    );
  }
}
