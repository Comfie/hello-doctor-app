import 'package:get/get.dart';
import '../../../data/models/prescription_model.dart';
import '../../../services/prescription_service.dart';
import '../../../services/api_call_status.dart';
import '../../../components/custom_snackbar.dart';

class PrescriptionDetailsController extends GetxController {
  final _prescriptionService = PrescriptionService();

  // API call status
  final apiCallStatus = ApiCallStatus.loading.obs;

  // Prescription details
  final prescription = Rx<Prescription?>(null);

  @override
  void onInit() {
    super.onInit();
    // Get prescription from arguments
    final prescriptionArg = Get.arguments;
    if (prescriptionArg != null && prescriptionArg is Prescription) {
      prescription.value = prescriptionArg;
      // Load full details from server
      loadPrescriptionDetails(prescriptionArg.id);
    } else {
      apiCallStatus.value = ApiCallStatus.error;
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Error',
        message: 'Invalid prescription data',
      );
    }
  }

  // Load prescription details
  Future<void> loadPrescriptionDetails(int prescriptionId) async {
    apiCallStatus.value = ApiCallStatus.loading;

    await _prescriptionService.getPrescription(
      prescriptionId: prescriptionId,
      onSuccess: (data) {
        prescription.value = data;
        apiCallStatus.value = ApiCallStatus.success;
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

  // Refresh prescription details
  Future<void> refreshDetails() async {
    if (prescription.value != null) {
      apiCallStatus.value = ApiCallStatus.refresh;
      await loadPrescriptionDetails(prescription.value!.id);
    }
  }

  // Navigate to payment screen
  void navigateToPayment() {
    if (prescription.value != null && prescription.value!.requiresPayment) {
      // Navigate to payment screen with prescription ID
      Get.toNamed('/payments', arguments: {
        'prescriptionId': prescription.value!.id,
        'purpose': 'Prescription Payment',
      });
    }
  }

  // Get status history (mock data for now, would come from API in real app)
  List<StatusHistoryItem> getStatusHistory() {
    if (prescription.value == null) return [];

    final List<StatusHistoryItem> history = [];

    // Add created status
    if (prescription.value!.createdAt != null) {
      history.add(StatusHistoryItem(
        status: 'Created',
        timestamp: prescription.value!.createdAt!,
        description: 'Prescription uploaded successfully',
      ));
    }

    // Add current status
    history.add(StatusHistoryItem(
      status: prescription.value!.displayStatus,
      timestamp: DateTime.now(),
      description: 'Current status',
    ));

    // Sort by timestamp
    history.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return history;
  }
}

class StatusHistoryItem {
  final String status;
  final DateTime timestamp;
  final String description;

  StatusHistoryItem({
    required this.status,
    required this.timestamp,
    required this.description,
  });
}
