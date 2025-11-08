class Constants {
  Constants._();

  // API Base URLs
  static const String baseUrl = 'http://10.0.2.2:5000/api/v1'; // Android emulator localhost
  // static const String baseUrl = 'http://localhost:5000/api/v1'; // iOS simulator
  // static const String baseUrl = 'https://your-production-domain.com/api/v1'; // Production

  // Authentication Endpoints
  static const String loginUrl = '$baseUrl/authentication/login';
  static const String registerUrl = '$baseUrl/authentication/create';
  static const String refreshTokenUrl = '$baseUrl/authentication/refresh-token';
  static String getUserByIdUrl(String userId) => '$baseUrl/authentication/get-user-by-id/$userId';
  static const String updateUserUrl = '$baseUrl/authentication/update-user';

  // Beneficiary Endpoints
  static const String getAllBeneficiariesUrl = '$baseUrl/beneficiary/get-all-beneficiaries';
  static String getBeneficiaryUrl(int id) => '$baseUrl/beneficiary/get-beneficiary/$id';
  static const String createBeneficiaryUrl = '$baseUrl/beneficiary/create';
  static const String updateBeneficiaryUrl = '$baseUrl/beneficiary/update-beneficiary';
  static String deleteBeneficiaryUrl(int id) => '$baseUrl/beneficiary/delete-beneficiary/$id';

  // Prescription Endpoints
  static const String uploadPrescriptionUrl = '$baseUrl/prescription/upload-file';
  static String getPrescriptionUrl(int id) => '$baseUrl/prescription/$id';
  static const String getAllPrescriptionsUrl = '$baseUrl/prescription/get-all-prescriptions';

  // Payment Endpoints
  static const String initiatePaymentUrl = '$baseUrl/payment/initiate';
  static String getPaymentStatusUrl(int paymentId) => '$baseUrl/payment/$paymentId/status';
  static const String getPaymentHistoryUrl = '$baseUrl/payment/history';

  // Storage Keys
  static const String keyToken = 'jwt_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyTokenExpiry = 'token_expiry';
  static const String keyUserId = 'user_id';
  static const String keyUserData = 'user_data';

  // Validation
  static const int minPasswordLength = 8;
  static const int maxFileSize = 25 * 1024 * 1024; // 25 MB

  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm';
  static const String displayDateFormat = 'dd MMM yyyy';
}