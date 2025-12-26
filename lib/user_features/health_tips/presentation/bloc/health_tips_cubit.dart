import 'package:derma_ai/user_features/health_tips/data/repositories/health_tips_repository_new.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/health_tip_model.dart';
import '../../data/models/medical_article_model.dart';
import '../../data/models/skin_disease_model.dart';
import 'health_tips_state.dart';

class HealthTipsCubit extends Cubit<HealthTipsState> {
  final HealthTipsRepository _repository;
  
  // Tips variables
  List<HealthTipModel> _currentTips = [];
  int _currentPage = 1;
  bool _hasMore = true;

  // Articles variables
  List<MedicalArticleModel> _currentArticles = [];
  int _currentArticlesPage = 1;
  bool _hasMoreArticles = true;

  // Skin Diseases variables
  List<SkinDiseaseModel> _currentSkinDiseases = [];
  int _currentSkinDiseasesPage = 1;
  bool _hasMoreSkinDiseases = true;

  HealthTipsCubit(this._repository) : super(HealthTipsInitial());

  // Get Latest Tip
  Future<void> getLatestTip() async {
    try {
      emit(LatestTipLoading());
      
      final tip = await _repository.getLatestTip();
      
      emit(LatestTipSuccess(tip));
    } catch (e) {
      emit(LatestTipFailure(e.toString()));
    }
  }

  // Get Daily Tips (First Page)
  Future<void> getDailyTips({bool refresh = false}) async {
    try {
      if (refresh) {
        _currentTips.clear();
        _currentPage = 1;
        _hasMore = true;
      }

      emit(DailyTipsLoading());
      
      final result = await _repository.getDailyTips(page: _currentPage);
      
      _currentTips = result.tips;
      _currentPage = result.currentPage;
      _hasMore = result.hasMore;
      
      emit(DailyTipsSuccess(
        tips: _currentTips,
        hasMore: _hasMore,
        currentPage: _currentPage,
        totalPages: result.lastPage,
        total: result.total,
      ));
    } catch (e) {
      emit(DailyTipsFailure(e.toString()));
    }
  }

  // Load More Tips (Pagination)
  Future<void> loadMoreTips() async {
    if (!_hasMore) return;

    try {
      emit(LoadMoreTipsLoading(_currentTips));
      
      final nextPage = _currentPage + 1;
      final result = await _repository.getDailyTips(page: nextPage);
      
      _currentTips.addAll(result.tips);
      _currentPage = result.currentPage;
      _hasMore = result.hasMore;
      
      emit(LoadMoreTipsSuccess(
        tips: List.from(_currentTips),
        hasMore: _hasMore,
        currentPage: _currentPage,
        totalPages: result.lastPage,
        total: result.total,
      ));
    } catch (e) {
      emit(LoadMoreTipsFailure(e.toString(), _currentTips));
    }
  }

  // Get Medical Articles (First Page)
  Future<void> getMedicalArticles({bool refresh = false}) async {
    try {
      if (refresh) {
        _currentArticles.clear();
        _currentArticlesPage = 1;
        _hasMoreArticles = true;
      }

      emit(MedicalArticlesLoading());
      
      final result = await _repository.getMedicalArticles(page: _currentArticlesPage);
      
      _currentArticles = result.articles;
      _currentArticlesPage = result.currentPage;
      _hasMoreArticles = result.hasMore;
      
      emit(MedicalArticlesSuccess(
        articles: _currentArticles,
        hasMore: _hasMoreArticles,
        currentPage: _currentArticlesPage,
        totalPages: result.lastPage,
        total: result.total,
      ));
    } catch (e) {
      emit(MedicalArticlesFailure(e.toString()));
    }
  }

