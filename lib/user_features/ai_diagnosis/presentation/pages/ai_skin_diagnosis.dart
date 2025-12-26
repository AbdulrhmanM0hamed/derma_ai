import 'package:camera/camera.dart';
import 'package:derma_ai/core/utils/common/custom_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/core/widgets/custom_icon_widget.dart';
import 'package:derma_ai/user_features/ai_diagnosis/presentation/widgets/camera_viewfinder_widget.dart';
import 'package:derma_ai/user_features/ai_diagnosis/presentation/widgets/capture_controls_widget.dart';
import 'package:derma_ai/user_features/ai_diagnosis/presentation/widgets/coaching_text_widget.dart';
import 'package:derma_ai/user_features/ai_diagnosis/presentation/widgets/diagnosis_history_widget.dart';
import 'package:derma_ai/user_features/ai_diagnosis/presentation/widgets/diagnosis_results_widget.dart';
import 'package:derma_ai/user_features/ai_diagnosis/presentation/widgets/image_preview_widget.dart';
import 'package:derma_ai/user_features/ai_diagnosis/presentation/widgets/processing_screen_widget.dart';

enum DiagnosisState { camera, preview, processing, results, history }

class AiSkinDiagnosis extends StatefulWidget {
  const AiSkinDiagnosis({super.key});

  @override
  State<AiSkinDiagnosis> createState() => _AiSkinDiagnosisState();
}

