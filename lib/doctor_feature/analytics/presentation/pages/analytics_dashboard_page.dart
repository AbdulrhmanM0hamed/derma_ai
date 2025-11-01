import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/animations/app_animations.dart';
import '../widgets/analytics_card.dart';
import '../widgets/performance_chart.dart';
import '../widgets/revenue_analytics.dart';
import '../widgets/patient_demographics.dart';


class AnalyticsDashboardPage extends StatefulWidget {
  const AnalyticsDashboardPage({super.key});

  @override
  State<AnalyticsDashboardPage> createState() => _AnalyticsDashboardPageState();
}

class _AnalyticsDashboardPageState extends State<AnalyticsDashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPeriod = 'شهري';
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'لوحة التحليلات المتقدمة',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showPeriodSelector(),
            icon: const Icon(Icons.date_range, color: Colors.white),
          ),
          IconButton(
            onPressed: () => _exportAnalytics(),
            icon: const Icon(Icons.download, color: Colors.white),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          isScrollable: true,
          tabs: const [
            Tab(text: 'نظرة عامة'),
            Tab(text: 'الأداء'),
            Tab(text: 'الإيرادات'),
            Tab(text: 'المرضى'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildPerformanceTab(),
          _buildRevenueTab(),
          _buildPatientsTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Period Selector
          Container(
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
            child: Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  'تحليلات الأداء',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha:0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _selectedPeriod,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ).animate(effects: fadeInSlide()),
          
          const SizedBox(height: 20),
          
          // Key Metrics Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.0,
            children: [
              AnalyticsCard(
                title: 'إجمالي المرضى',
                value: '1,247',
                change: '+12.5%',
                isPositive: true,
                icon: Icons.people,
                color: Colors.blue,
                chartData: [20, 35, 25, 40, 30, 45, 35],
              ),
              AnalyticsCard(
                title: 'الإيرادات الشهرية',
                value: '45,230 ج.م',
                change: '+8.2%',
                isPositive: true,
                icon: Icons.attach_money,
                color: Colors.green,
                chartData: [30, 25, 35, 40, 32, 38, 42],
              ),
              AnalyticsCard(
                title: 'معدل الشفاء',
                value: '94.2%',
                change: '+2.1%',
                isPositive: true,
                icon: Icons.healing,
                color: Colors.purple,
                chartData: [85, 88, 90, 92, 91, 93, 94],
              ),
              AnalyticsCard(
                title: 'تقييم المرضى',
                value: '4.9/5',
                change: '+0.3',
                isPositive: true,
                icon: Icons.star,
                color: Colors.amber,
                chartData: [4.5, 4.6, 4.7, 4.8, 4.8, 4.9, 4.9],
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Performance Overview Chart
          PerformanceChart(
            title: 'نظرة عامة على الأداء',
            data: _getPerformanceData(),
          ),
          
          const SizedBox(height: 20),
          
          // Quick Insights
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.05),
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
                    Icon(
                      Icons.lightbulb_outline,
                      color: Colors.orange,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'رؤى سريعة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildInsightItem(
                  icon: Icons.trending_up,
                  title: 'نمو المرضى',
                  description: 'زيادة 12.5% في عدد المرضى الجدد هذا الشهر',
                  color: Colors.green,
                ),
                _buildInsightItem(
                  icon: Icons.schedule,
                  title: 'وقت الانتظار',
                  description: 'انخفض متوسط وقت الانتظار إلى 5 دقائق',
                  color: Colors.blue,
                ),
                _buildInsightItem(
                  icon: Icons.star,
                  title: 'رضا المرضى',
                  description: 'تحسن التقييم بنسبة 6% عن الشهر الماضي',
                  color: Colors.amber,
                ),
              ],
            ),
          ).animate(effects: fadeInSlide(delay: const Duration(milliseconds: 400))),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Performance Metrics
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.0,
            children: [
              AnalyticsCard(
                title: 'وقت الاستجابة',
                value: '2.3 دقيقة',
                change: '+5%',
                isPositive: true,
                icon: Icons.timer,
                color: Colors.blue,
                chartData: [2.5, 2.4, 2.3, 2.2, 2.3, 2.1, 2.3],
              ),
              AnalyticsCard(
                title: 'دقة التشخيص',
                value: '94.2%',
                change: '+2.1%',
                isPositive: true,
                icon: Icons.check_circle,
                color: Colors.green,
                chartData: [92, 93, 94, 93, 94, 95, 94],
              ),
              AnalyticsCard(
                title: 'معدل المتابعة',
                value: '87%',
                change: '+12%',
                isPositive: true,
                icon: Icons.follow_the_signs,
                color: Colors.purple,
                chartData: [75, 78, 82, 85, 86, 87, 87],
              ),
              AnalyticsCard(
                title: 'كفاءة الوقت',
                value: '92%',
                change: '+3%',
                isPositive: true,
                icon: Icons.schedule,
                color: Colors.orange,
                chartData: [89, 90, 91, 92, 91, 92, 92],
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Detailed Performance Chart
          PerformanceChart(
            title: 'تحليل الأداء التفصيلي',
            data: _getDetailedPerformanceData(),
            showComparison: true,
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          RevenueAnalytics(
            monthlyRevenue: [25000, 28000, 32000, 35000, 38000, 42000, 45230],
            months: ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو'],
          ),
        ],
      ),
    );
  }

  Widget _buildPatientsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          PatientDemographics(
            ageGroups: [
              {'label': '18-25', 'value': 45},
              {'label': '26-35', 'value': 78},
              {'label': '36-45', 'value': 65},
              {'label': '46-55', 'value': 42},
              {'label': '56+', 'value': 28},
            ],
            genderDistribution: [
              {'label': 'إناث', 'value': 58},
              {'label': 'ذكور', 'value': 42},
            ],
            conditionsDistribution: [
              {'label': 'أكزيما', 'value': 35},
              {'label': 'حب الشباب', 'value': 28},
              {'label': 'صدفية', 'value': 18},
              {'label': 'التهاب جلدي', 'value': 12},
              {'label': 'أخرى', 'value': 7},
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha:0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha:0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
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
    );
  }

  List<Map<String, dynamic>> _getPerformanceData() {
    return [
      {'month': 'يناير', 'patients': 85, 'revenue': 25000, 'satisfaction': 4.5},
      {'month': 'فبراير', 'patients': 92, 'revenue': 28000, 'satisfaction': 4.6},
      {'month': 'مارس', 'patients': 78, 'revenue': 32000, 'satisfaction': 4.7},
      {'month': 'أبريل', 'patients': 105, 'revenue': 35000, 'satisfaction': 4.8},
      {'month': 'مايو', 'patients': 98, 'revenue': 38000, 'satisfaction': 4.8},
      {'month': 'يونيو', 'patients': 112, 'revenue': 42000, 'satisfaction': 4.9},
      {'month': 'يوليو', 'patients': 125, 'revenue': 45230, 'satisfaction': 4.9},
    ];
  }

  List<Map<String, dynamic>> _getDetailedPerformanceData() {
    return [
      {'metric': 'دقة التشخيص', 'current': 94.2, 'previous': 92.1, 'target': 95.0},
      {'metric': 'وقت الاستجابة', 'current': 2.3, 'previous': 2.8, 'target': 2.0},
      {'metric': 'رضا المرضى', 'current': 4.9, 'previous': 4.6, 'target': 5.0},
      {'metric': 'معدل المتابعة', 'current': 87, 'previous': 75, 'target': 90},
    ];
  }

  void _showPeriodSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'اختر الفترة الزمنية',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...['أسبوعي', 'شهري', 'ربع سنوي', 'سنوي'].map((period) =>
              ListTile(
                title: Text(period),
                trailing: _selectedPeriod == period 
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() {
                    _selectedPeriod = period;
                  });
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _exportAnalytics() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تصدير التحليلات'),
        content: const Text('اختر تنسيق التصدير'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Export as PDF
            },
            child: const Text('PDF'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Export as Excel
            },
            child: const Text('Excel'),
          ),
        ],
      ),
    );
  }
}
