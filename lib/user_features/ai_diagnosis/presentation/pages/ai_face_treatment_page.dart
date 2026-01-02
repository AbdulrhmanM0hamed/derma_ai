import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';

enum TreatmentState { input, processing, results }

class AiFaceTreatmentPage extends StatefulWidget {
  const AiFaceTreatmentPage({super.key});

  @override
  State<AiFaceTreatmentPage> createState() => _AiFaceTreatmentPageState();
}

class _AiFaceTreatmentPageState extends State<AiFaceTreatmentPage>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _treatmentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  
  String? _faceImagePath;
  String? _treatmentImagePath;
  String? _resultImageUrl;
  TreatmentState _currentState = TreatmentState.input;
  String _processingMessage = '';
  double _processingProgress = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _treatmentController.dispose();
    super.dispose();
  }

  Future<void> _pickFaceImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 90,
      );
      if (image != null) {
        setState(() => _faceImagePath = image.path);
        HapticFeedback.selectionClick();
      }
    } catch (e) {
      _showErrorSnackBar('فشل في اختيار الصورة');
    }
  }

  Future<void> _takeFacePhoto() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 90,
        preferredCameraDevice: CameraDevice.front,
      );
      if (image != null) {
        setState(() => _faceImagePath = image.path);
        HapticFeedback.selectionClick();
      }
    } catch (e) {
      _showErrorSnackBar('فشل في التقاط الصورة');
    }
  }

  Future<void> _pickTreatmentImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() => _treatmentImagePath = image.path);
        HapticFeedback.selectionClick();
      }
    } catch (e) {
      _showErrorSnackBar('فشل في اختيار صورة العلاج');
    }
  }

  Future<void> _processImages() async {
    if (_faceImagePath == null) {
      _showErrorSnackBar('يرجى إضافة صورة وجهك أولاً');
      return;
    }

    if (_treatmentController.text.isEmpty && _treatmentImagePath == null) {
      _showErrorSnackBar('يرجى إدخال اسم العلاج أو صورته');
      return;
    }

    setState(() {
      _currentState = TreatmentState.processing;
      _processingProgress = 0;
    });

    // Simulate AI processing
    final steps = [
      'جاري تحليل صورة وجهك...',
      'جاري التعرف على ملامح البشرة...',
      'جاري تحليل تأثير العلاج...',
      'جاري إنشاء الصورة المحسنة...',
      'جاري إضافة اللمسات النهائية...',
    ];

    for (int i = 0; i < steps.length; i++) {
      await Future.delayed(const Duration(milliseconds: 1200));
      if (mounted) {
        setState(() {
          _processingMessage = steps[i];
          _processingProgress = (i + 1) / steps.length;
        });
      }
    }

    // Mock result - in real app, this would be the AI-generated image
    setState(() {
      _resultImageUrl = _faceImagePath; // Placeholder
      _currentState = TreatmentState.results;
    });
  }

  void _resetAll() {
    setState(() {
      _faceImagePath = null;
      _treatmentImagePath = null;
      _resultImageUrl = null;
      _treatmentController.clear();
      _currentState = TreatmentState.input;
    });
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textDirection: TextDirection.rtl),
        backgroundColor: AppColors.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    switch (_currentState) {
      case TreatmentState.input:
        return _buildInputScreen();
      case TreatmentState.processing:
        return _buildProcessingScreen();
      case TreatmentState.results:
        return _buildResultsScreen();
    }
  }

  Widget _buildInputScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Face Image Section
          _buildSectionCard(
            title: 'صورة وجهك',
            subtitle: 'التقط صورة واضحة لوجهك',
            icon: Icons.face,
            child: _buildFaceImagePicker(),
          ),
          
          const SizedBox(height: 20),
          
          // Treatment Section
          _buildSectionCard(
            title: 'العلاج المراد تجربته',
            subtitle: 'أدخل اسم العلاج أو صورته',
            icon: Icons.medical_services,
            child: _buildTreatmentInput(),
          ),
          
          const SizedBox(height: 30),
          
          // Process Button
          _buildProcessButton(),
          
          const SizedBox(height: 20),
          
          // Info Card
          _buildInfoCard(),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }

  Widget _buildFaceImagePicker() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: _faceImagePath != null
          ? _buildSelectedImage(_faceImagePath!, onRemove: () {
              setState(() => _faceImagePath = null);
            })
          : _buildImagePickerButtons(),
    );
  }

  Widget _buildImagePickerButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildPickerButton(
            icon: Icons.camera_alt,
            label: 'التقاط صورة',
            onTap: _takeFacePhoto,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildPickerButton(
            icon: Icons.photo_library,
            label: 'من المعرض',
            onTap: _pickFaceImage,
          ),
        ),
      ],
    );
  }

  Widget _buildPickerButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.3),
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedImage(String path, {required VoidCallback onRemove}) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: kIsWeb
              ? Image.network(path, height: 200, width: double.infinity, fit: BoxFit.cover)
              : Image.file(File(path), height: 200, width: double.infinity, fit: BoxFit.cover),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTreatmentInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          // Text Input
          TextField(
            controller: _treatmentController,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintText: 'مثال: كريم فيتامين سي، ريتينول...',
              hintTextDirection: TextDirection.rtl,
              prefixIcon: const Icon(Icons.edit),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Or Divider
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey.shade300)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'أو',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
              Expanded(child: Divider(color: Colors.grey.shade300)),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Treatment Image Picker
          _treatmentImagePath != null
              ? _buildSelectedImage(_treatmentImagePath!, onRemove: () {
                  setState(() => _treatmentImagePath = null);
                })
              : _buildPickerButton(
                  icon: Icons.add_photo_alternate,
                  label: 'إضافة صورة العلاج',
                  onTap: _pickTreatmentImage,
                ),
        ],
      ),
    );
  }

  Widget _buildProcessButton() {
    final isEnabled = _faceImagePath != null &&
        (_treatmentController.text.isNotEmpty || _treatmentImagePath != null);
    
    return ElevatedButton(
      onPressed: isEnabled ? _processImages : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        disabledBackgroundColor: Colors.grey.shade300,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.auto_awesome,
            color: isEnabled ? Colors.white : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            'عرض النتيجة المتوقعة',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isEnabled ? Colors.white : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'هذه الميزة تستخدم الذكاء الاصطناعي لتوقع تأثير العلاج على بشرتك. النتائج تقريبية وليست بديلاً عن استشارة الطبيب.',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated AI Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withValues(alpha: 0.6),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 50,
              ),
            ),
            
            const SizedBox(height: 40),
            
            Text(
              _processingMessage,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 24),
            
            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: _processingProgress,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 8,
              ),
            ),
            
            const SizedBox(height: 12),
            
            Text(
              '${(_processingProgress * 100).toInt()}%',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Before/After Comparison
          _buildComparisonCard(),
          
          const SizedBox(height: 20),
          
          // Treatment Info
          _buildTreatmentInfoCard(),
          
          const SizedBox(height: 20),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _resetAll,
                  icon: const Icon(Icons.refresh),
                  label: const Text('تجربة جديدة'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Share functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم حفظ النتيجة')),
                    );
                  },
                  icon: const Icon(Icons.save_alt, color: Colors.white),
                  label: const Text('حفظ النتيجة', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonCard() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.compare, color: AppColors.primary),
                const SizedBox(width: 8),
                const Text(
                  'المقارنة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildComparisonImage(
                  _faceImagePath!,
                  'قبل',
                  Colors.grey,
                ),
              ),
              Container(
                width: 2,
                height: 200,
                color: Colors.grey.shade200,
              ),
              Expanded(
                child: _buildComparisonImage(
                  _resultImageUrl!,
                  'بعد (متوقع)',
                  AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildComparisonImage(String path, String label, Color labelColor) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: kIsWeb
              ? Image.network(path, height: 180, width: double.infinity, fit: BoxFit.cover)
              : Image.file(File(path), height: 180, width: double.infinity, fit: BoxFit.cover),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: labelColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: labelColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTreatmentInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.medical_services, color: AppColors.primary),
              const SizedBox(width: 8),
              const Text(
                'معلومات العلاج',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_treatmentController.text.isNotEmpty)
            _buildInfoRow('اسم العلاج', _treatmentController.text),
          _buildInfoRow('نوع التحليل', 'تحسين البشرة'),
          _buildInfoRow('الدقة المتوقعة', '85%'),
          const Divider(height: 24),
          Text(
            'ملاحظة: هذه النتيجة تقريبية وتعتمد على عوامل متعددة. ننصح باستشارة طبيب مختص قبل استخدام أي علاج.',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: AppColors.textSecondary),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
