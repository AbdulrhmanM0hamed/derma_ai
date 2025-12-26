import 'package:flutter/material.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import '../data/models/post_model.dart';
import '../pages/post_detail_page.dart';

class PostCardWidget extends StatefulWidget {
  final PostModel post;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;

  const PostCardWidget({
    super.key,
    required this.post,
    required this.onLike,
    required this.onComment,
    required this.onShare,
  });

  @override
  State<PostCardWidget> createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _likeAnimationController;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _likeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _likeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailPage(post: widget.post),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Header
            _buildDoctorHeader(theme),
            
            // Post Content
            _buildPostContent(theme),
            
            // Post Image
            if (widget.post.imageUrl != null) _buildPostImage(screenWidth),
            
            // Tags
            if (widget.post.tags.isNotEmpty) _buildTags(),
            
            // Action Buttons
            _buildActionButtons(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorHeader(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(3),
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(widget.post.doctor.avatar),
                ),
              ),
              if (widget.post.doctor.isVerified)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.verified,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        widget.post.doctor.name,
                        style: getBoldStyle(
                          fontSize: 16,
                          fontFamily: FontConstant.cairo,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    if (widget.post.doctor.isVerified) ...[
                      const SizedBox(width: 4),
                      Icon(
                        Icons.verified,
                        color: AppColors.primary,
                        size: 16,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  widget.post.doctor.specialization,
                  style: getRegularStyle(
                    fontSize: 13,
                    fontFamily: FontConstant.cairo,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 12,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatTimeAgo(widget.post.timestamp),
                      style: getRegularStyle(
                        fontSize: 12,
                        fontFamily: FontConstant.cairo,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'save',
                child: Row(
                  children: [
                    const Icon(Icons.bookmark_border),
                    const SizedBox(width: 8),
                    Text('حفظ المنشور'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'report',
                child: Row(
                  children: [
                    const Icon(Icons.report_outlined),
                    const SizedBox(width: 8),
                    Text('إبلاغ'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPostContent(ThemeData theme) {
    final content = widget.post.content;
    final shouldShowMore = content.length > 200;
    final displayContent = _isExpanded || !shouldShowMore
        ? content
        : '${content.substring(0, 200)}...';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            displayContent,
            style: getRegularStyle(
              fontSize: 15,
              fontFamily: FontConstant.cairo,
              color: theme.colorScheme.onSurface,
              height: 1.6,
            ),
          ),
          if (shouldShowMore) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: Text(
                _isExpanded ? 'عرض أقل' : 'عرض المزيد',
                style: getSemiBoldStyle(
                  fontSize: 14,
                  fontFamily: FontConstant.cairo,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPostImage(double screenWidth) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          height: screenWidth * 0.6,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary.withValues(alpha: 0.1),
                AppColors.secondary.withValues(alpha: 0.1),
              ],
            ),
          ),
          child: Image.network(
            widget.post.imageUrl!,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_not_supported_outlined,
                      size: 48,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'لا يمكن تحميل الصورة',
                      style: getRegularStyle(
                        fontSize: 14,
                        fontFamily: FontConstant.cairo,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTags() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: widget.post.tags.map((tag) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
                width: 1,
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
      ),
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.5),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          _buildActionButton(
            icon: widget.post.isLiked ? Icons.favorite : Icons.favorite_border,
            label: '${widget.post.likes}',
            color: widget.post.isLiked ? Colors.red : theme.colorScheme.onSurface.withValues(alpha: 0.6),
            onTap: () {
              widget.onLike();
              if (!widget.post.isLiked) {
                _likeAnimationController.forward().then((_) {
                  _likeAnimationController.reverse();
                });
              }
            },
          ),
          const SizedBox(width: 24),
          _buildActionButton(
            icon: Icons.chat_bubble_outline,
            label: '${widget.post.comments.length}',
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailPage(post: widget.post),
                ),
              );
            },
          ),
          const SizedBox(width: 24),
          _buildActionButton(
            icon: Icons.share_outlined,
            label: '${widget.post.shares}',
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            onTap: widget.onShare,
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  size: 14,
                  color: Colors.amber,
                ),
                const SizedBox(width: 4),
                Text(
                  '${widget.post.doctor.rating}',
                  style: getSemiBoldStyle(
                    fontSize: 12,
                    fontFamily: FontConstant.cairo,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _likeAnimationController,
            builder: (context, child) {
              final scale = icon == Icons.favorite && widget.post.isLiked
                  ? 1.0 + (_likeAnimationController.value * 0.3)
                  : 1.0;
              return Transform.scale(
                scale: scale,
                child: Icon(
                  icon,
                  size: 20,
                  color: color,
                ),
              );
            },
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: getSemiBoldStyle(
              fontSize: 14,
              fontFamily: FontConstant.cairo,
              color: color,
            ),
          ),
        ],
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
