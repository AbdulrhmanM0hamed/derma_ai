import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';

class DailyRoutineCard extends StatefulWidget {
  const DailyRoutineCard({super.key});

  @override
  State<DailyRoutineCard> createState() => _DailyRoutineCardState();
}

class _DailyRoutineCardState extends State<DailyRoutineCard>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final morningRoutine = <Map<String, dynamic>>[
      {
        'step': '1',
        'title': 'التنظيف',
        'description': 'استخدم غسول لطيف مناسب لنوع بشرتك',
        'icon': Icons.soap_outlined,
        'time': '2 دقيقة',
      },
      {
        'step': '2',
        'title': 'التونر',
        'description': 'طبق التونر لتوازن درجة الحموضة',
        'icon': Icons.water_outlined,
        'time': '1 دقيقة',
      },
      {
        'step': '3',
        'title': 'السيروم',
        'description': 'استخدم سيروم فيتامين C للحماية',
        'icon': Icons.opacity_outlined,
        'time': '2 دقيقة',
      },
      {
        'step': '4',
        'title': 'المرطب',
        'description': 'رطب بشرتك بكريم مناسب',
        'icon': Icons.favorite_outline,
        'time': '1 دقيقة',
      },
      {
        'step': '5',
        'title': 'واقي الشمس',
        'description': 'طبق واقي الشمس SPF 30 أو أكثر',
        'icon': Icons.wb_sunny_outlined,
        'time': '1 دقيقة',
      },
    ];

    final nightRoutine = <Map<String, dynamic>>[
      {
        'step': '1',
        'title': 'إزالة المكياج',
        'description': 'استخدم مزيل مكياج لطيف',
        'icon': Icons.cleaning_services_outlined,
        'time': '3 دقائق',
      },
      {
        'step': '2',
        'title': 'التنظيف العميق',
        'description': 'نظف بشرتك بغسول مناسب',
        'icon': Icons.soap_outlined,
        'time': '2 دقيقة',
      },
      {
        'step': '3',
        'title': 'التونر',
        'description': 'طبق التونر لإعداد البشرة',
        'icon': Icons.water_outlined,
        'time': '1 دقيقة',
      },
      {
        'step': '4',
        'title': 'العلاج الليلي',
        'description': 'استخدم سيروم الريتينول أو الأحماض',
        'icon': Icons.nights_stay_outlined,
        'time': '2 دقيقة',
      },
      {
        'step': '5',
        'title': 'المرطب الليلي',
        'description': 'طبق كريم ليلي مغذي',
        'icon': Icons.bedtime_outlined,
        'time': '1 دقيقة',
      },
    ];

    return Card(
       margin:  EdgeInsets.zero,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColors.secondaryGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
              labelStyle: getBoldStyle(
                fontSize: 16,
                fontFamily: FontConstant.cairo,
              ),
              unselectedLabelStyle: getRegularStyle(
                fontSize: 16,
                fontFamily: FontConstant.cairo,
              ),
              tabs: const [
                Tab(icon: Icon(Icons.wb_sunny_outlined), text: 'الصباح'),
                Tab(icon: Icon(Icons.nights_stay_outlined), text: 'المساء'),
              ],
            ),
          ),
          SizedBox(
            height: 400,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildRoutineList(morningRoutine),
                _buildRoutineList(nightRoutine),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).scale(delay: 200.ms);
  }

  Widget _buildRoutineList(List<Map<String, dynamic>> routine) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: routine.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final step = routine[index];
        return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: AppColors.secondaryGradient,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        step['step']!,
                        style: getBoldStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: FontConstant.cairo,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              step['icon'] as IconData,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              step['title'] as String,
                              style: getBoldStyle(
                                fontSize: 14,
                                fontFamily: FontConstant.cairo,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                step['time'] as String,
                                style: getRegularStyle(
                                  color: AppColors.primary,
                                  fontSize: 12,
                                  fontFamily: FontConstant.cairo,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          step['description'] as String,
                          style: getRegularStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            fontFamily: FontConstant.cairo,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
            .animate()
            .fadeIn(delay: Duration(milliseconds: 100 * index))
            .slideX(begin: 0.1);
      },
    );
  }
}
