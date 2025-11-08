import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/payment_model.dart';
import '../../../services/payment_service.dart';
import '../../../services/api_call_status.dart';
import '../../../components/custom_snackbar.dart';

class PaymentHistoryController extends GetxController {
  final _paymentService = PaymentService();

  // API call status
  final apiCallStatus = ApiCallStatus.loading.obs;

  // Payments list
  final payments = <Payment>[].obs;

  // Pagination
  int currentPage = 1;
  final int pageSize = 20;
  final hasMorePages = true.obs;
  final isLoadingMore = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadPaymentHistory();
  }

  // Load payment history
  Future<void> loadPaymentHistory({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      hasMorePages.value = true;
    }

    apiCallStatus.value = isRefresh ? ApiCallStatus.refresh : ApiCallStatus.loading;

    final result = await _paymentService.getPaymentHistory(
      page: currentPage,
      pageSize: pageSize,
      onLoading: () {
        if (!isRefresh) {
          apiCallStatus.value = ApiCallStatus.loading;
        }
      },
      onSuccess: (data) {
        if (isRefresh) {
          payments.value = data;
        } else {
          payments.addAll(data);
        }

        // Check if we got fewer items than page size (last page)
        if (data.length < pageSize) {
          hasMorePages.value = false;
        }

        if (payments.isEmpty) {
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

  // Refresh payment history
  Future<void> refreshPaymentHistory() async {
    await loadPaymentHistory(isRefresh: true);
  }

  // Load more payments (pagination)
  Future<void> loadMorePayments() async {
    if (!hasMorePages.value || isLoadingMore.value) return;

    isLoadingMore.value = true;
    currentPage++;

    final result = await _paymentService.getPaymentHistory(
      page: currentPage,
      pageSize: pageSize,
      onSuccess: (data) {
        payments.addAll(data);

        // Check if we got fewer items than page size (last page)
        if (data.length < pageSize) {
          hasMorePages.value = false;
        }

        isLoadingMore.value = false;
      },
      onError: (error) {
        currentPage--; // Revert page increment on error
        isLoadingMore.value = false;
        CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message: error,
        );
      },
    );
  }

  // Navigate to payment details
  void goToPaymentDetails(Payment payment) {
    Get.dialog(
      AlertDialog(
        title: const Text('Payment Details'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Payment ID', '#${payment.paymentId}'),
              _buildDetailRow('Status', payment.displayStatus),
              _buildDetailRow('Amount', 'R ${payment.amount.toStringAsFixed(2)}'),
              _buildDetailRow('Currency', payment.currency),
              _buildDetailRow('Purpose', payment.purpose),
              if (payment.provider != null)
                _buildDetailRow('Provider', payment.provider!),
              if (payment.prescriptionId != null)
                _buildDetailRow('Prescription ID', '#${payment.prescriptionId}'),
              _buildDetailRow(
                'Initiated At',
                _formatDateTime(payment.initiatedAt),
              ),
              if (payment.completedAt != null)
                _buildDetailRow(
                  'Completed At',
                  _formatDateTime(payment.completedAt!),
                ),
              if (payment.externalTransactionId != null)
                _buildDetailRow(
                  'Transaction ID',
                  payment.externalTransactionId!,
                ),
              if (payment.failureReason != null)
                _buildDetailRow(
                  'Failure Reason',
                  payment.failureReason!,
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  // Retry payment
  void retryPayment(Payment payment) {
    if (payment.prescriptionId == null) {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Error',
        message: 'Cannot retry payment without prescription ID',
      );
      return;
    }

    Get.toNamed(
      '/payment',
      arguments: {
        'prescriptionId': payment.prescriptionId,
        'amount': payment.amount,
      },
    );
  }
}
