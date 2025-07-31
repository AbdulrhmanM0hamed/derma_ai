import 'package:derma_ai/core/utils/animations/app_animations.dart';
import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:derma_ai/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/utils/app_utils.dart';

class DiagnosisModel {
  final String id;
  final String diseaseName;
  final String description;
  final String imageUrl;
  final double confidence;
  final DateTime diagnosisDate;
  final List<String>? symptoms;
  final List<String>? treatments;
  final String? severity;
  final List<DiagnosisModel>? similarCases;

  DiagnosisModel({
    required this.id,
    required this.diseaseName,
    required this.description,
    required this.imageUrl,
    required this.confidence,
    required this.diagnosisDate,
    this.symptoms,
    this.treatments,
    this.severity,
    this.similarCases,
  });

  String get severityLevel {
    if (severity == null) return 'Unknown';
    switch (severity!.toLowerCase()) {
      case 'high':
        return 'High';
      case 'medium':
        return 'Medium';
      case 'low':
        return 'Low';
      default:
        return 'Unknown';
    }
    // Note: These strings are not translated here because they are used for internal logic.
    // The displayed text will be translated when shown in the UI.
  }

  Color get severityColor {
    if (severity == null) return AppColors.textSecondary;
    
    switch (severity!.toLowerCase()) {
      case 'high':
        return AppColors.error;
      case 'medium':
        return AppColors.warning;
      case 'low':
        return AppColors.success;
      default:
        return AppColors.textSecondary;
    }
  }
}

class DiagnosisCard extends StatelessWidget {
  final DiagnosisModel diagnosis;
  final VoidCallback onTap;
  final bool isDetailed;

  const DiagnosisCard({
    super.key,
    required this.diagnosis,
    required this.onTap,
    this.isDetailed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha:0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(context),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          diagnosis.diseaseName,
                          style: getBoldStyle(
                            fontSize: 16,
                            fontFamily: FontConstant.cairo,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _buildSeverityBadge(context),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppUtils.formatDate(diagnosis.diagnosisDate),
                    style: getRegularStyle(
                      fontFamily: FontConstant.cairo,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildConfidenceIndicator(context),
                  if (isDetailed) ...[
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.description,
                      style: getSemiBoldStyle(
                        fontSize: 14,
                        fontFamily: FontConstant.cairo,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      diagnosis.description,
                      style: getMediumStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontFamily: FontConstant.cairo,
                      ),
                      overflow: isDetailed ? null : TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.symptoms,
                      style: getSemiBoldStyle(
                        fontSize: 14,
                        fontFamily: FontConstant.cairo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildSymptomsList(context),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.treatments,
                      style: getSemiBoldStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontFamily: FontConstant.cairo,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildTreatmentsList(context),
                  ] else ...[  
                    const SizedBox(height: 8),
                    Text(
                      diagnosis.description,
                      style: getRegularStyle(
                        color: AppColors.textSecondary,
                        fontFamily: FontConstant.cairo,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate(effects: fadeInSlide(
      duration: 300.ms,
    ));
  }

  Widget _buildImageSection(BuildContext context) {
    return Hero(
      tag: 'diagnosis_${diagnosis.id}',
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: CachedNetworkImage(
            imageUrl: diagnosis.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: AppColors.border.withValues(alpha:0.2),
              child: const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: AppColors.border.withValues(alpha:0.2),
              child: const Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: AppColors.textSecondary,
                  size: 48,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeverityBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: diagnosis.severityColor.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: diagnosis.severityColor,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            diagnosis.severityLevel,
            style: getMediumStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontFamily: FontConstant.cairo,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfidenceIndicator(BuildContext context) {
    final confidence = diagnosis.confidence * 100;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'AI Confidence',
              style: getRegularStyle(
                color: AppColors.textSecondary,
                fontFamily: FontConstant.cairo,
              ),
            ),
            Text(
              '${confidence.toStringAsFixed(1)}%',
              style: getSemiBoldStyle(
                color: _getConfidenceColor(confidence),
                fontSize: 12,
                fontFamily: FontConstant.cairo,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: diagnosis.confidence,
          backgroundColor: AppColors.border,
          valueColor: AlwaysStoppedAnimation<Color>(_getConfidenceColor(confidence)),
          borderRadius: BorderRadius.circular(4),
          minHeight: 6,
        ),
      ],
    );
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 80) {
      return AppColors.success;
    } else if (confidence >= 60) {
      return AppColors.primary;
    } else if (confidence >= 40) {
      return AppColors.warning;
    } else {
      return AppColors.error;
    }
  }

  Widget _buildSymptomsList(BuildContext context) {
    if (diagnosis.symptoms == null || diagnosis.symptoms!.isEmpty) {
      return Text(
        'No symptoms information available',
        style: getRegularStyle(
          color: AppColors.textSecondary,
          fontFamily: FontConstant.cairo,
          fontStyle: FontStyle.italic,
        ),
      );
    }
    
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: diagnosis.symptoms!.map((symptom) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha:0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            symptom,
            style: getMediumStyle(
              fontSize: 12,
              color: AppColors.primary,
              fontFamily: FontConstant.cairo,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTreatmentsList(BuildContext context) {
    if (diagnosis.treatments == null || diagnosis.treatments!.isEmpty) {
      return Text(
        'No treatment information available',
        style: getRegularStyle(
          color: AppColors.textSecondary,
          fontFamily: FontConstant.cairo,
          fontStyle: FontStyle.italic,
        ),
      );
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: diagnosis.treatments!.map((treatment) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  treatment,
                  style: getRegularStyle(
                        color: AppColors.textSecondary,
                        fontFamily: FontConstant.cairo,
                      ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}