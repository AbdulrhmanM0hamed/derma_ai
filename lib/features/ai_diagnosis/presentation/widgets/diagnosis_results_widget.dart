import 'package:derma_ai/features/ai_diagnosis/presentation/widgets/results/suggeted_doctores_section.dart';
import 'package:flutter/material.dart';

import 'package:derma_ai/features/ai_diagnosis/presentation/widgets/results/disclaimer_widget.dart';
import 'package:derma_ai/features/ai_diagnosis/presentation/widgets/results/prediction_card.dart';
import 'package:derma_ai/features/ai_diagnosis/presentation/widgets/results/recommendations_section.dart';
import 'package:derma_ai/features/ai_diagnosis/presentation/widgets/results/result_actions.dart';
import 'package:derma_ai/features/ai_diagnosis/presentation/widgets/results/results_header.dart';

class DiagnosisResultsWidget extends StatelessWidget {
  final Map<String, dynamic> analysisResult;
  final VoidCallback onShareResult;
  final VoidCallback onSaveToHistory;

  const DiagnosisResultsWidget({
    super.key,
    required this.analysisResult,
    required this.onShareResult,
    required this.onSaveToHistory,
  });

  @override
  Widget build(BuildContext context) {
    final confidence = (analysisResult['confidence'] as double) * 100;
    final condition = analysisResult['condition'] as String;
    final conditionArabic = analysisResult['conditionArabic'] as String;
    final severity = analysisResult['severity'] as String;
    final recommendations = analysisResult['recommendations'] as List<String>;
    // final otherPredictions = analysisResult['other_predictions'] as List<dynamic>;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ResultsHeader(),
              const SizedBox(height: 24),
              PredictionCard(
                confidence: confidence,
                condition: condition,
                conditionArabic: conditionArabic,
                severity: severity,
              ),
              const SizedBox(height: 24),
              const DisclaimerWidget(),
              const SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                ),
                child: RecommendationsSection(recommendations: recommendations),
              ),
              const SizedBox(height: 24),
              SuggestedDoctorsSection(
                suggestedDoctors: [
                  {
                    "id": 'doc1',
                    "name": "د. سارة إبراهيم",
                    "specialty": "أخصائية جلدية",
                    "rating": 4.9,
                    "profileImage":
                        "https://randomuser.me/api/portraits/women/44.jpg",
                  },
                  {
                    "id": 'doc2',
                    "name": "د. محمد عبدالله",
                    "specialty": "استشاري تجميل",
                    "rating": 4.8,
                    "profileImage":
                        "https://randomuser.me/api/portraits/men/46.jpg",
                  },
                  {
                    "id": 'doc3',
                    "name": "د. فاطمة الزهراء",
                    "specialty": "علاج بالليزر",
                    "rating": 4.7,
                    "profileImage":
                        "https://randomuser.me/api/portraits/women/65.jpg",
                  },
                ],
              ),
              const SizedBox(height: 32),
              ResultActions(
                onShareResult: onShareResult,
                onSaveToHistory: onSaveToHistory,
                onFindDoctor: () {
                  Navigator.pushNamed(context, '/doctor-search-and-browse');
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
