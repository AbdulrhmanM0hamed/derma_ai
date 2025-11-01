import '../../../../core/network/api_service.dart';
import '../../../../core/utils/constant/api_endpoints.dart';
import '../models/health_tip_model.dart';
import '../models/health_tips_response_model.dart';

abstract class HealthTipsRepository {
  Future<HealthTipsResult> getDailyTips({int page = 1, int limit = 10});
  Future<HealthTipModel> getLatestTip();
}

class HealthTipsRepositoryImpl implements HealthTipsRepository {
  final ApiService _apiService;

  HealthTipsRepositoryImpl(this._apiService);

  @override
  Future<HealthTipsResult> getDailyTips({int page = 1, int limit = 10}) async {
    try {
      final queryParams = {'page': page, 'limit': limit};

      final response = await _apiService.get<Map<String, dynamic>>(
        ApiEndpoints.dailyTipsActive,
        queryParameters: queryParams,
        fromJson: (data) => data,
      );

      final responseModel = HealthTipsResponseModel.fromJson(response);
      final pagination = responseModel.pagination;

      // إذا لم توجد pagination، نستخدم logic بسيط
      if (pagination == null) {
        final hasMore = responseModel.data.isNotEmpty;

        return HealthTipsResult(
          tips: responseModel.data,
          hasMore: hasMore,
          currentPage: page,
          lastPage: hasMore ? page + 1 : page,
          total: responseModel.data.length,
        );
      }

      return HealthTipsResult(
        tips: responseModel.data,
        hasMore: page < pagination.pages,
        currentPage: pagination.page,
        lastPage: pagination.pages,
        total: pagination.total,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<HealthTipModel> getLatestTip() async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        ApiEndpoints.dailyTipsLatest,
        fromJson: (data) => data,
      );

      final responseModel = SingleHealthTipResponseModel.fromJson(
        response,
      );
      return responseModel.data;
    } catch (e) {
      rethrow;
    }
  }
}
