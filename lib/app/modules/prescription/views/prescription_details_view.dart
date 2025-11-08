import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../components/my_widgets_animator.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../controllers/prescription_details_controller.dart';

class PrescriptionDetailsView extends GetView<PrescriptionDetailsController> {
  const PrescriptionDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightThemeColors.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Prescription Details',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshDetails,
          ),
        ],
      ),
      body: Obx(() => MyWidgetsAnimator(
            apiCallStatus: controller.apiCallStatus.value,
            loadingWidget: () => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: () => Center(
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
                    'Failed to load prescription details',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: LightThemeColors.bodyTextColor,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton.icon(
                    onPressed: controller.refreshDetails,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
            successWidget: () {
              final prescription = controller.prescription.value!;
              return RefreshIndicator(
                onRefresh: controller.refreshDetails,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header Card
                      _buildHeaderCard(prescription),

                      SizedBox(height: 16.h),

                      // Details Card
                      _buildDetailsCard(prescription),

                      SizedBox(height: 16.h),

                      // Images Gallery
                      if (prescription.files != null && prescription.files!.isNotEmpty)
                        _buildImagesGallery(prescription),

                      SizedBox(height: 16.h),

                      // Status History
                      _buildStatusHistory(),

                      SizedBox(height: 16.h),

                      // Payment Button
                      if (prescription.requiresPayment) _buildPaymentButton(),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }

  Widget _buildHeaderCard(prescription) {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            LightThemeColors.primaryColor,
            LightThemeColors.primaryLight,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: LightThemeColors.primaryColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.receipt,
                  size: 30.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prescription #${prescription.id}',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      prescription.beneficiaryName ?? 'N/A',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getStatusIcon(prescription.status),
                  size: 18.sp,
                  color: _getStatusColor(prescription.statusColor),
                ),
                SizedBox(width: 8.w),
                Text(
                  prescription.displayStatus,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: _getStatusColor(prescription.statusColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(prescription) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Details',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: LightThemeColors.bodyTextColor,
            ),
          ),
          SizedBox(height: 16.h),
          _buildDetailRow(
            'Issued Date',
            dateFormat.format(prescription.issuedDate),
            Icons.calendar_today,
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            'Expiry Date',
            dateFormat.format(prescription.expiryDate),
            Icons.event_busy,
            isExpired: prescription.isExpired,
          ),
          if (prescription.createdAt != null) ...[
            SizedBox(height: 12.h),
            _buildDetailRow(
              'Uploaded',
              dateFormat.format(prescription.createdAt!),
              Icons.upload,
            ),
          ],
          if (prescription.notes != null && prescription.notes!.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Divider(color: LightThemeColors.dividerColor),
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.note,
                  size: 20.sp,
                  color: LightThemeColors.primaryColor,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notes',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: LightThemeColors.bodySmallTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        prescription.notes!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: LightThemeColors.bodyTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    IconData icon, {
    bool isExpired = false,
  }) {
    final color = isExpired
        ? LightThemeColors.errorColor
        : LightThemeColors.bodyTextColor;

    return Row(
      children: [
        Icon(
          icon,
          size: 20.sp,
          color: isExpired
              ? LightThemeColors.errorColor
              : LightThemeColors.primaryColor,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: LightThemeColors.bodySmallTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: color,
                  fontWeight: isExpired ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImagesGallery(prescription) {
    final imageFiles = prescription.files!.where((f) => f.isImage).toList();

    if (imageFiles.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.photo_library,
                size: 20.sp,
                color: LightThemeColors.primaryColor,
              ),
              SizedBox(width: 8.w),
              Text(
                'Prescription Images',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: LightThemeColors.bodyTextColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
            ),
            itemCount: imageFiles.length,
            itemBuilder: (context, index) {
              final file = imageFiles[index];
              return _buildImageThumbnail(file.fileUrl, index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImageThumbnail(String imageUrl, int index) {
    return InkWell(
      onTap: () {
        // Show full-screen image viewer
        Get.dialog(
          Dialog(
            backgroundColor: Colors.black,
            child: Stack(
              children: [
                Center(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error, color: Colors.white),
                  ),
                ),
                Positioned(
                  top: 40.h,
                  right: 16.w,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: LightThemeColors.dividerColor,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey[200],
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[200],
              child: Icon(
                Icons.broken_image,
                size: 40.sp,
                color: Colors.grey[400],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusHistory() {
    final history = controller.getStatusHistory();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.timeline,
                size: 20.sp,
                color: LightThemeColors.primaryColor,
              ),
              SizedBox(width: 8.w),
              Text(
                'Status History',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: LightThemeColors.bodyTextColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: history.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final item = history[index];
              final isLast = index == history.length - 1;
              return _buildStatusHistoryItem(item, isLast);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusHistoryItem(StatusHistoryItem item, bool isLast) {
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm a');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: isLast
                    ? LightThemeColors.primaryColor
                    : LightThemeColors.successColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2.w,
                height: 40.h,
                color: LightThemeColors.dividerColor,
              ),
          ],
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.status,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: LightThemeColors.bodyTextColor,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                item.description,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: LightThemeColors.bodySmallTextColor,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                dateFormat.format(item.timestamp),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: LightThemeColors.bodySmallTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ElevatedButton(
        onPressed: controller.navigateToPayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: LightThemeColors.accentColor,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.payment, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              'Make Payment',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String statusColor) {
    switch (statusColor) {
      case 'green':
        return LightThemeColors.successColor;
      case 'orange':
        return LightThemeColors.warningColor;
      case 'red':
        return LightThemeColors.errorColor;
      case 'blue':
        return LightThemeColors.infoColor;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Pending':
      case 'PaymentPending':
        return Icons.pending;
      case 'Approved':
      case 'FullyDispensed':
      case 'Delivered':
        return Icons.check_circle;
      case 'Rejected':
      case 'Cancelled':
        return Icons.cancel;
      case 'UnderReview':
      case 'OnHold':
        return Icons.hourglass_empty;
      default:
        return Icons.info;
    }
  }
}