class _AiSkinDiagnosisState extends State<AiSkinDiagnosis>
    with TickerProviderStateMixin {
  // Camera related
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isCameraInitialized = false;
  bool _isFlashOn = false;

  // State management
  DiagnosisState _currentState = DiagnosisState.camera;
  String? _capturedImagePath;
  String _processingStatus = 'جاري التحليل...';
  Map<String, dynamic>? _analysisResult;

  // Tab controller for history
  late TabController _tabController;

  // Mock data
  final List<Map<String, dynamic>> _mockHistoryData = [
    {
      "id": 1,
      "date": DateTime.now().subtract(Duration(days: 7)),
      "condition": "Acne Vulgaris",
      "conditionArabic": "حب الشباب الشائع",
      "confidence": 0.87,
      "severity": "mild",
      "imagePath":
          "https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=400&h=400&fit=crop",
      "recommendations": [
        "استخدام منظف لطيف للوجه مرتين يومياً",
        "تجنب لمس الوجه بالأيدي غير النظيفة",
        "استشارة طبيب الجلدية للعلاج المناسب",
      ],
    },
    {
      "id": 2,
      "date": DateTime.now().subtract(Duration(days: 14)),
      "condition": "Seborrheic Dermatitis",
      "conditionArabic": "التهاب الجلد الدهني",
      "confidence": 0.92,
      "severity": "moderate",
      "imagePath":
          "https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?w=400&h=400&fit=crop",
      "recommendations": [
        "استخدام شامبو طبي مضاد للفطريات",
        "تجنب المنتجات الدهنية على فروة الرأس",
        "مراجعة طبيب الجلدية لوصف العلاج المناسب",
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    try {
      // Request camera permission
      if (!kIsWeb) {
        final status = await Permission.camera.request();
        if (!status.isGranted) {
          _showPermissionDialog();
          return;
        }
      }

      // Get available cameras
      _cameras = await availableCameras();
      if (_cameras.isEmpty) return;

      // Select appropriate camera
      final camera =
          kIsWeb
              ? _cameras.firstWhere(
                (c) => c.lensDirection == CameraLensDirection.front,
                orElse: () => _cameras.first,
              )
              : _cameras.firstWhere(
                (c) => c.lensDirection == CameraLensDirection.back,
                orElse: () => _cameras.first,
              );

      // Initialize camera controller
      _cameraController = CameraController(
        camera,
        kIsWeb ? ResolutionPreset.medium : ResolutionPreset.high,
      );

      await _cameraController!.initialize();

      // Apply camera settings
      await _applyCameraSettings();

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      // print('Camera initialization error: $e');
      if (mounted) {
        _showCameraErrorDialog();
      }
    }
  }

  Future<void> _applyCameraSettings() async {
    if (_cameraController == null) return;

    try {
      await _cameraController!.setFocusMode(FocusMode.auto);
      if (!kIsWeb) {
        await _cameraController!.setFlashMode(FlashMode.auto);
      }
    } catch (e) {
      // Silently handle unsupported features
    }
  }

  Future<void> _capturePhoto() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      HapticFeedback.mediumImpact();
      final XFile photo = await _cameraController!.takePicture();

      setState(() {
        _capturedImagePath = photo.path;
        _currentState = DiagnosisState.preview;
      });
    } catch (e) {
      _showErrorSnackBar('فشل في التقاط الصورة. يرجى المحاولة مرة أخرى.');
    }
  }

  Future<void> _selectFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _capturedImagePath = image.path;
          _currentState = DiagnosisState.preview;
        });
      }
    } catch (e) {
      _showErrorSnackBar('فشل في اختيار الصورة من المعرض.');
    }
  }

  Future<void> _toggleFlash() async {
    if (_cameraController == null || kIsWeb) return;

    try {
      final newFlashMode = _isFlashOn ? FlashMode.off : FlashMode.torch;
      await _cameraController!.setFlashMode(newFlashMode);

      setState(() {
        _isFlashOn = !_isFlashOn;
      });
    } catch (e) {
      // Flash not supported on this device
    }
  }

  Future<void> _processImage() async {
    setState(() {
      _currentState = DiagnosisState.processing;
      _processingStatus = 'جاري التحليل...';
    });

    // Simulate AI processing with realistic steps
    final processingSteps = [
      'جاري التحليل...',
      'فحص الصورة...',
      'تحليل الأنماط...',
      'مقارنة البيانات...',
      'إنتاج النتائج...',
    ];

    for (int i = 0; i < processingSteps.length; i++) {
      await Future.delayed(Duration(milliseconds: 1500));
      if (mounted) {
        setState(() {
          _processingStatus = processingSteps[i];
        });
      }
    }

    // Generate mock analysis result
    final mockResult = {
      'condition': 'Acne Vulgaris',
      'conditionArabic': 'حب الشباب الشائع',
      'confidence': 0.89,
      'severity': 'mild',
      'recommendations': [
        'استخدام منظف لطيف للوجه مرتين يومياً',
        'تجنب لمس الوجه بالأيدي غير النظيفة',
        'استخدام مرطب خالي من الزيوت',
        'تجنب التعرض المفرط لأشعة الشمس',
        'استشارة طبيب الجلدية للعلاج المناسب',
      ],
    };

    setState(() {
      _analysisResult = mockResult;
      _currentState = DiagnosisState.results;
    });
  }

  void _shareResults() {
    // Implement sharing functionality
    _showSuccessSnackBar('تم مشاركة النتائج بنجاح');
  }

  void _saveToHistory() {
    if (_analysisResult != null) {
      final newDiagnosis = {
        ..._analysisResult!,
        'id': _mockHistoryData.length + 1,
        'date': DateTime.now(),
        'imagePath': _capturedImagePath,
      };

      _mockHistoryData.insert(0, newDiagnosis);
      _showSuccessSnackBar('تم حفظ النتائج في السجل');
    }
  }

  void _compareResults(Map<String, dynamic> diagnosis) {
    // Implement comparison functionality
    _showInfoSnackBar('ميزة المقارنة ستكون متاحة قريباً');
  }

  void _retakePhoto() {
    setState(() {
      _capturedImagePath = null;
      _currentState = DiagnosisState.camera;
    });
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('إرشادات التصوير', textDirection: TextDirection.rtl),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• تأكد من وجود إضاءة جيدة',
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  '• ضع المنطقة المصابة في المربع المحدد',
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  '• احتفظ بمسافة مناسبة من الكاميرا',
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  '• تجنب الحركة أثناء التصوير',
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('فهمت', textDirection: TextDirection.rtl),
              ),
            ],
          ),
    );
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('إذن الكاميرا مطلوب', textDirection: TextDirection.rtl),
            content: Text(
              'يحتاج التطبيق إلى إذن الوصول للكاميرا لتتمكن من تصوير المنطقة المصابة وتحليلها.',
              textDirection: TextDirection.rtl,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('إلغاء', textDirection: TextDirection.rtl),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
                child: Text('الإعدادات', textDirection: TextDirection.rtl),
              ),
            ],
          ),
    );
  }

  void _showCameraErrorDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('خطأ في الكاميرا', textDirection: TextDirection.rtl),
            content: Text(
              'حدث خطأ في تشغيل الكاميرا. يمكنك اختيار صورة من المعرض بدلاً من ذلك.',
              textDirection: TextDirection.rtl,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('موافق', textDirection: TextDirection.rtl),
              ),
            ],
          ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textDirection: TextDirection.rtl),
        backgroundColor: AppColors.error,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textDirection: TextDirection.rtl),
        backgroundColor: AppColors.third,
      ),
    );
  }

  void _showInfoSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textDirection: TextDirection.rtl),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'تشخيص الجلد بالذكاء الاصطناعي',
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _showHelpDialog,
            icon: CustomIconWidget(iconName: 'help_outline', size: 24),
          ),
        ],
        bottom:
            _currentState == DiagnosisState.camera ||
                    _currentState == DiagnosisState.history
                ? TabBar(
                  controller: _tabController,
                  onTap: (index) {
                    setState(() {
                      _currentState =
                          index == 0
                              ? DiagnosisState.camera
                              : DiagnosisState.history;
                    });
                  },
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomIconWidget(
                            iconName: 'camera_alt',
                            color:
                                _currentState == DiagnosisState.camera
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                            size: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          Text('تشخيص جديد', textDirection: TextDirection.rtl),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomIconWidget(
                            iconName: 'history',
                            color:
                                _currentState == DiagnosisState.history
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                            size: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          Text('السجل', textDirection: TextDirection.rtl),
                        ],
                      ),
                    ),
                  ],
                )
                : null,
      ),
      body: SafeArea(child: _buildCurrentScreen()),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentState) {
      case DiagnosisState.camera:
        return _buildCameraScreen();
      case DiagnosisState.preview:
        return _buildPreviewScreen();
      case DiagnosisState.processing:
        return _buildProcessingScreen();
      case DiagnosisState.results:
        return _buildResultsScreen();
      case DiagnosisState.history:
        return _buildHistoryScreen();
    }
  }

  Widget _buildCameraScreen() {
    return Column(
      children: [
        // Camera Viewfinder
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            child: CameraViewfinderWidget(
              cameraController: _cameraController,
              isFlashOn: _isFlashOn,
              onFlashToggle: _toggleFlash,
              isInitialized: _isCameraInitialized,
            ),
          ),
        ),

        // Coaching Text
        CoachingTextWidget(
          mainText: 'ضع المنطقة المصابة في المربع',
          subText: 'تأكد من وجود إضاءة جيدة وثبات الكاميرا',
        ),

        // Capture Controls
        CaptureControlsWidget(
          onCapture: _capturePhoto,
          onGallery: _selectFromGallery,
          onFlashToggle: _toggleFlash,
          isFlashOn: _isFlashOn,
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
      ],
    );
  }

  Widget _buildPreviewScreen() {
    if (_capturedImagePath == null) {
      return Center(child: Text('لا توجد صورة للمعاينة'));
    }

    return ImagePreviewWidget(
      imagePath: _capturedImagePath!,
      onConfirm: _processImage,
      onRetake: _retakePhoto,
    );
  }

  Widget _buildProcessingScreen() {
    return ProcessingScreenWidget(currentStatus: _processingStatus);
  }

  Widget _buildResultsScreen() {
    if (_analysisResult == null) {
      return Center(child: Text('لا توجد نتائج للعرض'));
    }

    return DiagnosisResultsWidget(
      analysisResult: _analysisResult!,
      onShareResult: _shareResults,
      onSaveToHistory: _saveToHistory,
    );
  }

  Widget _buildHistoryScreen() {
    return DiagnosisHistoryWidget(
      historyData: _mockHistoryData,
      onCompareResults: _compareResults,
    );
  }
}
