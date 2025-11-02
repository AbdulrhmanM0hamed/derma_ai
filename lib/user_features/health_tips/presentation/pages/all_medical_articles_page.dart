import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/service_locatores.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/health_tips_cubit.dart';
import '../bloc/health_tips_state.dart';
import '../widgets/article_card.dart';
import '../widgets/article_shimmer_card.dart';

class AllMedicalArticlesPage extends StatefulWidget {
  const AllMedicalArticlesPage({super.key});
  static const String routeName= "/all-medical-articles" ;

  @override
  State<AllMedicalArticlesPage> createState() => _AllMedicalArticlesPageState();
}

class _AllMedicalArticlesPageState extends State<AllMedicalArticlesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HealthTipsCubit>(),
      child: const _AllMedicalArticlesContent(),
    );
  }
}

class _AllMedicalArticlesContent extends StatefulWidget {
  const _AllMedicalArticlesContent();

  @override
  State<_AllMedicalArticlesContent> createState() => _AllMedicalArticlesContentState();
}

class _AllMedicalArticlesContentState extends State<_AllMedicalArticlesContent> {
  late ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    
    // تحميل المقالات عند بدء الصفحة
    context.read<HealthTipsCubit>().getMedicalArticles(refresh: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
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

    await context.read<HealthTipsCubit>().loadMoreArticles();

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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // App Bar مثل الصفحة الأصلية
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                l10n.medicalArticles,
                style: getBoldStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: FontConstant.cairo,
                ),
              ),
              centerTitle: true,
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          BlocBuilder<HealthTipsCubit, HealthTipsState>(
            builder: (context, state) {
              if (state is MedicalArticlesLoading) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: const ArticleShimmerCard(),
                    ),
                    childCount: 6, // عرض 6 shimmer cards
                  ),
                );
              } else if (state is MedicalArticlesSuccess ||
                  state is LoadMoreArticlesSuccess ||
                  state is LoadMoreArticlesLoading) {
                List articles = [];
                bool hasMore = false;
                bool isLoadingMore = false;

                if (state is MedicalArticlesSuccess) {
                  articles = state.articles;
                  hasMore = state.hasMore;
                } else if (state is LoadMoreArticlesSuccess) {
                  articles = state.articles;
                  hasMore = state.hasMore;
                } else if (state is LoadMoreArticlesLoading) {
                  articles = state.currentArticles;
                  hasMore = true;
                  isLoadingMore = true;
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < articles.length) {
                        final article = articles[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: ArticleCard(
                            article: article,
                            index: index,
                          ),
                        );
                      } else if (hasMore && index == articles.length) {
                        // مؤشر تحميل المزيد
                        return Container(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child:
                                isLoadingMore
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 8.0,
                                        ),
                                        child: const ArticleShimmerCard(),
                                      )
                                    : TextButton(
                                      onPressed: () {
                                        context
                                            .read<HealthTipsCubit>()
                                            .loadMoreArticles();
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
                    },
                    childCount: articles.length + (hasMore ? 1 : 0),
                  ),
                );
              } else if (state is MedicalArticlesFailure) {
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
                            context.read<HealthTipsCubit>().getMedicalArticles(refresh: true);
                          },
                          child: Text(
                            l10n.retry,
                            style: getMediumStyle(
                              color: Colors.white,
                              fontSize: 14,
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
