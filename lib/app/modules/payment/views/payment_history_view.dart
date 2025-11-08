import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../components/my_widgets_animator.dart';
import '../../../data/models/payment_model.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../controllers/payment_history_controller.dart';

class PaymentHistoryView extends GetView<PaymentHistoryController> {
  const PaymentHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightThemeColors.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Payment History',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: Obx(() => MyWidgetsAnimator(
            apiCallStatus: controller.apiCallStatus.value,
            loadingWidget: () => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: () => _buildErrorWidget(),
            emptyWidget: () => _buildEmptyWidget(),
            successWidget: () => _buildPaymentListWidget(),
          )),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 60.sp,
            color: LightThemeColors.errorColor,
          ),
          SizedBox(height: 16.h),
          Text(
            'Failed to load payment history',
            style: TextStyle(
              fontSize: 16.sp,
              color: LightThemeColors.bodyTextColor,
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton.icon(
            onPressed: controller.loadPaymentHistory,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 80.sp,
            color: LightThemeColors.bodySmallTextColor,
          ),
          SizedBox(height: 16.h),
          Text(
            'No Payment History',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: LightThemeColors.bodyTextColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'You haven\'t made any payments yet',
            style: TextStyle(
              fontSize: 14.sp,
              color: LightThemeColors.bodySmallTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentListWidget() {
    return RefreshIndicator(
      onRefresh: controller.refreshPaymentHistory,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          // Load more when reaching the bottom
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            controller.loadMorePayments();
          }
          return false;
        },
        child: ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: controller.payments.length +
              (controller.hasMorePages.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == controller.payments.length) {
              // Loading indicator for pagination
              return Obx(() {
                if (controller.isLoadingMore.value) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return const SizedBox.shrink();
              });
            }

            final payment = controller.payments[index];
            return _buildPaymentCard(payment);
          },
        ),
      ),
    );
  }

  Widget _buildPaymentCard(Payment payment) {
    final currencyFormat = NumberFormat.currency(symbol: 'R ', decimalDigits: 2);
    final dateFormat = DateFormat('dd MMM yyyy, HH:mm');

    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: () => controller.goToPaymentDetails(payment),
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with status badge and amount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(payment.status).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: _getStatusColor(payment.status).withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getStatusIcon(payment.status),
                          size: 14.sp,
                          color: _getStatusColor(payment.status),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          payment.displayStatus,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: _getStatusColor(payment.status),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Amount
                  Text(
                    currencyFormat.format(payment.amount),
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: LightThemeColors.bodyTextColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Divider(color: LightThemeColors.dividerColor),
              SizedBox(height: 12.h),
              // Payment details
              _buildInfoRow(
                Icons.receipt,
                'Payment ID',
                '#${payment.paymentId}',
              ),
              if (payment.prescriptionId != null) ...[
                SizedBox(height: 8.h),
                _buildInfoRow(
                  Icons.medical_services,
                  'Prescription ID',
                  '#${payment.prescriptionId}',
                ),
              ],
              SizedBox(height: 8.h),
              _buildInfoRow(
                Icons.access_time,
                'Date',
                dateFormat.format(payment.initiatedAt),
              ),
              if (payment.externalTransactionId != null) ...[
                SizedBox(height: 8.h),
                _buildInfoRow(
                  Icons.confirmation_number,
                  'Transaction ID',
                  payment.externalTransactionId!,
                  isSmallText: true,
                ),
              ],
              if (payment.failureReason != null) ...[
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: LightThemeColors.errorColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16.sp,
                        color: LightThemeColors.errorColor,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          payment.failureReason!,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: LightThemeColors.errorColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              // Retry button for failed payments
              if (payment.hasFailed && payment.prescriptionId != null) ...[
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => controller.retryPayment(payment),
                    icon: const Icon(Icons.refresh, size: 18),
                    label: const Text('Retry Payment'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: LightThemeColors.primaryColor,
                      side: const BorderSide(
                        color: LightThemeColors.primaryColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value, {
    bool isSmallText = false,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: LightThemeColors.bodySmallTextColor,
        ),
        SizedBox(width: 8.w),
        Text(
          '$label:',
          style: TextStyle(
            fontSize: isSmallText ? 11.sp : 13.sp,
            color: LightThemeColors.bodySmallTextColor,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: isSmallText ? 11.sp : 13.sp,
              fontWeight: FontWeight.w600,
              color: LightThemeColors.bodyTextColor,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return LightThemeColors.successColor;
      case 'Pending':
        return LightThemeColors.warningColor;
      case 'Failed':
      case 'Cancelled':
        return LightThemeColors.errorColor;
      case 'Refunded':
        return LightThemeColors.infoColor;
      default:
        return LightThemeColors.bodySmallTextColor;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Completed':
        return Icons.check_circle;
      case 'Pending':
        return Icons.access_time;
      case 'Failed':
        return Icons.error;
      case 'Cancelled':
        return Icons.cancel;
      case 'Refunded':
        return Icons.replay;
      default:
        return Icons.help_outline;
    }
  }
}
