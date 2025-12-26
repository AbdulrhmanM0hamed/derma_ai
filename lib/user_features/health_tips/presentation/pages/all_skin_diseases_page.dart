import 'package:derma_ai/core/utils/common/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/service_locatores.dart';
import '../../../../core/utils/constant/font_manger.dart';
import '../../../../core/utils/constant/styles_manger.dart';
import '../../../../core/utils/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/health_tips_cubit.dart';
import '../bloc/health_tips_state.dart';
import '../widgets/skin_disease_card.dart';
import '../widgets/article_shimmer_card.dart';

class AllSkinDiseasesPage extends StatefulWidget {
  const AllSkinDiseasesPage({super.key});
  static const String routeName = "/all-skin-diseases";

  @override
  State<AllSkinDiseasesPage> createState() => _AllSkinDiseasesPageState();
}

class _AllSkinDiseasesPageState extends State<AllSkinDiseasesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HealthTipsCubit>(),
      child: const _AllSkinDiseasesContent(),
    );
  }
}

class _AllSkinDiseasesContent extends StatefulWidget {
  const _AllSkinDiseasesContent();

  @override
  State<_AllSkinDiseasesContent> createState() => _AllSkinDiseasesContentState();
}

class _AllSkinDiseasesContentState extends State<_AllSkinDiseasesContent> {
  late ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    
    context.read<HealthTipsCubit>().getSkinDiseases(refresh: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMore();
    }
  }

  void _loadMore() async {
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    await context.read<HealthTipsCubit>().loadMoreSkinDiseases();

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
      appBar: CustomAppBar(
        title: l10n.diseaseInformation,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          BlocBuilder<HealthTipsCubit, HealthTipsState>(
            builder: (context, state) {
              if (state is SkinDiseasesLoading) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: ArticleShimmerCard(),
                    ),
                    childCount: 6,
                  ),
                );
              } else if (state is SkinDiseasesSuccess ||
                  state is LoadMoreSkinDiseasesSuccess ||
                  state is LoadMoreSkinDiseasesLoading) {
                List diseases = [];
                bool hasMore = false;
                bool isLoadingMore = false;

                if (state is SkinDiseasesSuccess) {
                  diseases = state.diseases;
                  hasMore = state.hasMore;
                } else if (state is LoadMoreSkinDiseasesSuccess) {
                  diseases = state.diseases;
                  hasMore = state.hasMore;
                } else if (state is LoadMoreSkinDiseasesLoading) {
                  diseases = state.currentDiseases;
                  hasMore = true;
                  isLoadingMore = true;
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < diseases.length) {
                        final disease = diseases[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: SkinDiseaseCard(
                            disease: disease,
                            index: index,
                          ),
                        );
                      } else if (hasMore && index == diseases.length) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: isLoadingMore
                                ? const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 8.0,
                                    ),
                                    child: ArticleShimmerCard(),
                                  )
                                : TextButton(
                                    onPressed: () {
                                      context
                                          .read<HealthTipsCubit>()
                                          .loadMoreSkinDiseases();
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
                    childCount: diseases.length + (hasMore ? 1 : 0),
                  ),
                );
              } else if (state is SkinDiseasesFailure) {
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
                            context.read<HealthTipsCubit>().getSkinDiseases(refresh: true);
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
