import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/animations/app_animations.dart';

class AiAnalysisWidget extends StatefulWidget {
  final bool isAnalyzing;
  final Function(Map<String, dynamic>) onAnalysisComplete;

  const AiAnalysisWidget({
    super.key,
    required this.isAnalyzing,
    required this.onAnalysisComplete,
  });

  @override
  State<AiAnalysisWidget> createState() => _AiAnalysisWidgetState();
}

class _AiAnalysisWidgetState extends State<AiAnalysisWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _progressController;
  
  final List<String> _analysisSteps = [
    'تحليل جودة الصورة...',
    'استخراج الخصائص البصرية...',
    'مقارنة مع قاعدة البيانات...',
    'تطبيق خوارزميات التعلم العميق...',
    'حساب مستوى الثقة...',
    'إنتاج التشخيص النهائي...',
  ];
  
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    
    _progressController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );
    
    if (widget.isAnalyzing) {
      _startAnalysis();
    }
  }

  @override
  void didUpdateWidget(AiAnalysisWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnalyzing && !oldWidget.isAnalyzing) {
      _startAnalysis();
    }
  }

  void _startAnalysis() {
    _progressController.forward();
    
    // Simulate step-by-step analysis
    for (int i = 0; i < _analysisSteps.length; i++) {
      Future.delayed(Duration(milliseconds: 1000 * i), () {
        if (mounted) {
          setState(() {
            _currentStep = i;
          });
        }
      });
    }
    
    // Complete analysis
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        widget.onAnalysisComplete({
          'condition': 'أكزيما تأتبية',
          'confidence': 94.2,
          'severity': 'متوسطة',
        });
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isAnalyzing) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha:0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // AI Brain Animation
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (_pulseController.value * 0.1),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withValues(alpha:0.8),
                        AppColors.primary.withValues(alpha:0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Icon(
                    Icons.psychology,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(height: 20),
          
          const Text(
            'الذكاء الاصطناعي يحلل الصورة',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            'يرجى الانتظار بينما نحلل الصورة باستخدام أحدث تقنيات التعلم العميق',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Progress Bar
          AnimatedBuilder(
            animation: _progressController,
            builder: (context, child) {
              return Column(
                children: [
                  LinearProgressIndicator(
                    value: _progressController.value,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    minHeight: 6,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${(_progressController.value * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              );
            },
          ),
          
          const SizedBox(height: 20),
          
          // Current Step
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha:0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withValues(alpha:0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _currentStep < _analysisSteps.length 
                        ? _analysisSteps[_currentStep]
                        : 'اكتمل التحليل',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Analysis Steps
          Column(
            children: _analysisSteps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              final isCompleted = index < _currentStep;
              final isCurrent = index == _currentStep;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: isCompleted 
                            ? Colors.green 
                            : isCurrent 
                                ? AppColors.primary 
                                : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        isCompleted ? Icons.check : Icons.circle,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        step,
                        style: TextStyle(
                          fontSize: 12,
                          color: isCompleted || isCurrent 
                              ? AppColors.textPrimary 
                              : AppColors.textSecondary,
                          fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ).animate(effects: fadeInScaleUp());
  }
}
