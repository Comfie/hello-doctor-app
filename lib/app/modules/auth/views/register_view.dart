import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightThemeColors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: LightThemeColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Create Account',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),

              // Header
              Text(
                'Join Hello Doctor',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: LightThemeColors.displayTextColor,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Please fill in the details to create your account',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: LightThemeColors.bodySmallTextColor,
                ),
              ),

              SizedBox(height: 32.h),

              // First Name
              _buildTextField(
                label: 'First Name',
                controller: controller.firstNameController,
                errorObs: controller.firstNameError,
                icon: Icons.person_outline,
                hint: 'Enter your first name',
                keyboardType: TextInputType.name,
              ),

              SizedBox(height: 16.h),

              // Last Name
              _buildTextField(
                label: 'Last Name',
                controller: controller.lastNameController,
                errorObs: controller.lastNameError,
                icon: Icons.person_outline,
                hint: 'Enter your last name',
                keyboardType: TextInputType.name,
              ),

              SizedBox(height: 16.h),

              // Email
              _buildTextField(
                label: 'Email',
                controller: controller.emailController,
                errorObs: controller.emailError,
                icon: Icons.email_outlined,
                hint: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(height: 16.h),

              // Phone Number
              _buildTextField(
                label: 'Phone Number',
                controller: controller.phoneNumberController,
                errorObs: controller.phoneNumberError,
                icon: Icons.phone_outlined,
                hint: 'Enter your phone number',
                keyboardType: TextInputType.phone,
              ),

              SizedBox(height: 16.h),

              // ID Number
              _buildTextField(
                label: 'ID Number',
                controller: controller.idNumberController,
                errorObs: controller.idNumberError,
                icon: Icons.badge_outlined,
                hint: 'Enter your ID number',
                keyboardType: TextInputType.text,
              ),

              SizedBox(height: 16.h),

              // Date of Birth
              Text(
                'Date of Birth',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: LightThemeColors.bodyTextColor,
                ),
              ),
              SizedBox(height: 8.h),
              Obx(
                () => InkWell(
                  onTap: () => controller.selectDateOfBirth(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: controller.dateOfBirthError.value.isEmpty
                            ? LightThemeColors.dividerColor
                            : LightThemeColors.errorColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 20.sp,
                          color: LightThemeColors.iconColorLight,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            controller.dateOfBirth.value == null
                                ? 'Select your date of birth'
                                : DateFormat('dd MMM yyyy')
                                    .format(controller.dateOfBirth.value!),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: controller.dateOfBirth.value == null
                                  ? LightThemeColors.hintTextColor
                                  : LightThemeColors.bodyTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(
                () => controller.dateOfBirthError.value.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 8.h, left: 12.w),
                        child: Text(
                          controller.dateOfBirthError.value,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: LightThemeColors.errorColor,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              SizedBox(height: 16.h),

              // Gender
              Text(
                'Gender',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: LightThemeColors.bodyTextColor,
                ),
              ),
              SizedBox(height: 8.h),
              Obx(
                () => Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: controller.genderError.value.isEmpty
                          ? LightThemeColors.dividerColor
                          : LightThemeColors.errorColor,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text(
                        'Select your gender',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: LightThemeColors.hintTextColor,
                        ),
                      ),
                      value: controller.selectedGender.value.isEmpty
                          ? null
                          : controller.selectedGender.value,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: LightThemeColors.iconColorLight,
                      ),
                      items: controller.genderOptions.map((String gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Row(
                            children: [
                              Icon(
                                gender == 'Male'
                                    ? Icons.male
                                    : gender == 'Female'
                                        ? Icons.female
                                        : Icons.person,
                                size: 20.sp,
                                color: LightThemeColors.iconColorLight,
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                gender,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: LightThemeColors.bodyTextColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: controller.setGender,
                    ),
                  ),
                ),
              ),
              Obx(
                () => controller.genderError.value.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 8.h, left: 12.w),
                        child: Text(
                          controller.genderError.value,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: LightThemeColors.errorColor,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              SizedBox(height: 16.h),

              // Address
              Text(
                'Address',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: LightThemeColors.bodyTextColor,
                ),
              ),
              SizedBox(height: 8.h),
              Obx(
                () => TextField(
                  controller: controller.addressController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Enter your full address',
                    errorText: controller.addressError.value.isEmpty
                        ? null
                        : controller.addressError.value,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                        color: LightThemeColors.dividerColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                        color: LightThemeColors.dividerColor,
                      ),
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
                      borderSide: const BorderSide(
                        color: LightThemeColors.errorColor,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                  ),
                  onChanged: (_) {
                    if (controller.addressError.value.isNotEmpty) {
                      controller.addressError.value = '';
                    }
                  },
                ),
              ),

              SizedBox(height: 16.h),

              // Password
              _buildPasswordField(
                label: 'Password',
                controller: controller.passwordController,
                errorObs: controller.passwordError,
                obscureObs: controller.obscurePassword,
                onToggle: controller.togglePasswordVisibility,
                hint: 'Create a password (min. 8 characters)',
              ),

              SizedBox(height: 16.h),

              // Confirm Password
              _buildPasswordField(
                label: 'Confirm Password',
                controller: controller.confirmPasswordController,
                errorObs: controller.confirmPasswordError,
                obscureObs: controller.obscureConfirmPassword,
                onToggle: controller.toggleConfirmPasswordVisibility,
                hint: 'Re-enter your password',
              ),

              SizedBox(height: 32.h),

              // Register button
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: controller.register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LightThemeColors.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shadowColor: LightThemeColors.primaryColor.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // Login link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: LightThemeColors.bodyTextColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.navigateToLogin,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: LightThemeColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required RxString errorObs,
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: LightThemeColors.bodyTextColor,
          ),
        ),
        SizedBox(height: 8.h),
        Obx(
          () => TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(icon, size: 20.sp),
              errorText: errorObs.value.isEmpty ? null : errorObs.value,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: LightThemeColors.dividerColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: LightThemeColors.dividerColor,
                ),
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
                borderSide: const BorderSide(
                  color: LightThemeColors.errorColor,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
            onChanged: (_) {
              if (errorObs.value.isNotEmpty) {
                errorObs.value = '';
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required RxString errorObs,
    required RxBool obscureObs,
    required VoidCallback onToggle,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: LightThemeColors.bodyTextColor,
          ),
        ),
        SizedBox(height: 8.h),
        Obx(
          () => TextField(
            controller: controller,
            obscureText: obscureObs.value,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(Icons.lock_outline, size: 20.sp),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureObs.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20.sp,
                ),
                onPressed: onToggle,
              ),
              errorText: errorObs.value.isEmpty ? null : errorObs.value,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: LightThemeColors.dividerColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: LightThemeColors.dividerColor,
                ),
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
                borderSide: const BorderSide(
                  color: LightThemeColors.errorColor,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
            onChanged: (_) {
              if (errorObs.value.isNotEmpty) {
                errorObs.value = '';
              }
            },
          ),
        ),
      ],
    );
  }
}
