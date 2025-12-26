import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/animations/app_animations.dart';

class RevenueAnalytics extends StatelessWidget {
  final List<double> monthlyRevenue;
  final List<String> months;

  const RevenueAnalytics({
    super.key,
    required this.monthlyRevenue,
    required this.months,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Revenue Overview Cards
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.0,
          children: [
            _buildRevenueCard(
              title: 'الإيرادات الشهرية',
              value: '${monthlyRevenue.last.toInt()} ج.م',
              change: '+15.2%',
              isPositive: true,
              icon: Icons.trending_up,
              color: Colors.green,
            ),
            _buildRevenueCard(
              title: 'متوسط الجلسة',
              value: '350 ج.م',
              change: '+5.8%',
              isPositive: true,
              icon: Icons.attach_money,
              color: Colors.blue,
            ),
            _buildRevenueCard(
              title: 'إجمالي الجلسات',
              value: '129',
              change: '+8.7%',
              isPositive: true,
              icon: Icons.calendar_today,
              color: Colors.purple,
            ),
            _buildRevenueCard(
              title: 'معدل الإلغاء',
              value: '5.2%',
              change: '-2.1%',
              isPositive: true,
              icon: Icons.cancel,
              color: Colors.orange,
            ),
          ],
        ),
        
        const SizedBox(height: 20),
        
        // Monthly Revenue Chart
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
                'الإيرادات الشهرية',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 250,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: monthlyRevenue.reduce((a, b) => a > b ? a : b) * 1.2,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (_) => Colors.blueGrey,
                        tooltipHorizontalAlignment: FLHorizontalAlignment.right,
                        tooltipMargin: -10,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            '${months[group.x.toInt()]}\n',
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${rod.toY.round()} ج.م',
                                style: const TextStyle(
                                  color: Colors.yellow,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            if (value.toInt() >= 0 && value.toInt() < months.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text(
                                  months[value.toInt()],
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.bold,
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
                          reservedSize: 40,
                          interval: monthlyRevenue.reduce((a, b) => a > b ? a : b) / 5,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return Text(
                              '${(value / 1000).toInt()}K',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: monthlyRevenue.asMap().entries.map((entry) {
                      return BarChartGroupData(
                        x: entry.key,
                        barRods: [
                          BarChartRodData(
                            toY: entry.value,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary,
                                AppColors.primary.withValues(alpha:0.7),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                            width: 16,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                          ),
                        ],
                      );
                    }).toList(),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: monthlyRevenue.reduce((a, b) => a > b ? a : b) / 5,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey.shade200,
                          strokeWidth: 1,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ).animate(effects: fadeInScaleUp()),
      ],
    );
  }

  Widget _buildRevenueCard({
    required String title,
    required String value,
    required String change,
    required bool isPositive,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isPositive ? Colors.green.withValues(alpha:0.1) : Colors.red.withValues(alpha:0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isPositive ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    ).animate(effects: fadeInSlide());
  }
}
