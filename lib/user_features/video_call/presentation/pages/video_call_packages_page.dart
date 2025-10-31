import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../data/models/video_call_package_model.dart';
import '../widgets/video_call_package_card.dart';
import 'book_video_call_page.dart';

class VideoCallPackagesPage extends StatefulWidget {
  final Map<String, dynamic> doctorData;

  const VideoCallPackagesPage({
    super.key,
    required this.doctorData,
  });

  @override
  State<VideoCallPackagesPage> createState() => _VideoCallPackagesPageState();
}

class _VideoCallPackagesPageState extends State<VideoCallPackagesPage> {
  VideoCallPackageModel? selectedPackage;
  bool isLoading = true;
  List<VideoCallPackageModel> packages = [];

  @override
  void initState() {
    super.initState();
    _loadPackages();
  }

  Future<void> _loadPackages() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      packages = [
        VideoCallPackageModel(
          id: 'basic',
          name: 'الباقة الأساسية',
          description: 'استشارة سريعة للحالات البسيطة',
          durationMinutes: 15,
          price: 150.0,
          features: [
            'مكالمة فيديو لمدة 15 دقيقة',
            'تشخيص أولي للحالة',
            'نصائح طبية عامة',
            'إمكانية طرح الأسئلة',
          ],
        ),
        VideoCallPackageModel(
          id: 'standard',
          name: 'الباقة المتوسطة',
          description: 'استشارة شاملة مع متابعة',
          durationMinutes: 30,
          price: 250.0,
          originalPrice: 300.0,
          discountPercentage: '17%',
          isPopular: true,
          features: [
            'مكالمة فيديو لمدة 30 دقيقة',
            'فحص شامل للحالة',
            'خطة علاجية مفصلة',
            'وصفة طبية إلكترونية',
            'متابعة لمدة أسبوع',
            'إمكانية إرسال الصور',
          ],
        ),
        VideoCallPackageModel(
          id: 'premium',
          name: 'الباقة المتميزة',
          description: 'استشارة متقدمة مع متابعة شاملة',
          durationMinutes: 60,
          price: 400.0,
          originalPrice: 500.0,
          discountPercentage: '20%',
          features: [
            'مكالمة فيديو لمدة ساعة كاملة',
            'فحص تفصيلي شامل',
            'خطة علاجية متقدمة',
            'وصفة طبية مفصلة',
            'متابعة لمدة شهر كامل',
            'استشارات إضافية مجانية',
            'تقرير طبي مفصل',
            'أولوية في المواعيد',
          ],
        ),
      ];
      isLoading = false;
    });
  }

  void _selectPackage(VideoCallPackageModel package) {
    setState(() {
      selectedPackage = package;
    });
  }

  void _proceedToBooking() {
    if (selectedPackage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookVideoCallPage(
            doctorData: widget.doctorData,
            selectedPackage: selectedPackage!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: isLoading ? _buildLoadingState() : _buildContent(),
      bottomNavigationBar: selectedPackage != null ? _buildBottomBar() : null,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.grey[700]),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'باقات المكالمات الفيديو',
        style: getBoldStyle(
          fontFamily: FontConstant.cairo,
          fontSize: 18,
          color: Colors.black87,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDoctorHeader(),
          const SizedBox(height: 24),
          _buildSectionTitle(),
          const SizedBox(height: 16),
          _buildPackagesList(),
          const SizedBox(height: 100), // Space for bottom bar
        ],
      ),
    );
  }

  Widget _buildDoctorHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.doctorData['photo'] ?? '',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.person,
                    color: AppColors.primary,
                    size: 30,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.doctorData['arabicName'] ?? '',
                  style: getBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.doctorData['specialty'] ?? '',
                  style: getRegularStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.doctorData['rating'] ?? 0.0}',
                      style: getSemiBoldStyle(
                        fontFamily: FontConstant.cairo,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(${widget.doctorData['reviewCount'] ?? 0} تقييم)',
                      style: getRegularStyle(
                        fontFamily: FontConstant.cairo,
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.3);
  }

  Widget _buildSectionTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اختر الباقة المناسبة لك',
          style: getBoldStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'جميع الباقات تشمل مكالمة فيديو عالية الجودة مع الطبيب',
          style: getRegularStyle(
            fontFamily: FontConstant.cairo,
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms, delay: 200.ms);
  }

  Widget _buildPackagesList() {
    return Column(
      children: packages.asMap().entries.map((entry) {
        final index = entry.key;
        final package = entry.value;
        
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: VideoCallPackageCard(
            package: package,
            isSelected: selectedPackage?.id == package.id,
            onTap: () => _selectPackage(package),
          ),
        ).animate().fadeIn(
          duration: 600.ms,
          delay: Duration(milliseconds: 300 + (index * 100)),
        ).slideX(begin: 0.3);
      }).toList(),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(20),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selectedPackage != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الباقة المختارة:',
                    style: getRegularStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    selectedPackage!.name,
                    style: getSemiBoldStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'المدة:',
                    style: getRegularStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    selectedPackage!.formattedDuration,
                    style: getSemiBoldStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'السعر:',
                    style: getRegularStyle(
                      fontFamily: FontConstant.cairo,
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Row(
                    children: [
                      if (selectedPackage!.originalPrice != null) ...[
                        Text(
                          selectedPackage!.formattedOriginalPrice!,
                          style: getRegularStyle(
                            fontFamily: FontConstant.cairo,
                            fontSize: 12,
                            color: Colors.grey[500],
                          ).copyWith(
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        selectedPackage!.formattedPrice,
                        style: getBoldStyle(
                          fontFamily: FontConstant.cairo,
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _proceedToBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'متابعة الحجز',
                  style: getBoldStyle(
                    fontFamily: FontConstant.cairo,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().slideY(begin: 1, duration: 600.ms);
  }
}
