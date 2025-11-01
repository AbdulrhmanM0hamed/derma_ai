import 'package:derma_ai/user_features/health_tips/data/repositories/health_tips_repository_new.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/health_tip_model.dart';
import 'health_tips_state.dart';

class HealthTipsCubit extends Cubit<HealthTipsState> {
  final HealthTipsRepository _repository;
  
  List<HealthTipModel> _currentTips = [];
  int _currentPage = 1;
  bool _hasMore = true;

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

  // Reset State
  void reset() {
    _currentTips.clear();
    _currentPage = 1;
    _hasMore = true;
    emit(HealthTipsInitial());
  }

  // Getters
  List<HealthTipModel> get currentTips => List.from(_currentTips);
  int get currentPage => _currentPage;
  bool get hasMore => _hasMore;
}
