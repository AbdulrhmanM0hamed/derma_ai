import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../data/models/post_model.dart';
import '../data/models/comment_model.dart';
import '../widgets/post_detail_header.dart';
import '../widgets/post_detail_content.dart';
import '../widgets/post_detail_actions.dart';
import '../widgets/post_detail_comments.dart';
import '../widgets/add_comment_widget.dart';

class PostDetailPage extends StatefulWidget {
  final PostModel post;

  const PostDetailPage({
    super.key,
    required this.post,
  });

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  late PostModel _post;
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLiked = false;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _post = widget.post;
    _isLiked = false; // Check if user liked this post
    _isSaved = false; // Check if user saved this post
  }

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
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
  }

  void _toggleSave() {
    setState(() {
      _isSaved = !_isSaved;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isSaved ? 'تم حفظ المنشور' : 'تم إلغاء حفظ المنشور',
          style: getMediumStyle(
            fontSize: 14,
            fontFamily: FontConstant.cairo,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
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
    
    // Scroll to bottom to show new comment
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _likeComment(CommentModel comment) {
    setState(() {
      final updatedComments = _post.comments.map((c) {
        if (c.id == comment.id) {
          return c.copyWith(
            isLiked: !c.isLiked,
            likes: c.isLiked ? c.likes - 1 : c.likes + 1,
          );
        }
        return c;
      }).toList();
      
      _post = _post.copyWith(comments: updatedComments);
    });
  }

  void _sharePost() {
    // Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم نسخ رابط المنشور',
          style: getMediumStyle(
            fontSize: 14,
            fontFamily: FontConstant.cairo,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 60,
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 18,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'تفاصيل المنشور',
              style: getBoldStyle(
                fontSize: 18,
                fontFamily: FontConstant.cairo,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.more_vert,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 18,
                  ),
                ),
                onPressed: () {
                  // Show more options
                },
              ),
              const SizedBox(width: 16),
            ],
          ),

          // Post Content
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
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
                  // Post Header
                  PostDetailHeader(post: _post)
                      .animate()
                      .fadeIn(delay: 100.ms)
                      .slideY(begin: 0.2),

                  // Post Content
                  PostDetailContent(post: _post)
                      .animate()
                      .fadeIn(delay: 200.ms)
                      .slideY(begin: 0.2),

                  // Post Actions
                  PostDetailActions(
                    post: _post,
                    isLiked: _isLiked,
                    isSaved: _isSaved,
                    onLike: _toggleLike,
                    onSave: _toggleSave,
                    onShare: _sharePost,
                  ).animate()
                      .fadeIn(delay: 300.ms)
                      .slideY(begin: 0.2),
                ],
              ),
            ),
          ),

          // Comments Section
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: PostDetailComments(
                comments: _post.comments,
                onLikeComment: _likeComment,
              ).animate()
                  .fadeIn(delay: 400.ms)
                  .slideY(begin: 0.3),
            ),
          ),

          // Add some bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
      
      // Add Comment Bottom Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: AddCommentWidget(
            controller: _commentController,
            onSubmit: _addComment,
          ).animate()
              .fadeIn(delay: 500.ms)
              .slideY(begin: 1),
        ),
      ),
    );
  }
}
