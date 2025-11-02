import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/animations/app_animations.dart';
import '../widgets/report_card.dart';
import '../widgets/advanced_chart_widget.dart';
import '../widgets/performance_metrics_widget.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage>
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
          'التقارير والتحليلات',
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
            onPressed: () => _exportReport(),
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
            Tab(text: 'المرضى'),
            Tab(text: 'الإيرادات'),
            Tab(text: 'الأداء'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildPatientsTab(),
          _buildRevenueTab(),
          _buildPerformanceTab(),
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
                const Text(
                  'الفترة الزمنية:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
          
          // Key Metrics
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
            children: [
              ReportCard(
                title: 'إجمالي المرضى',
                value: '1,247',
                change: '+12.5%',
                isPositive: true,
                icon: Icons.people,
                color: Colors.blue,
              ),
              ReportCard(
                title: 'الإيرادات',
                value: '45,230 ج.م',
                change: '+8.2%',
                isPositive: true,
                icon: Icons.attach_money,
                color: Colors.green,
              ),
              ReportCard(
                title: 'معدل الشفاء',
                value: '94.2%',
                change: '+2.1%',
                isPositive: true,
                icon: Icons.healing,
                color: Colors.purple,
              ),
              ReportCard(
                title: 'التقييم',
                value: '4.9/5',
                change: '+0.3',
                isPositive: true,
                icon: Icons.star,
                color: Colors.amber,
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Monthly Trends Chart
          AdvancedChartWidget(
            title: 'اتجاهات المرضى الشهرية',
            chartType: ChartType.line,
            data: [
              ChartData('يناير', 85),
              ChartData('فبراير', 92),
              ChartData('مارس', 78),
              ChartData('أبريل', 105),
              ChartData('مايو', 98),
              ChartData('يونيو', 112),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Conditions Distribution
          AdvancedChartWidget(
            title: 'توزيع الحالات المرضية',
            chartType: ChartType.pie,
            data: [
              ChartData('أكزيما', 35),
              ChartData('حب الشباب', 28),
              ChartData('صدفية', 18),
              ChartData('التهاب جلدي', 12),
              ChartData('أخرى', 7),
            ],
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
          // Patient Demographics
          AdvancedChartWidget(
            title: 'التوزيع العمري للمرضى',
            chartType: ChartType.bar,
            data: [
              ChartData('18-25', 45),
              ChartData('26-35', 78),
              ChartData('36-45', 65),
              ChartData('46-55', 42),
              ChartData('56+', 28),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Gender Distribution
          AdvancedChartWidget(
            title: 'توزيع المرضى حسب الجنس',
            chartType: ChartType.pie,
            data: [
              ChartData('إناث', 58),
              ChartData('ذكور', 42),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // New vs Returning Patients
          AdvancedChartWidget(
            title: 'المرضى الجدد مقابل العائدين',
            chartType: ChartType.line,
            data: [
              ChartData('يناير', 25, secondaryValue: 60),
              ChartData('فبراير', 32, secondaryValue: 60),
              ChartData('مارس', 28, secondaryValue: 50),
              ChartData('أبريل', 35, secondaryValue: 70),
              ChartData('مايو', 30, secondaryValue: 68),
              ChartData('يونيو', 38, secondaryValue: 74),
            ],
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
          // Revenue Overview
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.0,
            children: [
              ReportCard(
                title: 'الإيرادات الشهرية',
                value: '45,230 ج.م',
                change: '+15.2%',
                isPositive: true,
                icon: Icons.trending_up,
                color: Colors.green,
              ),
              ReportCard(
                title: 'متوسط الجلسة',
                value: '350 ج.م',
                change: '+5.8%',
                isPositive: true,
                icon: Icons.attach_money,
                color: Colors.blue,
              ),
              ReportCard(
                title: 'إجمالي الجلسات',
                value: '129',
                change: '+8.7%',
                isPositive: true,
                icon: Icons.calendar_today,
                color: Colors.purple,
              ),
              ReportCard(
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
          AdvancedChartWidget(
            title: 'الإيرادات الشهرية',
            chartType: ChartType.bar,
            data: [
              ChartData('يناير', 25000),
              ChartData('فبراير', 28000),
              ChartData('مارس', 32000),
              ChartData('أبريل', 35000),
              ChartData('مايو', 38000),
              ChartData('يونيو', 45230),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Revenue by Service Type
          AdvancedChartWidget(
            title: 'الإيرادات حسب نوع الخدمة',
            chartType: ChartType.pie,
            data: [
              ChartData('استشارة عادية', 45),
              ChartData('استشارة متخصصة', 30),
              ChartData('متابعة', 15),
              ChartData('تشخيص ذكي', 10),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          PerformanceMetricsWidget(),
          
          const SizedBox(height: 20),
          
          // Patient Satisfaction
          AdvancedChartWidget(
            title: 'تقييم رضا المرضى',
            chartType: ChartType.line,
            data: [
              ChartData('يناير', 4.5),
              ChartData('فبراير', 4.6),
              ChartData('مارس', 4.7),
              ChartData('أبريل', 4.8),
              ChartData('مايو', 4.8),
              ChartData('يونيو', 4.9),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Treatment Success Rate
          AdvancedChartWidget(
            title: 'معدل نجاح العلاج',
            chartType: ChartType.bar,
            data: [
              ChartData('أكزيما', 94),
              ChartData('حب الشباب', 89),
              ChartData('صدفية', 87),
              ChartData('التهاب جلدي', 92),
              ChartData('حساسية', 96),
            ],
          ),
        ],
      ),
    );
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

  void _exportReport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تصدير التقرير'),
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

class ChartData {
  final String label;
  final double value;
  final double? secondaryValue;

  ChartData(this.label, this.value, {this.secondaryValue});
}

enum ChartType { line, bar, pie }
