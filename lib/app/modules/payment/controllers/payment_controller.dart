import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../data/models/payment_model.dart';
import '../../../data/models/prescription_model.dart';
import '../../../services/payment_service.dart';
import '../../../services/prescription_service.dart';
import '../../../services/api_call_status.dart';
import '../../../components/custom_snackbar.dart';

class PaymentController extends GetxController {
  final _paymentService = PaymentService();
  final _prescriptionService = PrescriptionService();

  // API call status
  final apiCallStatus = ApiCallStatus.loading.obs;

  // Payment data
  late int prescriptionId;
  late double amount;
  final prescription = Rx<Prescription?>(null);
  final paymentResponse = Rx<InitiatePaymentResponse?>(null);
  final isPollingStatus = false.obs;

  // WebView controller
  WebViewController? webViewController;
  final isWebViewLoading = true.obs;

  @override
  void onInit() {
    super.onInit();

    // Get arguments
    final args = Get.arguments as Map<String, dynamic>?;
    if (args == null) {
      // Defer navigation until after build completes
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.back();
        // Show error after navigating back
        Future.delayed(const Duration(milliseconds: 100), () {
          CustomSnackBar.showCustomErrorSnackBar(
            title: 'Error',
            message: 'Invalid payment parameters',
          );
        });
      });
      return;
    }

    prescriptionId = args['prescriptionId'] as int;
    amount = args['amount'] as double;

    // Load prescription details
    _loadPrescriptionDetails();

    // Initialize payment
    _initiatePayment();
  }

  // Load prescription details
  Future<void> _loadPrescriptionDetails() async {
    await _prescriptionService.getPrescription(
      prescriptionId: prescriptionId,
      onSuccess: (data) {
        prescription.value = data;
      },
      onError: (error) {
        // Continue with payment even if prescription details fail
        print('Failed to load prescription details: $error');
      },
    );
  }

  // Initiate payment
  Future<void> _initiatePayment() async {
    apiCallStatus.value = ApiCallStatus.loading;

    await _paymentService.initiatePayment(
      amount: amount,
      prescriptionId: prescriptionId,
      onSuccess: (response) {
        paymentResponse.value = response;
        apiCallStatus.value = ApiCallStatus.success;
        _setupWebView();
      },
      onError: (error) {
        apiCallStatus.value = ApiCallStatus.error;
        CustomSnackBar.showCustomErrorSnackBar(
          title: 'Payment Error',
          message: error,
        );
        Future.delayed(const Duration(seconds: 2), () => Get.back());
      },
    );
  }

  // Setup WebView
  void _setupWebView() {
    if (paymentResponse.value == null) return;

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            isWebViewLoading.value = true;
          },
          onPageFinished: (url) {
            isWebViewLoading.value = false;
            _handleNavigationChange(url);
          },
          onWebResourceError: (error) {
            print('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(paymentResponse.value!.paymentUrl));
  }

  // Handle navigation change
  void _handleNavigationChange(String url) {
    // Check if redirected to success/cancel page
    if (url.contains('success') ||
        url.contains('cancel') ||
        url.contains('notify')) {
      // Start polling payment status
      _pollPaymentStatus();
    }
  }

  // Poll payment status
  Future<void> _pollPaymentStatus() async {
    if (isPollingStatus.value) return;
    if (paymentResponse.value == null) return;

    isPollingStatus.value = true;

    await _paymentService.pollPaymentStatus(
      paymentId: paymentResponse.value!.paymentId,
      onCompleted: (payment) {
        isPollingStatus.value = false;
        _showPaymentSuccessDialog(payment);
      },
      onFailed: (payment) {
        isPollingStatus.value = false;
        _showPaymentFailedDialog(payment);
      },
      onTimeout: (message) {
        isPollingStatus.value = false;
        _showPaymentTimeoutDialog();
      },
    );
  }

  // Show payment success dialog
  void _showPaymentSuccessDialog(Payment payment) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Row(
            children: const [
              Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 28),
              SizedBox(width: 12),
              Text('Payment Successful'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your payment has been processed successfully!',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Text(
                'Amount: R ${payment.amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if (payment.externalTransactionId != null)
                Text(
                  'Transaction ID: ${payment.externalTransactionId}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF757575),
                  ),
                ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.back(); // Close dialog
                Get.back(result: true); // Return to previous screen with success
              },
              child: const Text('Done'),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  // Show payment failed dialog
  void _showPaymentFailedDialog(Payment payment) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Row(
            children: const [
              Icon(Icons.error, color: Color(0xFFEF5350), size: 28),
              SizedBox(width: 12),
              Text('Payment Failed'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                payment.failureReason ?? 'Your payment could not be processed.',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'Please try again or contact support if the problem persists.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF757575),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close dialog
                Get.back(result: false); // Return to previous screen
              },
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back(); // Close dialog
                _initiatePayment(); // Retry payment
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  // Show payment timeout dialog
  void _showPaymentTimeoutDialog() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Row(
            children: const [
              Icon(Icons.access_time, color: Color(0xFFFFA726), size: 28),
              SizedBox(width: 12),
              Text('Payment Pending'),
            ],
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'We are still waiting for payment confirmation.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Please check your payment history later to confirm the status.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF757575),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Get.back(); // Close dialog
                Get.back(); // Return to previous screen
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  // Retry payment
  void retryPayment() {
    _initiatePayment();
  }

  @override
  void onClose() {
    webViewController = null;
    super.onClose();
  }
}
