import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../controllers/upload_prescription_controller.dart';

class UploadPrescriptionView extends GetView<UploadPrescriptionController> {
  const UploadPrescriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightThemeColors.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Upload Prescription',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoadingBeneficiaries.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.beneficiaries.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.people_outline,
                  size: 80.sp,
                  color: LightThemeColors.bodySmallTextColor,
                ),
                SizedBox(height: 16.h),
                Text(
                  'No Beneficiaries Found',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: LightThemeColors.bodyTextColor,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Please add a beneficiary first',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: LightThemeColors.bodySmallTextColor,
                  ),
                ),
                SizedBox(height: 24.h),
                ElevatedButton.icon(
                  onPressed: () => Get.toNamed('/add-beneficiary'),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Beneficiary'),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Beneficiary Dropdown
                  _buildSectionTitle('Select Beneficiary'),
                  SizedBox(height: 8.h),
                  Obx(() => Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: LightThemeColors.dividerColor,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            value: controller.selectedBeneficiary.value,
                            hint: const Text('Select Beneficiary'),
                            items: controller.beneficiaries.map((beneficiary) {
                              return DropdownMenuItem(
                                value: beneficiary,
                                child: Text(
                                  beneficiary.fullName,
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              controller.selectedBeneficiary.value = value;
                            },
                          ),
                        ),
                      )),

                  SizedBox(height: 20.h),

                  // Issued Date
                  _buildSectionTitle('Issued Date'),
                  SizedBox(height: 8.h),
                  Obx(() => _buildDateField(
                        label: 'Select issued date',
                        date: controller.issuedDate.value,
                        onTap: () => controller.selectIssuedDate(context),
                        icon: Icons.calendar_today,
                      )),

                  SizedBox(height: 20.h),

                  // Expiry Date
                  _buildSectionTitle('Expiry Date'),
                  SizedBox(height: 8.h),
                  Obx(() => _buildDateField(
                        label: 'Select expiry date',
                        date: controller.expiryDate.value,
                        onTap: () => controller.selectExpiryDate(context),
                        icon: Icons.event_busy,
                      )),

                  SizedBox(height: 20.h),

                  // Notes
                  _buildSectionTitle('Notes (Optional)'),
                  SizedBox(height: 8.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: LightThemeColors.dividerColor,
                      ),
                    ),
                    child: TextField(
                      controller: controller.notesController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Add any additional notes...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16.w),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Images Section
                  _buildSectionTitle('Prescription Images'),
                  SizedBox(height: 8.h),

                  // Add Image Button
                  InkWell(
                    onTap: () => controller.showImagePickerOptions(context),
                    child: Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: LightThemeColors.primaryColor,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.add_photo_alternate,
                            size: 48.sp,
                            color: LightThemeColors.primaryColor,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Add Prescription Images',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: LightThemeColors.primaryColor,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Tap to select from camera or gallery',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: LightThemeColors.bodySmallTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Image Preview Grid
                  Obx(() {
                    if (controller.selectedImages.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return Column(
                      children: [
                        SizedBox(height: 16.h),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8.w,
                            mainAxisSpacing: 8.h,
                          ),
                          itemCount: controller.selectedImages.length,
                          itemBuilder: (context, index) {
                            return _buildImagePreview(
                              controller.selectedImages[index],
                              index,
                            );
                          },
                        ),
                      ],
                    );
                  }),

                  SizedBox(height: 24.h),

                  // Upload Button
                  Obx(() {
                    if (controller.isUploading.value) {
                      return Column(
                        children: [
                          LinearProgressIndicator(
                            value: controller.uploadProgress.value,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              LightThemeColors.primaryColor,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Uploading... ${(controller.uploadProgress.value * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: LightThemeColors.bodySmallTextColor,
                            ),
                          ),
                        ],
                      );
                    }

                    return ElevatedButton(
                      onPressed: controller.uploadPrescription,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: LightThemeColors.primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Upload Prescription',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: LightThemeColors.bodyTextColor,
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: LightThemeColors.dividerColor,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: LightThemeColors.primaryColor,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                date != null ? DateFormat('dd MMM yyyy').format(date) : label,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: date != null
                      ? LightThemeColors.bodyTextColor
                      : LightThemeColors.hintTextColor,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: LightThemeColors.bodySmallTextColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview(File imageFile, int index) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: LightThemeColors.dividerColor,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.file(
              imageFile,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
        Positioned(
          top: 4.h,
          right: 4.w,
          child: GestureDetector(
            onTap: () => controller.removeImage(index),
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 16.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
