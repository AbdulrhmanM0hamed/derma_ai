import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key, this.initialTab = 0});

  final int initialTab;

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage>
    with TickerProviderStateMixin {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _hashtagController = TextEditingController();
  final FocusNode _contentFocusNode = FocusNode();
  final FocusNode _hashtagFocusNode = FocusNode();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  String? _selectedSpecialization;
  final List<String> _selectedHashtags = [];
  final List<File> _selectedImages = [];
  bool _isLoading = false;
  bool _allowComments = true;
  bool _isPublic = true;

  final List<String> _specializations = [
    'الأمراض الجلدية',
    'الطب الباطني',
    'طب الأطفال',
    'الجراحة العامة',
    'أمراض القلب',
    'طب العيون',
    'طب الأسنان',
    'النساء والتوليد',
    'العظام',
    'الطب النفسي',
  ];

  final List<String> _suggestedHashtags = [
    'نصائح_طبية',
    'الوقاية',
    'العلاج',
    'الصحة_العامة',
    'الأمراض_الجلدية',
    'التغذية',
    'الرياضة',
    'الصحة_النفسية',
    'الأدوية',
    'التشخيص',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _contentController.dispose();
    _hashtagController.dispose();
    _contentFocusNode.dispose();
    _hashtagFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    
    if (images.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(images.map((xFile) => File(xFile.path)));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _addHashtag(String hashtag) {
    if (hashtag.isNotEmpty && !_selectedHashtags.contains(hashtag)) {
      setState(() {
        _selectedHashtags.add(hashtag);
      });
    }
  }

  void _removeHashtag(String hashtag) {
    setState(() {
      _selectedHashtags.remove(hashtag);
    });
  }

  Future<void> _publishPost() async {
    if (_contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('يرجى كتابة محتوى المنشور'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم نشر المنشور بنجاح'),
        backgroundColor: AppColors.primary,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.grey[600]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'إنشاء منشور جديد',
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            color: Colors.black87,
            fontSize: FontSize.size18,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton(
              onPressed: _isLoading ? null : _publishPost,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              child: _isLoading
                  ? SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      'نشر',
                      style: getSemiBoldStyle(
                        fontFamily: FontConstant.cairo,
                        color: Colors.white,
                        fontSize: FontSize.size14,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Doctor Info Header
                    _buildDoctorHeader(),
                    const SizedBox(height: 20),
                    
                    // Content Input
                    _buildContentInput(),
                    const SizedBox(height: 20),
                    
                    // Images Section
                    if (_selectedImages.isNotEmpty) ...[
                      _buildImagesSection(),
                      const SizedBox(height: 20),
                    ],
                    
                    // Specialization Selection
                    _buildSpecializationSection(),
                    const SizedBox(height: 20),
                    
                    // Hashtags Section
                    _buildHashtagsSection(),
                    const SizedBox(height: 20),
                    
                    // Quick Actions
                    _buildQuickActions(),
                    const SizedBox(height: 20),
                    
                    // Post Settings
                    _buildPostSettings(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextPostTab() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDoctorHeader(),
                  const SizedBox(height: 20),
                  _buildContentInput(),
                  const SizedBox(height: 20),
                  _buildSpecializationSection(),
                  const SizedBox(height: 20),
                  _buildHashtagsSection(),
                  const SizedBox(height: 20),
                  _buildPostSettings(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImagePostTab() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDoctorHeader(),
                  const SizedBox(height: 20),
                  _buildContentInput(),
                  const SizedBox(height: 20),
                  if (_selectedImages.isNotEmpty) ...[
                    _buildImagesSection(),
                    const SizedBox(height: 20),
                  ],
                  _buildQuickActions(),
                  const SizedBox(height: 20),
                  _buildSpecializationSection(),
                  const SizedBox(height: 20),
                  _buildHashtagsSection(),
                  const SizedBox(height: 20),
                  _buildPostSettings(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildVideoPostTab() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDoctorHeader(),
                  const SizedBox(height: 20),
                  _buildContentInput(),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha:0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.blue.withValues(alpha:0.3)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.videocam, size: 48, color: Colors.blue),
                        const SizedBox(height: 12),
                        Text(
                          'إضافة فيديو',
                          style: getSemiBoldStyle(
                            fontFamily: FontConstant.cairo,
                            color: Colors.blue,
                            fontSize: FontSize.size16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'قريباً - ستتمكن من رفع الفيديوهات الطبية',
                          style: getRegularStyle(
                            fontFamily: FontConstant.cairo,
                            color: Colors.grey[600],
                            fontSize: FontSize.size14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSpecializationSection(),
                  const SizedBox(height: 20),
                  _buildHashtagsSection(),
                  const SizedBox(height: 20),
                  _buildPostSettings(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPollPostTab() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDoctorHeader(),
                  const SizedBox(height: 20),
                  _buildContentInput(),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha:0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.green.withValues(alpha:0.3)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.poll, size: 48, color: Colors.green),
                        const SizedBox(height: 12),
                        Text(
                          'إنشاء استطلاع',
                          style: getSemiBoldStyle(
                            fontFamily: FontConstant.cairo,
                            color: Colors.green,
                            fontSize: FontSize.size16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'قريباً - ستتمكن من إنشاء استطلاعات طبية',
                          style: getRegularStyle(
                            fontFamily: FontConstant.cairo,
                            color: Colors.grey[600],
                            fontSize: FontSize.size14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSpecializationSection(),
                  const SizedBox(height: 20),
                  _buildHashtagsSection(),
                  const SizedBox(height: 20),
                  _buildPostSettings(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDoctorHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              Icons.medical_services,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'د. أحمد محمد',
                      style: getSemiBoldStyle(
                        fontFamily: FontConstant.cairo,
                        color: Colors.black87,
                        fontSize: FontSize.size16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.verified,
                            color: Colors.white,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'طبيب معتمد',
                            style: getRegularStyle(
                              fontFamily: FontConstant.cairo,
                              color: Colors.white,
                              fontSize: FontSize.size10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'أخصائي الأمراض الجلدية',
                  style: getRegularStyle(
                    fontFamily: FontConstant.cairo,
                    color: Colors.grey[600],
                    fontSize: FontSize.size14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildContentInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _contentController,
        focusNode: _contentFocusNode,
        maxLines: 8,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          hintText: 'شارك خبرتك الطبية أو نصيحة مفيدة للمرضى...',
          hintStyle: getRegularStyle(
            fontFamily: FontConstant.cairo,
            color: Colors.grey[500],
            fontSize: FontSize.size16,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
        ),
        style: getRegularStyle(
          fontFamily: FontConstant.cairo,
          color: Colors.black87,
          fontSize: FontSize.size16,
        ),
      ),
    ).animate().fadeIn(duration: 700.ms, delay: 100.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildImagesSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'الصور المرفقة',
              style: getSemiBoldStyle(
                fontFamily: FontConstant.cairo,
                color: Colors.black87,
                fontSize: FontSize.size16,
              ),
            ),
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _selectedImages.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  margin: const EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: FileImage(_selectedImages[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSpecializationSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'التخصص الطبي',
            style: getSemiBoldStyle(
              fontFamily: FontConstant.cairo,
              color: Colors.black87,
              fontSize: FontSize.size16,
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _selectedSpecialization,
            decoration: InputDecoration(
              hintText: 'اختر التخصص',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primary),
              ),
            ),
            items: _specializations.map((specialization) {
              return DropdownMenuItem(
                value: specialization,
                child: Text(
                  specialization,
                  style: getRegularStyle(
                    fontFamily: FontConstant.cairo,
                    color: Colors.black87,
                    fontSize: FontSize.size14,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedSpecialization = value;
              });
            },
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 200.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildHashtagsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'الهاشتاجز',
            style: getSemiBoldStyle(
              fontFamily: FontConstant.cairo,
              color: Colors.black87,
              fontSize: FontSize.size16,
            ),
          ),
          const SizedBox(height: 12),
          
          // Selected hashtags
          if (_selectedHashtags.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _selectedHashtags.map((hashtag) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha:0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha:0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '#$hashtag',
                        style: getRegularStyle(
                          fontFamily: FontConstant.cairo,
                          color: AppColors.primary,
                          fontSize: FontSize.size12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => _removeHashtag(hashtag),
                        child: Icon(
                          Icons.close,
                          size: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
          ],
          
          // Hashtag input
          TextField(
            controller: _hashtagController,
            focusNode: _hashtagFocusNode,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: 'أضف هاشتاج...',
              hintStyle: getRegularStyle(
                fontFamily: FontConstant.cairo,
                color: Colors.grey[500],
                fontSize: FontSize.size14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primary),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  _addHashtag(_hashtagController.text.trim());
                  _hashtagController.clear();
                },
                icon: Icon(Icons.add, color: AppColors.primary),
              ),
            ),
            onSubmitted: (value) {
              _addHashtag(value.trim());
              _hashtagController.clear();
            },
          ),
          
          const SizedBox(height: 12),
          
          // Suggested hashtags
          Text(
            'هاشتاجز مقترحة:',
            style: getRegularStyle(
              fontFamily: FontConstant.cairo,
              color: Colors.grey[600],
              fontSize: FontSize.size12,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _suggestedHashtags.map((hashtag) {
              final isSelected = _selectedHashtags.contains(hashtag);
              return GestureDetector(
                onTap: () => isSelected 
                    ? _removeHashtag(hashtag)
                    : _addHashtag(hashtag),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? AppColors.primary.withValues(alpha:0.1)
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected 
                          ? AppColors.primary.withValues(alpha:0.3)
                          : Colors.grey[300]!,
                    ),
                  ),
                  child: Text(
                    '#$hashtag',
                    style: getRegularStyle(
                      fontFamily: FontConstant.cairo,
                      color: isSelected ? AppColors.primary : Colors.grey[600],
                      fontSize: FontSize.size12,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 900.ms, delay: 300.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildQuickActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'إضافات',
            style: getSemiBoldStyle(
              fontFamily: FontConstant.cairo,
              color: Colors.black87,
              fontSize: FontSize.size16,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  icon: Icons.image,
                  label: 'صور',
                  color: Colors.blue,
                  onTap: _pickImages,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  icon: Icons.videocam,
                  label: 'فيديو',
                  color: Colors.red,
                  onTap: () {
                    // TODO: Implement video picker
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  icon: Icons.poll,
                  label: 'استطلاع',
                  color: Colors.green,
                  onTap: () {
                    // TODO: Implement poll creation
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 1000.ms, delay: 400.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha:0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha:0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                color: color,
                fontSize: FontSize.size12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostSettings() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'إعدادات المنشور',
            style: getSemiBoldStyle(
              fontFamily: FontConstant.cairo,
              color: Colors.black87,
              fontSize: FontSize.size16,
            ),
          ),
          const SizedBox(height: 12),
          
          SwitchListTile(
            title: Text(
              'السماح بالتعليقات',
              style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                color: Colors.black87,
                fontSize: FontSize.size14,
              ),
            ),
            value: _allowComments,
            onChanged: (value) {
              setState(() {
                _allowComments = value;
              });
            },
            activeThumbColor: AppColors.primary,
            contentPadding: EdgeInsets.zero,
          ),
          
          SwitchListTile(
            title: Text(
              'منشور عام',
              style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                color: Colors.black87,
                fontSize: FontSize.size14,
              ),
            ),
            subtitle: Text(
              'يمكن لجميع المستخدمين رؤية هذا المنشور',
              style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                color: Colors.grey[600],
                fontSize: FontSize.size12,
              ),
            ),
            value: _isPublic,
            onChanged: (value) {
              setState(() {
                _isPublic = value;
              });
            },
            activeThumbColor: AppColors.primary,
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 1100.ms, delay: 500.ms).slideY(begin: 0.3, end: 0);
  }
}
