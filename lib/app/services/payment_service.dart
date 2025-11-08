import 'package:get/get.dart' hide Response;
import '../data/models/payment_model.dart';
import '../../utils/constants.dart';
import 'base_client.dart';
import 'auth_service.dart';

class PaymentService extends GetxService {
  static final PaymentService _instance = PaymentService._internal();
  factory PaymentService() => _instance;
  PaymentService._internal();

  final _authService = AuthService();

  // Initiate payment
  Future<InitiatePaymentResponse?> initiatePayment({
    required double amount,
    required int prescriptionId,
    String? notes,
    required Function(InitiatePaymentResponse) onSuccess,
    Function(String)? onError,
  }) async {
    InitiatePaymentResponse? paymentResponse;

    await BaseClient.safeApiCall(
      Constants.initiatePaymentUrl,
      RequestType.post,
      headers: _authService.authHeaders,
      data: {
        'amount': amount,
        'purpose': 0, // PrescriptionFee
        'provider': 0, // PayFast
        'prescriptionId': prescriptionId,
        if (notes != null) 'notes': notes,
      },
      onSuccess: (response) {
        if (response.data['isSuccess'] == true) {
          paymentResponse = InitiatePaymentResponse.fromJson(response.data);
          onSuccess(paymentResponse!);
        }
      },
      onError: (error) {
        onError?.call(error.message);
      },
    );

    return paymentResponse;
  }

  // Get payment status
  Future<Payment?> getPaymentStatus({
    required int paymentId,
    Function(Payment)? onSuccess,
    Function(String)? onError,
  }) async {
    Payment? payment;

    await BaseClient.safeApiCall(
      Constants.getPaymentStatusUrl(paymentId),
      RequestType.get,
      headers: _authService.authHeaders,
      onSuccess: (response) {
        if (response.data['isSuccess'] == true && response.data['value'] != null) {
          payment = Payment.fromJson(response.data['value']);
          onSuccess?.call(payment!);
        }
      },
      onError: (error) {
        onError?.call(error.message);
      },
    );

    return payment;
  }

  // Get payment history
  Future<List<Payment>> getPaymentHistory({
    int page = 1,
    int pageSize = 20,
    Function()? onLoading,
    Function(List<Payment>)? onSuccess,
    Function(String)? onError,
  }) async {
    List<Payment> payments = [];

    await BaseClient.safeApiCall(
      '${Constants.getPaymentHistoryUrl}?page=$page&pageSize=$pageSize',
      RequestType.get,
      headers: _authService.authHeaders,
      onLoading: onLoading,
      onSuccess: (response) {
        if (response.data['isSuccess'] == true && response.data['value'] != null) {
          final List<dynamic> data = response.data['value'];
          payments = data.map((json) => Payment.fromJson(json)).toList();
          onSuccess?.call(payments);
        }
      },
      onError: (error) {
        onError?.call(error.message);
      },
    );

    return payments;
  }

  // Poll payment status (useful after payment redirect)
  Future<Payment?> pollPaymentStatus({
    required int paymentId,
    int maxAttempts = 10,
    Duration interval = const Duration(seconds: 2),
    required Function(Payment) onCompleted,
    required Function(Payment) onFailed,
    Function(String)? onTimeout,
  }) async {
    for (int i = 0; i < maxAttempts; i++) {
      await Future.delayed(interval);

      final payment = await getPaymentStatus(paymentId: paymentId);

      if (payment != null) {
        if (payment.isCompleted) {
          onCompleted(payment);
          return payment;
        } else if (payment.hasFailed || payment.isCancelled) {
          onFailed(payment);
          return payment;
        }
      }
    }

    onTimeout?.call('Payment status check timed out');
    return null;
  }
}
