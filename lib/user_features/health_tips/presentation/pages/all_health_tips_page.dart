import 'package:derma_ai/core/utils/common/custom_app_bar.dart';
import 'package:derma_ai/core/utils/common/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/service_locatores.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/health_tips_cubit.dart';
import '../bloc/health_tips_state.dart';
import '../widgets/daily_tip_card.dart';

class AllHealthTipsPage extends StatefulWidget {
  const AllHealthTipsPage({super.key});

  @override
  State<AllHealthTipsPage> createState() => _AllHealthTipsPageState();
}

class _AllHealthTipsPageState extends State<AllHealthTipsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HealthTipsCubit>(
      create: (context) => sl<HealthTipsCubit>(),
      child: _AllHealthTipsContent(),
    );
  }
}

class _AllHealthTipsContent extends StatefulWidget {
  @override
  State<_AllHealthTipsContent> createState() => _AllHealthTipsContentState();
}

class _AllHealthTipsContentState extends State<_AllHealthTipsContent> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    // تحميل جميع النصائح عند فتح الصفحة
    context.read<HealthTipsCubit>().getDailyTips();

    // إضافة listener للـ infinite scroll
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isLoadingMore) return; // منع التحميل المتكرر

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // تحميل المزيد عند الوصول لنهاية القائمة
      _loadMore();
    }
  }

  void _loadMore() async {
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    await context.read<HealthTipsCubit>().loadMoreTips();

    if (mounted) {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(title: l10n.allHealthTips),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // App Bar مثل الصفحة الأصلية

          // قائمة النصائح
          BlocBuilder<HealthTipsCubit, HealthTipsState>(
            builder: (context, state) {
              if (state is DailyTipsLoading) {
                return const SliverFillRemaining(
                  child: Center(child: CustomProgressIndicator()),
                );
              } else if (state is DailyTipsSuccess ||
                  state is LoadMoreTipsSuccess ||
                  state is LoadMoreTipsLoading) {
                List tips = [];
                bool hasMore = false;
                bool isLoadingMore = false;

                if (state is DailyTipsSuccess) {
                  tips = state.tips;
                  hasMore = state.hasMore;
                } else if (state is LoadMoreTipsSuccess) {
                  tips = state.tips;
                  hasMore = state.hasMore;
                } else if (state is LoadMoreTipsLoading) {
                  tips = state.currentTips;
                  hasMore = true;
                  isLoadingMore = true;
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index < tips.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: DailyTipCard(
                          tip: tips[index],
                          heroTag: 'all_tips_hero_${tips[index].id}_$index',
                        ),
                      );
                    } else if (hasMore && index == tips.length) {
                      // مؤشر تحميل المزيد
                      return Container(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child:
                              isLoadingMore
                                  ? const CustomProgressIndicator()
                                  : TextButton(
                                    onPressed: () {
                                      context
                                          .read<HealthTipsCubit>()
                                          .loadMoreTips();
                                    },
                                    child: Text(
                                      l10n.loadMore,
                                      style: getMediumStyle(
                                        color: AppColors.primary,
                                        fontSize: 16,
                                        fontFamily: FontConstant.cairo,
                                      ),
                                    ),
                                  ),
                        ),
                      );
                    }
                    return null;
                  }, childCount: tips.length + (hasMore ? 1 : 0)),
                );
              } else if (state is DailyTipsFailure) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.errorLoadingTips,
                          style: getBoldStyle(
                            color: Colors.red.shade700,
                            fontSize: 18,
                            fontFamily: FontConstant.cairo,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          style: getRegularStyle(
                            color: Colors.red.shade600,
                            fontSize: 14,
                            fontFamily: FontConstant.cairo,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<HealthTipsCubit>().getDailyTips(
                              refresh: true,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                          child: Text(
                            'إعادة المحاولة',
                            style: getMediumStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: FontConstant.cairo,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverFillRemaining(
                child: Center(child: Text(l10n.noTipsAvailable)),
              );
            },
          ),
        ],
      ),
    );
  }
}
