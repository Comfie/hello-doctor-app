import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../components/my_widgets_animator.dart';
import '../../../data/models/prescription_model.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../controllers/prescription_controller.dart';

class PrescriptionListView extends GetView<PrescriptionController> {
  const PrescriptionListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightThemeColors.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Prescriptions',
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
                    'Failed to load prescriptions',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: LightThemeColors.bodyTextColor,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton.icon(
                    onPressed: controller.loadPrescriptions,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
            emptyWidget: () => Center(
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
                    'No Prescriptions',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: LightThemeColors.bodyTextColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Upload your first prescription to get started',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: LightThemeColors.bodySmallTextColor,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton.icon(
                    onPressed: controller.goToUploadPrescription,
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Upload Prescription'),
                  ),
                ],
              ),
            ),
            successWidget: () => RefreshIndicator(
              onRefresh: controller.refreshPrescriptions,
              child: ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: controller.prescriptions.length,
                itemBuilder: (context, index) {
                  final prescription = controller.prescriptions[index];
                  return _buildPrescriptionCard(prescription);
                },
              ),
            ),
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.goToUploadPrescription,
        icon: const Icon(Icons.upload_file),
        label: const Text('Upload'),
        backgroundColor: LightThemeColors.primaryColor,
      ),
    );
  }

  Widget _buildPrescriptionCard(Prescription prescription) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: () => controller.goToPrescriptionDetails(prescription),
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with beneficiary name and status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: LightThemeColors.primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.receipt,
                            size: 20.sp,
                            color: LightThemeColors.primaryColor,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                prescription.beneficiaryName ?? 'N/A',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: LightThemeColors.bodyTextColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'ID: ${prescription.id}',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: LightThemeColors.bodySmallTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(prescription),
                ],
              ),
              SizedBox(height: 12.h),
              Divider(height: 1.h, color: LightThemeColors.dividerColor),
              SizedBox(height: 12.h),
              // Date information
              Row(
                children: [
                  Expanded(
                    child: _buildDateInfo(
                      'Issued',
                      prescription.issuedDate,
                      Icons.calendar_today,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildDateInfo(
                      'Expires',
                      prescription.expiryDate,
                      Icons.event_busy,
                      isExpiry: true,
                      isExpired: prescription.isExpired,
                    ),
                  ),
                ],
              ),
              // Notes if available
              if (prescription.notes != null && prescription.notes!.isNotEmpty) ...[
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: LightThemeColors.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.note,
                        size: 14.sp,
                        color: LightThemeColors.bodySmallTextColor,
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          prescription.notes!,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: LightThemeColors.bodySmallTextColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              // File count
              if (prescription.files != null && prescription.files!.isNotEmpty) ...[
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.attach_file,
                      size: 14.sp,
                      color: LightThemeColors.bodySmallTextColor,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${prescription.files!.length} file(s) attached',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: LightThemeColors.bodySmallTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(Prescription prescription) {
    Color backgroundColor;
    Color textColor;

    switch (prescription.statusColor) {
      case 'green':
        backgroundColor = LightThemeColors.successColor;
        textColor = Colors.white;
        break;
      case 'orange':
        backgroundColor = LightThemeColors.warningColor;
        textColor = Colors.white;
        break;
      case 'red':
        backgroundColor = LightThemeColors.errorColor;
        textColor = Colors.white;
        break;
      case 'blue':
        backgroundColor = LightThemeColors.infoColor;
        textColor = Colors.white;
        break;
      default:
        backgroundColor = Colors.grey;
        textColor = Colors.white;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        prescription.displayStatus,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildDateInfo(
    String label,
    DateTime date,
    IconData icon, {
    bool isExpiry = false,
    bool isExpired = false,
  }) {
    final dateStr = DateFormat('dd MMM yyyy').format(date);
    final color = (isExpiry && isExpired)
        ? LightThemeColors.errorColor
        : LightThemeColors.bodySmallTextColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 14.sp,
              color: color,
            ),
            SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          dateStr,
          style: TextStyle(
            fontSize: 13.sp,
            color: color,
            fontWeight: isExpired ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
