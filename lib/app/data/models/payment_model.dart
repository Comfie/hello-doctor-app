class Payment {
  final int paymentId;
  final String status;
  final double amount;
  final String currency;
  final String purpose;
  final String? provider;
  final int? prescriptionId;
  final DateTime initiatedAt;
  final DateTime? completedAt;
  final String? externalTransactionId;
  final String? failureReason;

  Payment({
    required this.paymentId,
    required this.status,
    required this.amount,
    required this.currency,
    required this.purpose,
    this.provider,
    this.prescriptionId,
    required this.initiatedAt,
    this.completedAt,
    this.externalTransactionId,
    this.failureReason,
  });

  bool get isCompleted => status == 'Completed';
  bool get isPending => status == 'Pending';
  bool get hasFailed => status == 'Failed';
  bool get isCancelled => status == 'Cancelled';
  bool get isRefunded => status == 'Refunded';

  String get displayStatus {
    switch (status) {
      case 'Completed':
        return 'Completed';
      case 'Pending':
        return 'Pending';
      case 'Failed':
        return 'Failed';
      case 'Cancelled':
        return 'Cancelled';
      case 'Refunded':
        return 'Refunded';
      default:
        return status;
    }
  }

  String get statusColor {
    switch (status) {
      case 'Completed':
        return 'green';
      case 'Pending':
        return 'orange';
      case 'Failed':
      case 'Cancelled':
        return 'red';
      case 'Refunded':
        return 'blue';
      default:
        return 'grey';
    }
  }

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentId: json['paymentId'],
      status: json['status'] ?? 'Pending',
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] ?? 'ZAR',
      purpose: json['purpose'] ?? '',
      provider: json['provider'],
      prescriptionId: json['prescriptionId'],
      initiatedAt: DateTime.parse(json['initiatedAt']),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
      externalTransactionId: json['externalTransactionId'],
      failureReason: json['failureReason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentId': paymentId,
      'status': status,
      'amount': amount,
      'currency': currency,
      'purpose': purpose,
      'provider': provider,
      'prescriptionId': prescriptionId,
      'initiatedAt': initiatedAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'externalTransactionId': externalTransactionId,
      'failureReason': failureReason,
    };
  }
}

class InitiatePaymentResponse {
  final int paymentId;
  final String paymentUrl;
  final String status;

  InitiatePaymentResponse({
    required this.paymentId,
    required this.paymentUrl,
    required this.status,
  });

  factory InitiatePaymentResponse.fromJson(Map<String, dynamic> json) {
    final value = json['value'];
    return InitiatePaymentResponse(
      paymentId: value['paymentId'],
      paymentUrl: value['paymentUrl'],
      status: value['status'] ?? 'Pending',
    );
  }
}
