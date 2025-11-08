import 'package:get/get.dart';
import '../../../data/models/beneficiary_model.dart';
import '../../../services/beneficiary_service.dart';
import '../../../services/api_call_status.dart';
import '../../../components/custom_snackbar.dart';

class BeneficiaryController extends GetxController {
  final _beneficiaryService = BeneficiaryService();

  // API call status
  final apiCallStatus = ApiCallStatus.loading.obs;

  // Beneficiaries list
  final beneficiaries = <Beneficiary>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadBeneficiaries();
  }

  // Load beneficiaries
  Future<void> loadBeneficiaries() async {
    apiCallStatus.value = ApiCallStatus.loading;

    final result = await _beneficiaryService.getAllBeneficiaries(
      onLoading: () {
        apiCallStatus.value = ApiCallStatus.loading;
      },
      onSuccess: (data) {
        beneficiaries.value = data;
        if (data.isEmpty) {
          apiCallStatus.value = ApiCallStatus.empty;
        } else {
          apiCallStatus.value = ApiCallStatus.success;
        }
      },
      onError: (error) {
        apiCallStatus.value = ApiCallStatus.error;
        CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message: error,
        );
      },
    );
  }

  // Refresh beneficiaries
  Future<void> refreshBeneficiaries() async {
    apiCallStatus.value = ApiCallStatus.refresh;
    await loadBeneficiaries();
  }

  // Delete beneficiary
  Future<void> deleteBeneficiary(int beneficiaryId) async {
    // Show confirmation dialog
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Delete Beneficiary'),
        content: const Text(
          'Are you sure you want to delete this beneficiary? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    // Perform deletion
    final success = await _beneficiaryService.deleteBeneficiary(
      id: beneficiaryId,
      onSuccess: () {
        CustomSnackBar.showCustomSnackBar(
          title: 'Success',
          message: 'Beneficiary deleted successfully',
        );
        // Remove from list
        beneficiaries.removeWhere((b) => b.id == beneficiaryId);
        // Update status if list is now empty
        if (beneficiaries.isEmpty) {
          apiCallStatus.value = ApiCallStatus.empty;
        }
      },
      onError: (error) {
        CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message: error,
        );
      },
    );
  }

  // Navigate to add beneficiary screen
  void goToAddBeneficiary() async {
    final result = await Get.toNamed('/add-beneficiary');
    if (result == true) {
      // Reload beneficiaries after adding
      await loadBeneficiaries();
    }
  }

  // Navigate to beneficiary details
  void goToBeneficiaryDetails(Beneficiary beneficiary) {
    // Navigate to details screen (if exists)
    // Get.toNamed('/beneficiary-details', arguments: beneficiary);
  }
}
