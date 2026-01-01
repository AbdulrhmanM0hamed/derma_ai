import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/common/custom_progress_indicator.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/services/service_locatores.dart' as di;
import '../../data/models/package_type_config.dart';
import '../cubit/packages_cubit.dart';
import '../cubit/packages_state.dart';
import '../widgets/package_card.dart';

class PackagesPage extends StatelessWidget {
  const PackagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<PackagesCubit>()..getPackagesAndFeatures(),
      child: const _PackagesView(),
    );
  }
}

class _PackagesView extends StatelessWidget {
  const _PackagesView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFF5F7FA),
      appBar: _buildAppBar(context, isDark),
      body: BlocBuilder<PackagesCubit, PackagesState>(
        builder: (context, state) {
          if (state is PackagesLoading) {
            return _buildLoadingState();
          }

          if (state is PackagesError) {
            return _buildErrorState(context, state.message, l10n);
          }

          if (state is PackagesLoaded) {
            return _buildPackagesContent(context, state, isDark);
          }

          return _buildLoadingState();
        },
      ),
    );
  }

  // AppBar
  AppBar _buildAppBar(BuildContext context, bool isDark) {
    return AppBar(
      title: Text(
        'الباقات',
        style: getBoldStyle(
          fontFamily: FontConstant.cairo,
          fontSize: FontSize.size20,
          color: AppColors.textPrimary,
        ),
      ),
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.compare_arrows_rounded),
          onPressed: () {
            context.read<PackagesCubit>().getPackagesComparison();
          },
          tooltip: 'مقارنة الباقات',
        ),
      ],
    );
  }

  // Loading State
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            'جاري تحميل الباقات...',
            style: getMediumStyle(
              fontFamily: FontConstant.cairo,
              fontSize: FontSize.size14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // Error State
  Widget _buildErrorState(
    BuildContext context,
    String message,
    AppLocalizations l10n,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                color: Colors.red,
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'خطأ في تحميل الباقات',
              style: getBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: FontSize.size18,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: getRegularStyle(
                fontFamily: FontConstant.cairo,
                fontSize: FontSize.size14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<PackagesCubit>().getPackagesAndFeatures();
              },
              icon: const Icon(Icons.refresh_rounded),
              label: Text(l10n.retry),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Packages Content
  Widget _buildPackagesContent(
    BuildContext context,
    PackagesLoaded state,
    bool isDark,
  ) {
    // Group packages by type
    final featuredPackages =
        state.packages
            .where((p) => p.packageType == PackageType.featured)
            .toList();
    final premiumPackages =
        state.packages
            .where((p) => p.packageType == PackageType.premium)
            .toList();
    final cheapestPackages =
        state.packages
            .where((p) => p.packageType == PackageType.cheapest)
            .toList();
    final standardPackages =
        state.packages
            .where((p) => p.packageType == PackageType.standard)
            .toList();

    return CustomScrollView(
      slivers: [
        // Page Header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'جميع الباقات (${state.packages.length})',
              style: getBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: FontSize.size18,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),

        // Featured Packages Section
        if (featuredPackages.isNotEmpty) ...[
          _buildSectionHeader('الباقات المميزة', PackageType.featured),
          _buildPackagesList(context, featuredPackages),
        ],

        // Premium Packages Section
        if (premiumPackages.isNotEmpty) ...[
          _buildSectionHeader('الباقات البريميوم', PackageType.premium),
          _buildPackagesList(context, premiumPackages),
        ],

        // Cheapest Packages Section
        if (cheapestPackages.isNotEmpty) ...[
          _buildSectionHeader('الباقات الاقتصادية', PackageType.cheapest),
          _buildPackagesList(context, cheapestPackages),
        ],

        // Standard Packages Section
        if (standardPackages.isNotEmpty) ...[
          _buildSectionHeader('الباقات القياسية', PackageType.standard),
          _buildPackagesList(context, standardPackages),
        ],

        // Empty State
        if (state.packages.isEmpty) _buildEmptyState(),
      ],
    );
  }

  // Section Header
  Widget _buildSectionHeader(String title, PackageType type) {
    final config = PackageTypeConfig.getConfig(type);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: config.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(config.icon, color: config.primaryColor, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: getBoldStyle(
                fontFamily: FontConstant.cairo,
                fontSize: FontSize.size16,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Packages List
  Widget _buildPackagesList(BuildContext context, List packages) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final package = packages[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: PackageCard(
              package: package,
              onTap: () {
                context.read<PackagesCubit>().getPackageById(package.id);
              },
            ),
          );
        }, childCount: packages.length),
      ),
    );
  }

  // Empty State
  Widget _buildEmptyState() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            Icon(
              Icons.inbox_rounded,
              size: 64,
              color: AppColors.textSecondary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'لا توجد باقات في هذا القسم',
              style: getMediumStyle(
                fontFamily: FontConstant.cairo,
                fontSize: FontSize.size16,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
