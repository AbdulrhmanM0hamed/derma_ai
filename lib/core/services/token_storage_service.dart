import 'package:shared_preferences/shared_preferences.dart';

class TokenStorageService {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _sessionTokenKey = 'session_token';
  static const String _userIdKey = 'user_id';
  static const String _userUuidKey = 'user_uuid';
  static const String _userEmailKey = 'user_email';
  static const String _userStatusKey = 'user_status';
  static const String _entityTypeKey = 'entity_type';
  static const String _onboardingCompletedKey = 'onboarding_completed';
  static const String _rememberMeKey = 'remember_me';
  static const String _rememberedEmailKey = 'remembered_email';
  static const String _rememberedPasswordKey = 'remembered_password';

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
  String? get entityType => _prefs.getString(_entityTypeKey);

  // Save entity type (user or doctor)
  Future<void> saveEntityType(String type) async {
    await _prefs.setString(_entityTypeKey, type);
  }

  // Save refresh token
  Future<void> saveRefreshToken(String token) async {
    await _prefs.setString(_refreshTokenKey, token);
  }

  // Check if user is logged in
  bool get isLoggedIn => accessToken != null && accessToken!.isNotEmpty;

  // Mark onboarding as completed
  Future<void> setOnboardingCompleted({bool completed = true}) async {
    await _prefs.setBool(_onboardingCompletedKey, completed);
  }

  bool get isOnboardingCompleted =>
      _prefs.getBool(_onboardingCompletedKey) ?? false;

  // Remember me functionality
  Future<void> setRememberMe({
    required bool remember,
    String? email,
    String? password,
  }) async {
    await _prefs.setBool(_rememberMeKey, remember);
    if (remember) {
      if (email != null) {
        await _prefs.setString(_rememberedEmailKey, email);
      }
      if (password != null) {
        await _prefs.setString(_rememberedPasswordKey, password);
      }
    } else {
      await _prefs.remove(_rememberedEmailKey);
      await _prefs.remove(_rememberedPasswordKey);
    }
  }

  bool get isRememberMeEnabled => _prefs.getBool(_rememberMeKey) ?? false;
  String? get rememberedEmail => _prefs.getString(_rememberedEmailKey);
  String? get rememberedPassword => _prefs.getString(_rememberedPasswordKey);

  // Clear only remember me data (if user wants to forget credentials)
  Future<void> clearRememberMe() async {
    await Future.wait([
      _prefs.remove(_rememberMeKey),
      _prefs.remove(_rememberedEmailKey),
      _prefs.remove(_rememberedPasswordKey),
    ]);
  }

  // Clear all data (logout) - but preserve remember me settings
  Future<void> clearAll() async {
    await Future.wait([
      _prefs.remove(_accessTokenKey),
      _prefs.remove(_refreshTokenKey),
      _prefs.remove(_sessionTokenKey),
      _prefs.remove(_userIdKey),
      _prefs.remove(_userUuidKey),
      _prefs.remove(_userEmailKey),
      _prefs.remove(_userStatusKey),
      // Note: We DON'T clear remember me data on logout
      // This allows user to have email pre-filled on next login
    ]);
  }

  // Update access token (for refresh token flow)
  Future<void> updateAccessToken(String newAccessToken) async {
    await _prefs.setString(_accessTokenKey, newAccessToken);
  }

  // Save access token only
  Future<void> saveAccessToken(String accessToken) async {
    await _prefs.setString(_accessTokenKey, accessToken);
  }

  // Clear tokens (for logout)
  Future<void> clearTokens() async {
    await Future.wait([
      _prefs.remove(_accessTokenKey),
      _prefs.remove(_refreshTokenKey),
      _prefs.remove(_sessionTokenKey),
    ]);
  }

  // --- Location Persistence ---
  static const String _selectedCountryKey = 'selected_country';
  static const String _selectedCityKey = 'selected_city';
  static const String _selectedRegionKey = 'selected_region';

  // Save selected location (stores full JSON string or just IDs - storing JSON is better for restoring model)
  // For simplicity and avoiding model dependency here, we will store individual fields or a JSON string if we passed model.
  // Actually, let's store the ID and Name for each level to easily reconstruction or display.
  // But to keep it clean, let's just store the JSON string of the object.
  // We need to valid JSON string.

  // Actually, to avoid circular deps or complexity, let's just store the keys here and handle encoding in Cubit,
  // OR add specific methods for Country/City/Regional storage.

  Future<void> saveSelectedLocation({
    String? countryJson,
    String? cityJson,
    String? regionJson,
  }) async {
    if (countryJson != null)
      await _prefs.setString(_selectedCountryKey, countryJson);
    if (cityJson != null) await _prefs.setString(_selectedCityKey, cityJson);
    if (regionJson != null)
      await _prefs.setString(_selectedRegionKey, regionJson);
  }

  String? get savedCountry => _prefs.getString(_selectedCountryKey);
  String? get savedCity => _prefs.getString(_selectedCityKey);
  String? get savedRegion => _prefs.getString(_selectedRegionKey);

  Future<void> clearSavedLocation() async {
    await Future.wait([
      _prefs.remove(_selectedCountryKey),
      _prefs.remove(_selectedCityKey),
      _prefs.remove(_selectedRegionKey),
    ]);
  }
}
