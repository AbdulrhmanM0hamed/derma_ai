import 'package:derma_ai/doctor_feature/home/presentation/widgets/stat_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../core/utils/animations/app_animations.dart';
import '../../../../core/utils/helper/on_genrated_routes.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/advanced_stat_card.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/patient_summary_card.dart';
import '../widgets/notification_card.dart';
import '../widgets/revenue_chart.dart';
import '../widgets/appointment_timeline.dart';
import '../widgets/chart_container.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  final List<String> periods = ['Daily', 'Weekly', 'Monthly'];
  int selectedPeriodIndex = 1; // Default to Weekly

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      drawer: _buildDrawer(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildAppBar(),
          _buildQuickActionsSection(),
          _buildAdvancedStatsGrid(),
          _buildRevenueSection(),
          _buildPatientSummarySection(),
          _buildTimelineSection(),
          _buildChartsSection(),
          _buildNotificationsSection(),
          _buildUpcomingAppointmentsSection(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "doctor_home_fab",
        onPressed: () => _showQuickActionsMenu(),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'إجراء سريع',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 150,
      floating: true,
      pinned: true,
      backgroundColor: AppColors.primary,
      stretch: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          AppLocalizations.of(context)?.dashboard ?? "Dashboard",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  // الصف الأول: الصورة الشخصية، الاسم، وزر الإشعارات
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 30, color: AppColors.primary),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          "دكتور محمد أحمد",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "3",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // الصف الثاني: التخصص والتقييم
                  Row(
                    children: [
                      const SizedBox(width: 66), // مساحة مماثلة للصورة الشخصية + المسافة
                      Expanded(
                        child: Text(
                          "دكتور أمراض جلدية • 4.9 ⭐",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical:8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)?.statistics ?? "Statistics",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[100],
                ),
                child: Row(
                  children:
                      periods.asMap().entries.map((entry) {
                        final index = entry.key;
                        final period = entry.value;
                        return GestureDetector(
                          onTap:
                              () => setState(() => selectedPeriodIndex = index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:
                                  selectedPeriodIndex == index
                                      ? AppColors.primary
                                      : Colors.transparent,
                            ),
                            child: Text(
                              period,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color:
                                    selectedPeriodIndex == index
                                        ? Colors.white
                                        : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverPadding _buildStatsGrid() {
    return SliverPadding(
      padding: const EdgeInsets.all(2),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.3,
        ),
        delegate: SliverChildListDelegate([
          StatCard(
            title:
                AppLocalizations.of(context)?.totalAppointments ??
                "Total Appointments",
            value: "36",
            icon: Icons.calendar_month_rounded,
            iconColor: Colors.blue,
            trend: "+12%",
            isPositiveTrend: true,
          ),
          StatCard(
            title: AppLocalizations.of(context)?.newPatients ?? "New Patients",
            value: "18",
            icon: Icons.person_add_rounded,
            iconColor: Colors.green,
            trend: "+5%",
            isPositiveTrend: true,
          ),
          StatCard(
            title:
                AppLocalizations.of(context)?.returnPatients ??
                "Return Patients",
            value: "24",
            icon: Icons.repeat_rounded,
            iconColor: Colors.orange,
            trend: "+8%",
            isPositiveTrend: true,
          ),
          StatCard(
            title:
                AppLocalizations.of(context)?.averageRating ?? "Average Rating",
            value: "4.9",
            icon: Icons.star_rounded,
            iconColor: Colors.amber,
            trend: "+0.2",
            isPositiveTrend: true,
          ),
        ]),
      ),
    );
  }

  SliverList _buildChartsSection() {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Text(
            AppLocalizations.of(context)?.analytics ?? "Analytics",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        ChartContainer(
          title:
              AppLocalizations.of(context)?.appointmentsStatus ??
              "Appointments Status",
          height: 220,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 40,
                    sections: [
                      PieChartSectionData(
                        value: 75,
                        title: '75%',
                        color: AppColors.primary,
                        radius: 50,
                        titleStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      PieChartSectionData(
                        value: 15,
                        title: '15%',
                        color: Colors.redAccent,
                        radius: 45,
                        titleStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      PieChartSectionData(
                        value: 10,
                        title: '10%',
                        color: Colors.grey[400]!,
                        radius: 45,
                        titleStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem("Completed", "75%", AppColors.primary),
                    const SizedBox(height: 12),
                    _buildLegendItem("Canceled", "15%", Colors.redAccent),
                    const SizedBox(height: 12),
                    _buildLegendItem("Rescheduled", "10%", Colors.grey[400]!),
                  ],
                ),
              ),
            ],
          ),
        ),
        ChartContainer(
          title:
              AppLocalizations.of(context)?.consultationsGrowth ??
              "Consultations Growth",
          height: 250,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 10,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      getTitlesWidget: (value, meta) {
                        const labels = [
                          'Jan',
                          'Feb',
                          'Mar',
                          'Apr',
                          'May',
                          'Jun',
                        ];
                        if (value.toInt() >= 0 &&
                            value.toInt() < labels.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              labels[value.toInt()],
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 10,
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300]!, width: 1),
                    left: BorderSide(color: Colors.grey[300]!, width: 1),
                  ),
                ),
                minX: 0,
                maxX: 5,
                minY: 0,
                maxY: 40,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 12),
                      FlSpot(1, 18),
                      FlSpot(2, 15),
                      FlSpot(3, 22),
                      FlSpot(4, 28),
                      FlSpot(5, 35),
                    ],
                    isCurved: true,
                    color: AppColors.primary,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.primary.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ChartContainer(
          title:
              AppLocalizations.of(context)?.skinConditionsDistribution ??
              "Skin Conditions Distribution",
          height: 300,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceEvenly,
                maxY: 60,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 10,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        const labels = [
                          'Acne',
                          'Eczema',
                          'Psoriasis',
                          'Rosacea',
                          'Melanoma',
                        ];
                        if (value.toInt() >= 0 &&
                            value.toInt() < labels.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              labels[value.toInt()],
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  horizontalInterval: 20,
                  getDrawingHorizontalLine:
                      (value) => FlLine(
                        color: Colors.grey[300]!,
                        strokeWidth: 1,
                        dashArray: [5, 5],
                      ),
                  drawVerticalLine: false,
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300]!, width: 1),
                    left: BorderSide(color: Colors.grey[300]!, width: 1),
                  ),
                ),
                barGroups: [
                  _buildBarGroup(0, 55, AppColors.primary),
                  _buildBarGroup(1, 35, AppColors.primary),
                  _buildBarGroup(2, 25, AppColors.primary),
                  _buildBarGroup(3, 15, AppColors.primary),
                  _buildBarGroup(4, 10, AppColors.primary),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 20,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, String value, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  SliverPadding _buildUpcomingAppointmentsSection() {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)?.upcomingAppointments ??
                      "Upcoming Appointments",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/advanced-appointments'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  child: Text(
                    AppLocalizations.of(context)?.viewAll ?? "View all",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            PatientSummaryCard(
              patientName: "أحمد حسن",
              patientAge: "28",
              condition: "أكزيما",
              appointmentTime: "10:30 ص",
              severity: "متوسطة",
              onTap: () => Navigator.pushNamed(context, '/advanced-appointments'),
            ),
            PatientSummaryCard(
              patientName: "سارة محمد",
              patientAge: "35",
              condition: "صدفية",
              appointmentTime: "11:30 ص",
              severity: "عالية",
              onTap: () => Navigator.pushNamed(context, '/advanced-appointments'),
            ),
            PatientSummaryCard(
              patientName: "عمر علي",
              patientAge: "42",
              condition: "حب الشباب",
              appointmentTime: "2:00 م",
              severity: "منخفضة",
              onTap: () => Navigator.pushNamed(context, '/advanced-appointments'),
            ),
          ],
        ),
      ),
    );
  }

  // Quick Actions Section
  SliverPadding _buildQuickActionsSection() {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'الإجراءات السريعة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: [
                QuickActionCard(
                  title: 'مرضى جدد',
                  subtitle: 'إضافة مريض جديد',
                  icon: Icons.person_add,
                  color: Colors.blue,
                  badge: '5',
                  onTap: () => Navigator.pushNamed(context, AppRoutes.advancedPatients),
                ),
                QuickActionCard(
                  title: 'تشخيص ذكي',
                  subtitle: 'تحليل الصور بالذكاء الاصطناعي',
                  icon: Icons.psychology,
                  color: Colors.purple,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.doctorAiDiagnosis),
                ),
                QuickActionCard(
                  title: 'وصفات طبية',
                  subtitle: 'إنشاء وصفة جديدة',
                  icon: Icons.receipt_long,
                  color: Colors.green,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.prescriptions),
                ),
                QuickActionCard(
                  title: 'التقارير',
                  subtitle: 'عرض التقارير الطبية',
                  icon: Icons.analytics,
                  color: Colors.orange,
                  badge: '12',
                  onTap: () => Navigator.pushNamed(context, AppRoutes.reports),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Advanced Stats Grid
  SliverPadding _buildAdvancedStatsGrid() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.74,
        ),
        delegate: SliverChildListDelegate([
          AdvancedStatCard(
            title: 'إجمالي المرضى',
            value: '1,247',
            subtitle: 'مريض نشط',
            icon: Icons.people,
            iconColor: Colors.blue,
            trend: '+12.5%',
            isPositiveTrend: true,
            chartData: [20, 35, 25, 40, 30, 45, 35],
            onTap: () => Navigator.pushNamed(context, '/advanced-patients'),
          ),
          AdvancedStatCard(
            title: 'الإيرادات الشهرية',
            value: '45,230',
            subtitle: 'جنيه مصري',
            icon: Icons.attach_money,
            iconColor: Colors.green,
            trend: '+8.2%',
            isPositiveTrend: true,
            chartData: [30, 25, 35, 40, 32, 38, 42],
            onTap: () => Navigator.pushNamed(context, '/analytics-dashboard'),
          ),
          AdvancedStatCard(
            title: 'معدل الشفاء',
            value: '94.2%',
            subtitle: 'نسبة نجاح العلاج',
            icon: Icons.healing,
            iconColor: Colors.purple,
            trend: '+2.1%',
            isPositiveTrend: true,
            chartData: [85, 88, 90, 92, 91, 93, 94],
            onTap: () => Navigator.pushNamed(context, '/reports'),
          ),
          AdvancedStatCard(
            title: 'تقييم المرضى',
            value: '4.9',
            subtitle: 'من 5 نجوم',
            icon: Icons.star,
            iconColor: Colors.amber,
            trend: '+0.3',
            isPositiveTrend: true,
            chartData: [4.5, 4.6, 4.7, 4.8, 4.8, 4.9, 4.9],
            onTap: () => Navigator.pushNamed(context, '/analytics-dashboard'),
          ),
        ]),
      ),
    );
  }

  // Revenue Section
  SliverPadding _buildRevenueSection() {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverToBoxAdapter(
        child: RevenueChart(
          monthlyRevenue: [25000, 28000, 32000, 35000, 38000, 42000, 45000],
          months: ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو'],
        ),
      ),
    );
  }

  // Patient Summary Section
  SliverPadding _buildPatientSummarySection() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'المرضى اليوم',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            PatientSummaryCard(
              patientName: "فاطمة أحمد",
              patientAge: "32",
              condition: "التهاب جلدي",
              appointmentTime: "9:00 ص",
              severity: "عالية",
              onTap: () => Navigator.pushNamed(context, '/advanced-patients'),
            ),
            PatientSummaryCard(
              patientName: "محمد علي",
              patientAge: "45",
              condition: "حساسية جلدية",
              appointmentTime: "10:30 ص",
              severity: "متوسطة",
              onTap: () => Navigator.pushNamed(context, '/advanced-patients'),
            ),
          ],
        ),
      ),
    );
  }

  // Timeline Section
  SliverPadding _buildTimelineSection() {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverToBoxAdapter(
        child: AppointmentTimeline(
          appointments: [
            TimelineAppointment(
              time: '9:00 ص',
              patientName: 'فاطمة أحمد',
              condition: 'التهاب جلدي حاد',
              status: AppointmentStatus.completed,
              notes: 'تم وصف العلاج المناسب',
            ),
            TimelineAppointment(
              time: '10:30 ص',
              patientName: 'محمد علي',
              condition: 'حساسية جلدية',
              status: AppointmentStatus.current,
            ),
            TimelineAppointment(
              time: '12:00 م',
              patientName: 'سارة محمود',
              condition: 'فحص دوري',
              status: AppointmentStatus.upcoming,
            ),
            TimelineAppointment(
              time: '2:30 م',
              patientName: 'أحمد حسن',
              condition: 'متابعة علاج الأكزيما',
              status: AppointmentStatus.upcoming,
            ),
          ],
        ),
      ),
    );
  }

  // Notifications Section
  SliverPadding _buildNotificationsSection() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'الإشعارات الحديثة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.analyticsDashboard),
                  child: const Text('عرض الكل'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            NotificationCard(
              title: 'موعد جديد',
              message: 'لديك موعد مع المريض أحمد محمد في الساعة 3:00 م',
              time: 'منذ 5 دقائق',
              icon: Icons.calendar_today,
              iconColor: Colors.blue,
              isRead: false,
              onTap: () {},
            ),
            NotificationCard(
              title: 'نتائج التحاليل',
              message: 'وصلت نتائج تحاليل المريضة فاطمة أحمد',
              time: 'منذ 15 دقيقة',
              icon: Icons.science,
              iconColor: Colors.green,
              isRead: false,
              onTap: () {},
            ),
            NotificationCard(
              title: 'تقييم جديد',
              message: 'قام المريض محمد علي بتقييم الخدمة بـ 5 نجوم',
              time: 'منذ ساعة',
              icon: Icons.star,
              iconColor: Colors.amber,
              isRead: true,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  // Professional Drawer
  Widget _buildDrawer() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.primary.withOpacity(0.8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Drawer Header
            Container(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'دكتور محمد أحمد',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'طبيب أمراض جلدية',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '4.9 • 1,247 مريض',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Menu Items
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  children: [
                    // القسم الرئيسي
                    _buildDrawerItem(
                      icon: Icons.dashboard,
                      title: 'لوحة التحكم',
                      onTap: () => Navigator.pop(context),
                      isSelected: true,
                    ),
                    
                    // إدارة المرضى والمواعيد
                    _buildDrawerItem(
                      icon: Icons.people,
                      title: 'إدارة المرضى',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AppRoutes.advancedPatients);
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.calendar_today,
                      title: 'إدارة المواعيد',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AppRoutes.advancedAppointments);
                      },
                    ),
                    
                    const Divider(height: 20, indent: 16, endIndent: 16),
                    
                    // الأدوات الطبية
                    _buildDrawerItem(
                      icon: Icons.psychology,
                      title: 'التشخيص الذكي',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AppRoutes.doctorAiDiagnosis);
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.receipt_long,
                      title: 'إدارة الوصفات',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AppRoutes.prescriptions);
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.medical_services,
                      title: 'قاعدة الأدوية',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AppRoutes.prescriptions);
                      },
                    ),
                    
                    const Divider(height: 20, indent: 16, endIndent: 16),
                    
                    // التقارير والتحليلات
                    _buildDrawerItem(
                      icon: Icons.analytics,
                      title: 'التحليلات المتقدمة',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AppRoutes.analyticsDashboard);
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.assessment,
                      title: 'التقارير الطبية',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AppRoutes.reports);
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.trending_up,
                      title: 'تقارير الأداء',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AppRoutes.analyticsDashboard);
                      },
                    ),
                    
                    const Divider(height: 20, indent: 16, endIndent: 16),
                    
                    // الإعدادات والدعم
                    _buildDrawerItem(
                      icon: Icons.settings,
                      title: 'الإعدادات',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, AppRoutes.doctorSettings);
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.notifications,
                      title: 'الإشعارات',
                      onTap: () {
                        Navigator.pop(context);
                        // Navigate to notifications
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.help_outline,
                      title: 'المساعدة والدعم',
                      onTap: () {
                        Navigator.pop(context);
                        // Navigate to help
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.info_outline,
                      title: 'حول التطبيق',
                      onTap: () {
                        Navigator.pop(context);
                        // Navigate to about
                      },
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          // Logout logic
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text('تسجيل الخروج'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate(effects: fadeInSlide());
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected 
                ? AppColors.primary.withOpacity(0.2) 
                : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isSelected ? AppColors.primary : Colors.grey.shade600,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // Quick Actions Menu
  void _showQuickActionsMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            const SizedBox(height: 20),
            
            const Text(
              'الإجراءات السريعة',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 20),
            
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
              children: [
                _buildQuickActionButton(
                  icon: Icons.person_add,
                  title: 'مريض جديد',
                  color: Colors.blue,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.advancedPatients);
                  },
                ),
                _buildQuickActionButton(
                  icon: Icons.calendar_today,
                  title: 'موعد جديد',
                  color: Colors.green,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.advancedAppointments);
                  },
                ),
                _buildQuickActionButton(
                  icon: Icons.psychology,
                  title: 'تشخيص ذكي',
                  color: Colors.purple,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.doctorAiDiagnosis);
                  },
                ),
                _buildQuickActionButton(
                  icon: Icons.receipt_long,
                  title: 'وصفة طبية',
                  color: Colors.orange,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.prescriptions);
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
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
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
