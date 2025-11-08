import 'package:get/get.dart';
import '../../../data/models/prescription_model.dart';
import '../../../services/prescription_service.dart';
import '../../../services/api_call_status.dart';
import '../../../components/custom_snackbar.dart';

class PrescriptionController extends GetxController {
  final _prescriptionService = PrescriptionService();

  // API call status
  final apiCallStatus = ApiCallStatus.loading.obs;

  // Prescriptions list
  final prescriptions = <Prescription>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadPrescriptions();
  }

  // Load prescriptions
  Future<void> loadPrescriptions() async {
    apiCallStatus.value = ApiCallStatus.loading;

    await _prescriptionService.getAllPrescriptions(
      onLoading: () {
        apiCallStatus.value = ApiCallStatus.loading;
      },
      onSuccess: (data) {
        prescriptions.value = data;
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

  // Refresh prescriptions
  Future<void> refreshPrescriptions() async {
    apiCallStatus.value = ApiCallStatus.refresh;
    await loadPrescriptions();
  }

  // Navigate to upload prescription screen
  void goToUploadPrescription() async {
    final result = await Get.toNamed('/upload-prescription');
    if (result == true) {
      // Reload prescriptions after uploading
      await loadPrescriptions();
    }
  }

  // Navigate to prescription details
  void goToPrescriptionDetails(Prescription prescription) {
    Get.toNamed('/prescription-details', arguments: prescription);
  }
}
