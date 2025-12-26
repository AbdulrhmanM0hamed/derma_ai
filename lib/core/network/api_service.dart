import 'package:derma_ai/core/network/api_helper.dart';
import 'package:dio/dio.dart';
import 'dio_client.dart';

class ApiService {
  final DioClient _dioClient = DioClient.instance;
  
  // GET request with error handling
  Future<T> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    return await ApiHelper.executeApiCall<T>(() async {
      final response = await _dioClient.get(
        endpoint,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      );
      
      if (fromJson != null) {
        return fromJson(response.data);
      }
      return response.data as T;
    });
  }
  
  // POST request with error handling
  Future<T> post<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    return await ApiHelper.executeApiCall<T>(() async {
      final response = await _dioClient.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      );
      
      if (fromJson != null) {
        return fromJson(response.data);
      }
      return response.data as T;
    });
  }
  
  // PUT request with error handling
  Future<T> put<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    return await ApiHelper.executeApiCall<T>(() async {
      final response = await _dioClient.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      );
      
      if (fromJson != null) {
        return fromJson(response.data);
      }
      return response.data as T;
    });
  }
  
  // DELETE request with error handling
  Future<T> delete<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    return await ApiHelper.executeApiCall<T>(() async {
      final response = await _dioClient.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      );
      
      if (fromJson != null) {
        return fromJson(response.data);
      }
      return response.data as T;
    });
  }
  
  // PATCH request with error handling
  Future<T> patch<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    return await ApiHelper.executeApiCall<T>(() async {
      final response = await _dioClient.patch(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      );
      
      if (fromJson != null) {
        return fromJson(response.data);
      }
      return response.data as T;
    });
  }
  
  // Safe API call that returns ApiResult
  Future<ApiResult<T>> safeGet<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    return await ApiHelper.safeApiCall<T>(() async {
      final response = await _dioClient.get(
        endpoint,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      );
      
      if (fromJson != null) {
        return fromJson(response.data);
      }
      return response.data as T;
    });
  }
  
  Future<ApiResult<T>> safePost<T>(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    return await ApiHelper.safeApiCall<T>(() async {
      final response = await _dioClient.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      );
      
      if (fromJson != null) {
        return fromJson(response.data);
      }
      return response.data as T;
    });
  }
  
  // Update language for all future requests
  void updateLanguage(String languageCode) {
    _dioClient.updateLanguage(languageCode);
  }
  
  // Set authentication token
  void setAuthToken(String token) {
    _dioClient.setAuthToken(token);
  }
  
  // Clear authentication token
  void clearAuthToken() {
    _dioClient.clearAuthToken();
  }
  
  // Update base URL
  void updateBaseUrl(String newBaseUrl) {
    _dioClient.updateBaseUrl(newBaseUrl);
  }
  
  // POST multipart request for file uploads
  Future<T> postMultipart<T>(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, String>? files,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    return await ApiHelper.executeApiCall<T>(() async {
      // Create FormData for multipart request
      final formData = FormData();
      
      // Add regular data fields
      if (data != null) {
        data.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }
      
      // Add file fields
      if (files != null) {
        for (final entry in files.entries) {
          final file = await MultipartFile.fromFile(
            entry.value,
            filename: entry.value.split('/').last,
          );
          formData.files.add(MapEntry(entry.key, file));
        }
      }
      
      final response = await _dioClient.post(
        endpoint,
        data: formData,
        queryParameters: queryParameters,
        options: headers != null ? Options(headers: headers) : null,
      );
      
      if (fromJson != null) {
        return fromJson(response.data);
      }
      return response.data as T;
    });
  }
}
