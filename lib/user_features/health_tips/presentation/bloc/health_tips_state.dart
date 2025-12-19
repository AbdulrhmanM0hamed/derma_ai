import 'package:equatable/equatable.dart';
import '../../data/models/health_tip_model.dart';
import '../../data/models/medical_article_model.dart';
import '../../data/models/skin_disease_model.dart';

abstract class HealthTipsState extends Equatable {
  const HealthTipsState();

  @override
  List<Object?> get props => [];
}

class HealthTipsInitial extends HealthTipsState {}

class HealthTipsLoading extends HealthTipsState {}

// Latest Tip States
class LatestTipLoading extends HealthTipsState {}

class LatestTipSuccess extends HealthTipsState {
  final HealthTipModel tip;

  const LatestTipSuccess(this.tip);

  @override
  List<Object?> get props => [tip];
}

class LatestTipFailure extends HealthTipsState {
  final String message;

  const LatestTipFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// Daily Tips States
class DailyTipsLoading extends HealthTipsState {}

class DailyTipsSuccess extends HealthTipsState {
  final List<HealthTipModel> tips;
  final bool hasMore;
  final int currentPage;
  final int totalPages;
  final int total;

  const DailyTipsSuccess({
    required this.tips,
    required this.hasMore,
    required this.currentPage,
    required this.totalPages,
    required this.total,
  });

  @override
  List<Object?> get props => [tips, hasMore, currentPage, totalPages, total];
}

class DailyTipsFailure extends HealthTipsState {
  final String message;

  const DailyTipsFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// Load More States
class LoadMoreTipsLoading extends HealthTipsState {
  final List<HealthTipModel> currentTips;

  const LoadMoreTipsLoading(this.currentTips);

  @override
  List<Object?> get props => [currentTips];
}

class LoadMoreTipsSuccess extends HealthTipsState {
  final List<HealthTipModel> tips;
  final bool hasMore;
  final int currentPage;
  final int totalPages;
  final int total;

  const LoadMoreTipsSuccess({
    required this.tips,
    required this.hasMore,
    required this.currentPage,
    required this.totalPages,
    required this.total,
  });

  @override
  List<Object?> get props => [tips, hasMore, currentPage, totalPages, total];
}

class LoadMoreTipsFailure extends HealthTipsState {
  final String message;
  final List<HealthTipModel> currentTips;

  const LoadMoreTipsFailure(this.message, this.currentTips);

  @override
  List<Object?> get props => [message, currentTips];
}

// Medical Articles States
class MedicalArticlesLoading extends HealthTipsState {}

class MedicalArticlesSuccess extends HealthTipsState {
  final List<MedicalArticleModel> articles;
  final bool hasMore;
  final int currentPage;
  final int totalPages;
  final int total;

  const MedicalArticlesSuccess({
    required this.articles,
    required this.hasMore,
    required this.currentPage,
    required this.totalPages,
    required this.total,
  });

  @override
  List<Object?> get props => [articles, hasMore, currentPage, totalPages, total];
}

class MedicalArticlesFailure extends HealthTipsState {
  final String message;

  const MedicalArticlesFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// Load More Articles States
class LoadMoreArticlesLoading extends HealthTipsState {
  final List<MedicalArticleModel> currentArticles;

  const LoadMoreArticlesLoading(this.currentArticles);

  @override
  List<Object?> get props => [currentArticles];
}

class LoadMoreArticlesSuccess extends HealthTipsState {
  final List<MedicalArticleModel> articles;
  final bool hasMore;
  final int currentPage;
  final int totalPages;
  final int total;

  const LoadMoreArticlesSuccess({
    required this.articles,
    required this.hasMore,
    required this.currentPage,
    required this.totalPages,
    required this.total,
  });

  @override
  List<Object?> get props => [articles, hasMore, currentPage, totalPages, total];
}

class LoadMoreArticlesFailure extends HealthTipsState {
  final String message;
  final List<MedicalArticleModel> currentArticles;

  const LoadMoreArticlesFailure(this.message, this.currentArticles);

  @override
  List<Object?> get props => [message, currentArticles];
}

// Single Article States
class SingleArticleLoading extends HealthTipsState {}

class SingleArticleSuccess extends HealthTipsState {
  final MedicalArticleModel article;

  const SingleArticleSuccess(this.article);

  @override
  List<Object?> get props => [article];
}

class SingleArticleFailure extends HealthTipsState {
  final String message;

  const SingleArticleFailure(this.message);

  @override
  List<Object?> get props => [message];
}


// Skin Diseases States
class SkinDiseasesLoading extends HealthTipsState {}

class SkinDiseasesSuccess extends HealthTipsState {
  final List<SkinDiseaseModel> diseases;
  final bool hasMore;
  final int currentPage;
  final int totalPages;
  final int total;

  const SkinDiseasesSuccess({
    required this.diseases,
    required this.hasMore,
    required this.currentPage,
    required this.totalPages,
    required this.total,
  });

  @override
  List<Object?> get props => [diseases, hasMore, currentPage, totalPages, total];
}

class SkinDiseasesFailure extends HealthTipsState {
  final String message;

  const SkinDiseasesFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// Load More Skin Diseases States
class LoadMoreSkinDiseasesLoading extends HealthTipsState {
  final List<SkinDiseaseModel> currentDiseases;

  const LoadMoreSkinDiseasesLoading(this.currentDiseases);

  @override
  List<Object?> get props => [currentDiseases];
}

class LoadMoreSkinDiseasesSuccess extends HealthTipsState {
  final List<SkinDiseaseModel> diseases;
  final bool hasMore;
  final int currentPage;
  final int totalPages;
  final int total;

  const LoadMoreSkinDiseasesSuccess({
    required this.diseases,
    required this.hasMore,
    required this.currentPage,
    required this.totalPages,
    required this.total,
  });

  @override
  List<Object?> get props => [diseases, hasMore, currentPage, totalPages, total];
}

class LoadMoreSkinDiseasesFailure extends HealthTipsState {
  final String message;
  final List<SkinDiseaseModel> currentDiseases;

  const LoadMoreSkinDiseasesFailure(this.message, this.currentDiseases);

  @override
  List<Object?> get props => [message, currentDiseases];
}
