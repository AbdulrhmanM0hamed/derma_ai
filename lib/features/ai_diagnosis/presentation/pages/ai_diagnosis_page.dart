import 'dart:io';

import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/diagnosis_card.dart';
import '../widgets/diagnosis_result_card.dart';

class AiDiagnosisPage extends StatefulWidget {
  const AiDiagnosisPage({super.key});

  @override
  State<AiDiagnosisPage> createState() => _AiDiagnosisPageState();
}

class _AiDiagnosisPageState extends State<AiDiagnosisPage>
    with SingleTickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  bool _isAnalyzing = false;
  bool _showResult = false;
  late AnimationController _animationController;

  // Dummy diagnosis result for demonstration
  DiagnosisModel? _diagnosisResult;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _getImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
          _showResult = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _analyzeImage() async {
    if (_imageFile == null) return;

    setState(() {
      _isAnalyzing = true;
    });

    // Simulate API call to AI model
    await Future.delayed(const Duration(seconds: 3));

    // Dummy result for demonstration
    final result = DiagnosisModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      diseaseName: 'Atopic Dermatitis',
      description:
          'Atopic dermatitis is a chronic inflammatory skin condition characterized by dry, itchy skin and rashes. It is commonly associated with allergies and asthma.',
      imageUrl: _imageFile!.path,
      confidence: 0.92,
      diagnosisDate: DateTime.now(),
      symptoms: ['Dry skin', 'Itching', 'Redness', 'Rash', 'Scaly patches'],
      treatments: [
        'Moisturizers',
        'Topical corticosteroids',
        'Antihistamines',
        'Avoid triggers',
        'Keep skin hydrated',
      ],
      severity: 'medium',
      similarCases: [
        DiagnosisModel(
          id: '1',
          diseaseName: 'Atopic Dermatitis',
          description: 'Similar case with different presentation',
          imageUrl:
              'https://www.mayoclinic.org/-/media/kcms/gbs/patient-consumer/images/2013/11/15/17/35/ds00986_-ds00987_-ds00674_-ds00821_-ds00842_-ds00843_-ds00844_-ds01047_-ds01060_-ds01122_-ds01145_-my01331_im03450_r7_skinirritthu_jpg.jpg',
          confidence: 0.88,
          diagnosisDate: DateTime.now().subtract(const Duration(days: 30)),
          severity: 'medium',
        ),
        DiagnosisModel(
          id: '2',
          diseaseName: 'Eczema',
          description: 'Similar condition with different classification',
          imageUrl:
              'https://www.mayoclinic.org/-/media/kcms/gbs/patient-consumer/images/2013/11/15/17/39/ds00853_-ds00856_im03442_r7_handeczemathu_jpg.jpg',
          confidence: 0.75,
          diagnosisDate: DateTime.now().subtract(const Duration(days: 60)),
          severity: 'low',
        ),
      ],
    );

    setState(() {
      _diagnosisResult = result;
      _isAnalyzing = false;
      _showResult = true;
    });
  }

  void _resetDiagnosis() {
    setState(() {
      _imageFile = null;
      _showResult = false;
      _diagnosisResult = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Skin Diagnosis'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Navigate to diagnosis history
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              if (_imageFile == null)
                _buildImageSelectionArea()
              else
                _buildImagePreviewArea(),
              const SizedBox(height: 24),
              if (_showResult && _diagnosisResult != null)
                _buildDiagnosisResult(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
              AppLocalizations.of(context)!.aiPoweredSkinDiagnosis,
              style: getSemiBoldStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontFamily: FontConstant.cairo,
              ),
            )
            .animate(effects: fadeInSlide(
              duration: 300.ms,
              beginX: -0.1,
            )),
        const SizedBox(height: 8),
        Text(
              AppLocalizations.of(context)!.diagnosisDescription,
              style: getRegularStyle(
                color: AppColors.textSecondary,
                fontFamily: FontConstant.cairo
              ),
            )
            .animate(effects: fadeInSlide(
              duration: 300.ms,
              delay: 100.ms,
              beginX: -0.1,
            )),
      ],
    );
  }

  Widget _buildImageSelectionArea() {
    return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add_a_photo,
                      color: AppColors.primary,
                      size: 40,
                    ),
                  )
                  .animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .scaleXY(
                    begin: 1,
                    end: 1.05,
                    duration: 2000.ms,
                    curve: Curves.easeInOut,
                  ),
              const SizedBox(height: 24),
              Text(
                AppLocalizations.of(context)!.uploadOrTakePhoto,
                style: getSemiBoldStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontFamily: FontConstant.cairo
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.photoGuidelines,
                style: getRegularStyle(
                  color: AppColors.textSecondary,
                  fontFamily: FontConstant.cairo
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomButton(
                      text: AppLocalizations.of(context)!.takePhoto,
                      onPressed: () => _getImage(ImageSource.camera),
                      icon: Icons.camera_alt,
                      type: ButtonType.outline,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      text: AppLocalizations.of(context)!.uploadPhoto,
                      onPressed: () => _getImage(ImageSource.gallery),
                      icon: Icons.photo_library,
                      type: ButtonType.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        .animate(effects: fadeInScaleUp(
          duration: 400.ms,
          delay: 200.ms,
          begin: 0.95,
        ));
  }

  Widget _buildImagePreviewArea() {
    return Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      _imageFile!,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_isAnalyzing)
                    Column(
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(
                          AppLocalizations.of(context)!.analyzingSkinCondition,
                          style: getRegularStyle(
                            color: AppColors.textSecondary,
                            fontFamily: FontConstant.cairo
                          ),
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: _animationController.value,
                          backgroundColor: AppColors.border,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: AppLocalizations.of(context)!.changePhoto,
                            onPressed: _resetDiagnosis,
                            icon: Icons.refresh,
                            type: ButtonType.outline,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomButton(
                            text: AppLocalizations.of(context)!.analyze,
                            onPressed: _analyzeImage,
                            icon: Icons.search,
                            type: ButtonType.primary,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        )
        .animate(effects: fadeInScaleUp(
          duration: 400.ms,
          begin: 0.95,
        ));
  }

  Widget _buildDiagnosisResult() {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.diagnosisResult,
              style: getSemiBoldStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontFamily: FontConstant.cairo,
              ),
            ),
            const SizedBox(height: 16),
            DiagnosisResultCard(
              diagnosis: _diagnosisResult!,
              onBookDoctor: () {
                // Navigate to doctor booking
              },
            ),
            const SizedBox(height: 24),
            if (_diagnosisResult!.similarCases != null &&
                _diagnosisResult!.similarCases!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.similarCases,
                    style: getSemiBoldStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontFamily: FontConstant.cairo,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _diagnosisResult!.similarCases!.length,
                    separatorBuilder:
                        (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final similarCase =
                          _diagnosisResult!.similarCases![index];
                      return DiagnosisCard(
                            diagnosis: similarCase,
                            onTap: () {
                              // View similar case details
                            },
                          )
                          .animate(effects: fadeInSlide(
                            duration: 300.ms,
                            delay: Duration(milliseconds: 100 * index),
                            beginY: 0.1,
                          ));
                    },
                  ),
                ],
              ),
            const SizedBox(height: 24),
            CustomButton(
              text: AppLocalizations.of(context)!.saveToMyRecords,
              onPressed: () {
                // Save diagnosis to user records
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.diagnosisSaved),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: Icons.save,
              type: ButtonType.primary,
              width: double.infinity,
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: AppLocalizations.of(context)!.shareWithDoctor,
              onPressed: () {
                // Share diagnosis with doctor
              },
              icon: Icons.share,
              type: ButtonType.outline,
              width: double.infinity,
            ),
          ],
        )
        .animate(effects: fadeInSlide(
          duration: 500.ms,
          beginY: 0.1,
        ));
  }
}