  // Load More Articles (Pagination)
  Future<void> loadMoreArticles() async {
    if (!_hasMoreArticles) return;

    try {
      emit(LoadMoreArticlesLoading(_currentArticles));
      
      final nextPage = _currentArticlesPage + 1;
      final result = await _repository.getMedicalArticles(page: nextPage);
      
      _currentArticles.addAll(result.articles);
      _currentArticlesPage = result.currentPage;
      _hasMoreArticles = result.hasMore;
      
      emit(LoadMoreArticlesSuccess(
        articles: List.from(_currentArticles),
        hasMore: _hasMoreArticles,
        currentPage: _currentArticlesPage,
        totalPages: result.lastPage,
        total: result.total,
      ));
    } catch (e) {
      emit(LoadMoreArticlesFailure(e.toString(), _currentArticles));
    }
  }

  // Get Single Article by ID
  Future<void> getArticleById(int id) async {
    try {
      emit(SingleArticleLoading());
      
      final article = await _repository.getMedicalArticleById(id);
      
      emit(SingleArticleSuccess(article));
    } catch (e) {
      emit(SingleArticleFailure(e.toString()));
    }
  }

  // Get Skin Diseases (First Page)
  Future<void> getSkinDiseases({bool refresh = false}) async {
    try {
      if (refresh) {
        _currentSkinDiseases.clear();
        _currentSkinDiseasesPage = 1;
        _hasMoreSkinDiseases = true;
      }

      emit(SkinDiseasesLoading());
      
      final result = await _repository.getSkinDiseases(page: _currentSkinDiseasesPage);
      
      _currentSkinDiseases = result.diseases;
      _currentSkinDiseasesPage = result.currentPage;
      _hasMoreSkinDiseases = result.hasMore;
      
      emit(SkinDiseasesSuccess(
        diseases: _currentSkinDiseases,
        hasMore: _hasMoreSkinDiseases,
        currentPage: _currentSkinDiseasesPage,
        totalPages: result.lastPage,
        total: result.total,
      ));
    } catch (e) {
      emit(SkinDiseasesFailure(e.toString()));
    }
  }

  // Load More Skin Diseases (Pagination)
  Future<void> loadMoreSkinDiseases() async {
    if (!_hasMoreSkinDiseases) return;

    try {
      emit(LoadMoreSkinDiseasesLoading(_currentSkinDiseases));
      
      final nextPage = _currentSkinDiseasesPage + 1;
      final result = await _repository.getSkinDiseases(page: nextPage);
      
      _currentSkinDiseases.addAll(result.diseases);
      _currentSkinDiseasesPage = result.currentPage;
      _hasMoreSkinDiseases = result.hasMore;
      
      emit(LoadMoreSkinDiseasesSuccess(
        diseases: List.from(_currentSkinDiseases),
        hasMore: _hasMoreSkinDiseases,
        currentPage: _currentSkinDiseasesPage,
        totalPages: result.lastPage,
        total: result.total,
      ));
    } catch (e) {
      emit(LoadMoreSkinDiseasesFailure(e.toString(), _currentSkinDiseases));
    }
  }

  // Reset State
  void reset() {
    _currentTips.clear();
    _currentPage = 1;
    _hasMore = true;
    _currentArticles.clear();
    _currentArticlesPage = 1;
    _hasMoreArticles = true;
    _currentSkinDiseases.clear();
    _currentSkinDiseasesPage = 1;
    _hasMoreSkinDiseases = true;
    emit(HealthTipsInitial());
  }

  // Getters
  List<HealthTipModel> get currentTips => List.from(_currentTips);
  int get currentPage => _currentPage;
  bool get hasMore => _hasMore;
  
  List<MedicalArticleModel> get currentArticles => List.from(_currentArticles);
  int get currentArticlesPage => _currentArticlesPage;
  bool get hasMoreArticles => _hasMoreArticles;

  List<SkinDiseaseModel> get currentSkinDiseases => List.from(_currentSkinDiseases);
  int get currentSkinDiseasesPage => _currentSkinDiseasesPage;
  bool get hasMoreSkinDiseases => _hasMoreSkinDiseases;
}
