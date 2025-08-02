import 'package:shared_preferences/shared_preferences.dart';

class TokenStorageService {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _sessionTokenKey = 'session_token';
  static const String _userIdKey = 'user_id';
  static const String _userUuidKey = 'user_uuid';
  static const String _userEmailKey = 'user_email';
  static const String _userStatusKey = 'user_status';

  final SharedPreferences _prefs;

  TokenStorageService(this._prefs);

  // Save tokens
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required String sessionToken,
  }) async {
    await Future.wait([
      _prefs.setString(_accessTokenKey, accessToken),
      _prefs.setString(_refreshTokenKey, refreshToken),
      _prefs.setString(_sessionTokenKey, sessionToken),
    ]);
  }

  // Save user data
  Future<void> saveUserData({
    required int userId,
    required String userUuid,
    required String userEmail,
    required String userStatus,
  }) async {
    await Future.wait([
      _prefs.setInt(_userIdKey, userId),
      _prefs.setString(_userUuidKey, userUuid),
      _prefs.setString(_userEmailKey, userEmail),
      _prefs.setString(_userStatusKey, userStatus),
    ]);
  }

  // Get tokens
  String? get accessToken => _prefs.getString(_accessTokenKey);
  String? get refreshToken => _prefs.getString(_refreshTokenKey);
  String? get sessionToken => _prefs.getString(_sessionTokenKey);

  // Get user data
  int? get userId => _prefs.getInt(_userIdKey);
  String? get userUuid => _prefs.getString(_userUuidKey);
  String? get userEmail => _prefs.getString(_userEmailKey);
  String? get userStatus => _prefs.getString(_userStatusKey);

  // Check if user is logged in
  bool get isLoggedIn => accessToken != null && accessToken!.isNotEmpty;

  // Clear all data (logout)
  Future<void> clearAll() async {
    await Future.wait([
      _prefs.remove(_accessTokenKey),
      _prefs.remove(_refreshTokenKey),
      _prefs.remove(_sessionTokenKey),
      _prefs.remove(_userIdKey),
      _prefs.remove(_userUuidKey),
      _prefs.remove(_userEmailKey),
      _prefs.remove(_userStatusKey),
    ]);
  }

  // Update access token (for refresh token flow)
  Future<void> updateAccessToken(String newAccessToken) async {
    await _prefs.setString(_accessTokenKey, newAccessToken);
  }
}
