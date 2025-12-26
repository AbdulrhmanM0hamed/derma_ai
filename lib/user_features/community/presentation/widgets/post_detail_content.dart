import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../data/models/post_model.dart';

class PostDetailContent extends StatelessWidget {
  final PostModel post;

  const PostDetailContent({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Content
          Text(
            post.content,
            style: getRegularStyle(
              fontSize: 16,
              fontFamily: FontConstant.cairo,
              color: Theme.of(context).colorScheme.onSurface,
              height: 1.6,
            ),
          ),
          
          if (post.imageUrl != null) ...[
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                post.imageUrl!,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_not_supported,
                            color: AppColors.primary.withValues(alpha: 0.5),
                            size: 48,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'تعذر تحميل الصورة',
                            style: getMediumStyle(
                              fontSize: 14,
                              fontFamily: FontConstant.cairo,
                              color: AppColors.primary.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],

          if (post.tags.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: post.tags.map((hashtag) {
                return GestureDetector(
                  onTap: () {
                    // Handle hashtag tap
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      '#$hashtag',
                      style: getSemiBoldStyle(
                        fontSize: 12,
                        fontFamily: FontConstant.cairo,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
