import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/animations/app_animations.dart';

class PatientDemographics extends StatelessWidget {
  final List<Map<String, dynamic>> ageGroups;
  final List<Map<String, dynamic>> genderDistribution;
  final List<Map<String, dynamic>> conditionsDistribution;

  const PatientDemographics({
    super.key,
    required this.ageGroups,
    required this.genderDistribution,
    required this.conditionsDistribution,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Age Distribution Chart
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha:0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'التوزيع العمري للمرضى',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: ageGroups.map((e) => (e['value'] as num).toDouble()).reduce((a, b) => a > b ? a : b) * 1.2,
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            if (value.toInt() >= 0 && value.toInt() < ageGroups.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text(
                                  ageGroups[value.toInt()]['label'],
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 10,
                                  ),
                                ),
                              );
                            }
                            return const Text('');
                          },
                          reservedSize: 38,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return Text(
                              value.toInt().toString(),
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 10,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: ageGroups.asMap().entries.map((entry) {
                      return BarChartGroupData(
                        x: entry.key,
                        barRods: [
                          BarChartRodData(
                            toY: (entry.value['value'] as num).toDouble(),
                            color: Colors.blue.withValues(alpha:0.8),
                            width: 16,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ).animate(effects: fadeInSlide()),
        
        const SizedBox(height: 20),
        
        // Gender Distribution Section
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha:0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'توزيع الجنس',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  // Pie Chart
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 160,
                      child: PieChart(
                        PieChartData(
                          sections: genderDistribution.asMap().entries.map((entry) {
                            final colors = [Colors.pink, Colors.blue];
                            return PieChartSectionData(
                              color: colors[entry.key % colors.length],
                              value: (entry.value['value'] as num).toDouble(),
                              title: '${(entry.value['value'] as num).toInt()}%',
                              radius: 50,
                              titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          }).toList(),
                          centerSpaceRadius: 30,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 20),
                  
                  // Legend
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: genderDistribution.asMap().entries.map((entry) {
                        final colors = [Colors.pink, Colors.blue];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: colors[entry.key % colors.length],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      entry.value['label'],
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    Text(
                                      '${entry.value['value']}%',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ).animate(effects: fadeInSlide(delay: const Duration(milliseconds: 200))),
        
        const SizedBox(height: 20),
        
        // Conditions Distribution Section
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha:0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'توزيع الحالات المرضية',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  // Pie Chart
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 160,
                      child: PieChart(
                        PieChartData(
                          sections: conditionsDistribution.asMap().entries.map((entry) {
                            final colors = [
                              AppColors.primary,
                              Colors.orange,
                              Colors.green,
                              Colors.purple,
                              Colors.red,
                            ];
                            return PieChartSectionData(
                              color: colors[entry.key % colors.length],
                              value: (entry.value['value'] as num).toDouble(),
                              title: '${(entry.value['value'] as num).toInt()}%',
                              radius: 50,
                              titleStyle: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          }).toList(),
                          centerSpaceRadius: 25,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 20),
                  
                  // Legend
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: conditionsDistribution.asMap().entries.map((entry) {
                        final colors = [
                          AppColors.primary,
                          Colors.orange,
                          Colors.green,
                          Colors.purple,
                          Colors.red,
                        ];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: colors[entry.key % colors.length],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      entry.value['label'],
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    Text(
                                      '${entry.value['value']}%',
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ).animate(effects: fadeInSlide(delay: const Duration(milliseconds: 400))),
      ],
    );
  }
}
