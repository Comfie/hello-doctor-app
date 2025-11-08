import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response;
import '../data/models/auth_model.dart';
import '../../utils/constants.dart';
import 'base_client.dart';
import 'api_call_status.dart';
import '../data/local/my_shared_pref.dart';

class AuthService extends GetxService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final _storage = const FlutterSecureStorage();

  // Observables
  final Rx<AuthUser?> currentUser = Rx<AuthUser?>(null);
  final RxBool isAuthenticated = false.obs;

  // Token management
  String? _token;
  String? _refreshToken;
  DateTime? _tokenExpiry;

  String? get token => _token;
  bool get hasValidToken => _token != null && !isTokenExpired;

  bool get isTokenExpired {
    if (_tokenExpiry == null) return true;
    return DateTime.now().isAfter(_tokenExpiry!.subtract(const Duration(minutes: 5)));
  }

  // Initialize auth service
  Future<void> init() async {
    await loadToken();
    if (hasValidToken) {
      await loadUserData();
    }
  }

  // Load token from secure storage
  Future<void> loadToken() async {
    _token = await _storage.read(key: Constants.keyToken);
    _refreshToken = await _storage.read(key: Constants.keyRefreshToken);
    final expiryStr = await _storage.read(key: Constants.keyTokenExpiry);
    if (expiryStr != null) {
      _tokenExpiry = DateTime.parse(expiryStr);
    }
  }

  // Save token to secure storage
  Future<void> setToken(String token, String refreshToken, DateTime expiresAt) async {
    _token = token;
    _refreshToken = refreshToken;
    _tokenExpiry = expiresAt;
    await _storage.write(key: Constants.keyToken, value: token);
    await _storage.write(key: Constants.keyRefreshToken, value: refreshToken);
    await _storage.write(key: Constants.keyTokenExpiry, value: expiresAt.toIso8601String());
  }

  // Clear tokens
  Future<void> clearTokens() async {
    _token = null;
    _refreshToken = null;
    _tokenExpiry = null;
    await _storage.delete(key: Constants.keyToken);
    await _storage.delete(key: Constants.keyRefreshToken);
    await _storage.delete(key: Constants.keyTokenExpiry);
  }

  // Get auth headers
  Map<String, String> get authHeaders => {
        if (_token != null) 'Authorization': 'Bearer $_token',
      };

  // Load user data from SharedPreferences
  Future<void> loadUserData() async {
    final userData = MySharedPref.getUserData();
    if (userData != null) {
      currentUser.value = AuthUser.fromJson(userData);
      isAuthenticated.value = true;
    }
  }

  // Save user data to SharedPreferences
  Future<void> saveUserData(AuthUser user) async {
    await MySharedPref.setUserData(user.toJson());
    currentUser.value = user;
    isAuthenticated.value = true;
  }

  // Login
  Future<ApiCallStatus> login({
    required String email,
    required String password,
    required Function(AuthResponse) onSuccess,
    Function(String)? onError,
  }) async {
    ApiCallStatus status = ApiCallStatus.holding;

    await BaseClient.safeApiCall(
      Constants.loginUrl,
      RequestType.post,
      data: {
        'email': email,
        'password': password,
      },
      onLoading: () {
        status = ApiCallStatus.loading;
      },
      onSuccess: (response) async {
        final authResponse = AuthResponse.fromJson(response.data);

        if (authResponse.isValid) {
          await setToken(
            authResponse.token!,
            authResponse.refreshToken!,
            authResponse.expiresAt!,
          );
          await saveUserData(authResponse.user!);
          onSuccess(authResponse);
          status = ApiCallStatus.success;
        } else {
          onError?.call('Invalid response from server');
          status = ApiCallStatus.error;
        }
      },
      onError: (error) {
        onError?.call(error.message);
        status = ApiCallStatus.error;
      },
    );

    return status;
  }

  // Register
  Future<ApiCallStatus> register({
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String idNumber,
    required DateTime dateOfBirth,
    required String gender,
    required String address,
    required Function() onSuccess,
    Function(String)? onError,
  }) async {
    ApiCallStatus status = ApiCallStatus.holding;

    await BaseClient.safeApiCall(
      Constants.registerUrl,
      RequestType.post,
      data: {
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'idNumber': idNumber,
        'dateOfBirth': dateOfBirth.toIso8601String(),
        'gender': gender,
        'address': address,
        'role': 'MainMember',
      },
      onLoading: () {
        status = ApiCallStatus.loading;
      },
      onSuccess: (response) {
        if (response.data['isSuccess'] == true) {
          onSuccess();
          status = ApiCallStatus.success;
        } else {
          onError?.call('Registration failed');
          status = ApiCallStatus.error;
        }
      },
      onError: (error) {
        onError?.call(error.message);
        status = ApiCallStatus.error;
      },
    );

    return status;
  }

  // Refresh token
  Future<bool> refreshAccessToken() async {
    if (_refreshToken == null) return false;

    bool success = false;

    await BaseClient.safeApiCall(
      Constants.refreshTokenUrl,
      RequestType.post,
      data: {
        'refreshToken': _refreshToken,
      },
      onSuccess: (response) async {
        final authResponse = AuthResponse.fromJson(response.data);
        if (authResponse.isValid) {
          await setToken(
            authResponse.token!,
            authResponse.refreshToken!,
            authResponse.expiresAt!,
          );
          await saveUserData(authResponse.user!);
          success = true;
        }
      },
      onError: (error) {
        success = false;
      },
    );

    return success;
  }

  // Get user profile
  Future<AuthUser?> getUserProfile(String userId) async {
    AuthUser? user;

    await BaseClient.safeApiCall(
      Constants.getUserByIdUrl(userId),
      RequestType.get,
      headers: authHeaders,
      onSuccess: (response) {
        if (response.data['isSuccess'] == true && response.data['value'] != null) {
          user = AuthUser.fromJson(response.data['value']);
        }
      },
      onError: (error) {
        user = null;
      },
    );

    return user;
  }

  // Update user profile
  Future<bool> updateUserProfile({
    required String id,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String address,
    Function()? onSuccess,
    Function(String)? onError,
  }) async {
    bool success = false;

    await BaseClient.safeApiCall(
      Constants.updateUserUrl,
      RequestType.put,
      headers: authHeaders,
      data: {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'address': address,
      },
      onSuccess: (response) async {
        if (response.data['isSuccess'] == true) {
          // Reload user data
          if (currentUser.value != null) {
            currentUser.value!.firstName = firstName;
            currentUser.value!.lastName = lastName;
            currentUser.value!.phoneNumber = phoneNumber;
            currentUser.value!.address = address;
            await saveUserData(currentUser.value!);
          }
          onSuccess?.call();
          success = true;
        }
      },
      onError: (error) {
        onError?.call(error.message);
        success = false;
      },
    );

    return success;
  }

  // Logout
  Future<void> logout() async {
    await clearTokens();
    await MySharedPref.clearUserData();
    currentUser.value = null;
    isAuthenticated.value = false;
  }
}
