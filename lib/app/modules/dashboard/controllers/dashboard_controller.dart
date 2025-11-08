import 'package:get/get.dart';
import '../../../services/auth_service.dart';
import '../../../services/beneficiary_service.dart';
import '../../../services/prescription_service.dart';
import '../../../services/api_call_status.dart';

class DashboardController extends GetxController {
  final _authService = AuthService();
  final _beneficiaryService = BeneficiaryService();
  final _prescriptionService = PrescriptionService();

  // API call status
  final apiCallStatus = ApiCallStatus.loading.obs;

  // User data
  String get userName => _authService.currentUser.value?.fullName ?? 'User';
  String get userEmail => _authService.currentUser.value?.email ?? '';

  // Counts
  final beneficiaryCount = 0.obs;
  final prescriptionCount = 0.obs;
  final paymentCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  // Load dashboard data
  Future<void> loadDashboardData() async {
    apiCallStatus.value = ApiCallStatus.loading;

    try {
      // Load beneficiaries
      final beneficiaries = await _beneficiaryService.getAllBeneficiaries(
        onSuccess: (data) {
          beneficiaryCount.value = data.length;
        },
        onError: (error) {
          // Handle error silently for counts
        },
      );

      // Load prescriptions
      final prescriptions = await _prescriptionService.getAllPrescriptions(
        onSuccess: (data) {
          prescriptionCount.value = data.length;
        },
        onError: (error) {
          // Handle error silently for counts
        },
      );

      apiCallStatus.value = ApiCallStatus.success;
    } catch (e) {
      apiCallStatus.value = ApiCallStatus.error;
    }
  }

  // Refresh dashboard
  Future<void> refreshDashboard() async {
    await loadDashboardData();
  }

  // Logout
  Future<void> logout() async {
    await _authService.logout();
    Get.offAllNamed('/login'); // Navigate to login screen
  }
}
