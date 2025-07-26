import 'dart:io';

import 'package:derma_ai/core/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:derma_ai/core/utils/constant/font_manger.dart';
import 'package:derma_ai/core/utils/constant/styles_manger.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/widgets/custom_button.dart';
import 'diagnosis_card.dart';

class DiagnosisResultCard extends StatelessWidget {
  final DiagnosisModel diagnosis;
  final VoidCallback onBookDoctor;

  const DiagnosisResultCard({
    super.key,
    required this.diagnosis,
    required this.onBookDoctor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          _buildDiagnosisDetails(context),
          _buildSymptoms(context),
          _buildTreatments(context),
          _buildActions(context),
        ],
      ),
    ).animate(effects: fadeInScaleUp(
      duration: 400.ms,
      begin: 0.95,
    ));
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _getSeverityGradient(),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.science_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      AppLocalizations.of(context)!.aiDiagnosis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.verified_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${(diagnosis.confidence * 100).toStringAsFixed(1)}% ${AppLocalizations.of(context)!.confidence}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            diagnosis.diseaseName,
            style: getBoldStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: FontConstant.cairo,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '${AppLocalizations.of(context)!.diagnosedOn} ${DateFormat('MMM d, yyyy').format(diagnosis.diagnosisDate)}',
            style: getRegularStyle(
              color: Colors.white.withOpacity(0.9),
              fontFamily: FontConstant.cairo,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              _getSeverityText(context),
              style: getBoldStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: FontConstant.cairo,
                ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiagnosisDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.description,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            diagnosis.description,
            style: getRegularStyle(
                  color: AppColors.textSecondary,
                  fontFamily: FontConstant.cairo,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.imageAnalysis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: diagnosis.imageUrl.startsWith('http')
                ? CachedNetworkImage(
                    imageUrl: diagnosis.imageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.error),
                    ),
                  )
                : Image.file(
                    File(diagnosis.imageUrl),
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptoms(BuildContext context) {
    if (diagnosis.symptoms == null || diagnosis.symptoms!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.commonSymptoms,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: diagnosis.symptoms!.map((symptom) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: AppColors.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      symptom,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTreatments(BuildContext context) {
    if (diagnosis.treatments == null || diagnosis.treatments!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.recommendedTreatments,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: diagnosis.treatments!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.medical_services_outlined,
                          color: AppColors.secondary,
                          size: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        diagnosis.treatments![index],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: Colors.amber,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.aiDisclaimerMessage,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.amber[800],
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: CustomButton(
        text: AppLocalizations.of(context)!.bookAppointmentWithDermatologist,
        onPressed: onBookDoctor,
        icon: Icons.calendar_today_outlined,
        type: ButtonType.primary,
        width: double.infinity,
      ),
    );
  }

  List<Color> _getSeverityGradient() {
    switch (diagnosis.severity?.toLowerCase()) {
      case 'low':
        return [Colors.green.shade600, Colors.green.shade400];
      case 'medium':
        return [Colors.orange.shade600, Colors.orange.shade400];
      case 'high':
        return [Colors.red.shade600, Colors.red.shade400];
      default:
        return AppColors.primaryGradient;
    }
  }

  String _getSeverityText(BuildContext context) {
    switch (diagnosis.severity?.toLowerCase()) {
      case 'low':
        return AppLocalizations.of(context)!.lowSeverity;
      case 'medium':
        return AppLocalizations.of(context)!.mediumSeverity;
      case 'high':
        return AppLocalizations.of(context)!.highSeverity;
      default:
        return AppLocalizations.of(context)!.unknownSeverity;
    }
  }
}