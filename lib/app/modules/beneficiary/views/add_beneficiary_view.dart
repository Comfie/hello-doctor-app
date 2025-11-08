import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../controllers/add_beneficiary_controller.dart';

class AddBeneficiaryView extends GetView<AddBeneficiaryController> {
  const AddBeneficiaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightThemeColors.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Add Beneficiary',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Personal Information Section
              _buildSectionTitle('Personal Information'),
              SizedBox(height: 16.h),
              _buildTextField(
                controller: controller.firstNameController,
                label: 'First Name',
                icon: Icons.person,
                validator: (value) => controller.validateRequired(value, 'First Name'),
              ),
              SizedBox(height: 16.h),
              _buildTextField(
                controller: controller.lastNameController,
                label: 'Last Name',
                icon: Icons.person_outline,
                validator: (value) => controller.validateRequired(value, 'Last Name'),
              ),
              SizedBox(height: 16.h),
              _buildTextField(
                controller: controller.idNumberController,
                label: 'ID Number',
                icon: Icons.badge,
                validator: controller.validateIdNumber,
              ),
              SizedBox(height: 16.h),
              _buildDateField(context),
              SizedBox(height: 16.h),
              _buildGenderDropdown(),
              SizedBox(height: 24.h),

              // Relationship Section
              _buildSectionTitle('Relationship'),
              SizedBox(height: 16.h),
              _buildRelationshipDropdown(),
              SizedBox(height: 24.h),

              // Contact Information Section
              _buildSectionTitle('Contact Information (Optional)'),
              SizedBox(height: 16.h),
              _buildTextField(
                controller: controller.emailController,
                label: 'Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: controller.validateEmail,
              ),
              SizedBox(height: 16.h),
              _buildTextField(
                controller: controller.phoneNumberController,
                label: 'Phone Number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: controller.validatePhoneNumber,
              ),
              SizedBox(height: 32.h),

              // Submit Button
              Obx(() => SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.submitForm,
                      child: controller.isLoading.value
                          ? SizedBox(
                              height: 20.h,
                              width: 20.h,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              'Add Beneficiary',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  )),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: LightThemeColors.bodyTextColor,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20.sp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: LightThemeColors.primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Obx(() => InkWell(
          onTap: () => controller.selectDateOfBirth(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 20.sp,
                  color: LightThemeColors.bodySmallTextColor,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date of Birth',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: LightThemeColors.bodySmallTextColor,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        controller.dateOfBirth.value != null
                            ? DateFormat('dd MMM yyyy')
                                .format(controller.dateOfBirth.value!)
                            : 'Select date',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: controller.dateOfBirth.value != null
                              ? LightThemeColors.bodyTextColor
                              : LightThemeColors.bodySmallTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: 24.sp,
                  color: LightThemeColors.bodySmallTextColor,
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildGenderDropdown() {
    return Obx(() => DropdownButtonFormField<String>(
          initialValue: controller.selectedGender.value,
          decoration: InputDecoration(
            labelText: 'Gender',
            prefixIcon: Icon(Icons.wc, size: 20.sp),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: LightThemeColors.primaryColor,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          items: controller.genderOptions.map((String gender) {
            return DropdownMenuItem<String>(
              value: gender,
              child: Text(gender),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              controller.selectedGender.value = newValue;
            }
          },
        ));
  }

  Widget _buildRelationshipDropdown() {
    return Obx(() => DropdownButtonFormField<String>(
          initialValue: controller.selectedRelationship.value,
          decoration: InputDecoration(
            labelText: 'Relationship',
            prefixIcon: Icon(Icons.favorite, size: 20.sp),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: LightThemeColors.primaryColor,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          items: controller.relationshipOptions.map((String relationship) {
            return DropdownMenuItem<String>(
              value: relationship,
              child: Text(relationship),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              controller.selectedRelationship.value = newValue;
            }
          },
        ));
  }
}
