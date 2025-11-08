import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: LightThemeColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),

              // Security info message
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: LightThemeColors.warningColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: LightThemeColors.warningColor.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.security_outlined,
                      color: LightThemeColors.warningColor,
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'For your security, use a strong password with a mix of letters, numbers, and symbols',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: LightThemeColors.bodyTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              // Current Password field
              Text(
                'Current Password',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: LightThemeColors.bodyTextColor,
                ),
              ),
              SizedBox(height: 8.h),
              Obx(
                () => TextField(
                  controller: controller.currentPasswordController,
                  obscureText: controller.obscureCurrentPassword.value,
                  decoration: InputDecoration(
                    hintText: 'Enter your current password',
                    prefixIcon: Icon(Icons.lock_outline, size: 20.sp),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscureCurrentPassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20.sp,
                      ),
                      onPressed: controller.toggleCurrentPasswordVisibility,
                    ),
                    errorText: controller.currentPasswordError.value.isEmpty
                        ? null
                        : controller.currentPasswordError.value,
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
                    if (controller.currentPasswordError.value.isNotEmpty) {
                      controller.currentPasswordError.value = '';
                    }
                  },
                ),
              ),

              SizedBox(height: 20.h),

              // New Password field
              Text(
                'New Password',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: LightThemeColors.bodyTextColor,
                ),
              ),
              SizedBox(height: 8.h),
              Obx(
                () => TextField(
                  controller: controller.newPasswordController,
                  obscureText: controller.obscureNewPassword.value,
                  decoration: InputDecoration(
                    hintText: 'Enter your new password',
                    prefixIcon: Icon(Icons.lock_outline, size: 20.sp),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscureNewPassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20.sp,
                      ),
                      onPressed: controller.toggleNewPasswordVisibility,
                    ),
                    errorText: controller.newPasswordError.value.isEmpty
                        ? null
                        : controller.newPasswordError.value,
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
                  onChanged: controller.onNewPasswordChanged,
                ),
              ),

              SizedBox(height: 12.h),

              // Password Strength Indicator
              Obx(() {
                if (controller.passwordStrength.value > 0) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.r),
                              child: LinearProgressIndicator(
                                value: controller.passwordStrength.value,
                                backgroundColor:
                                    LightThemeColors.dividerColor,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  controller.passwordStrengthColor.value,
                                ),
                                minHeight: 6.h,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            controller.passwordStrengthText.value,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: controller.passwordStrengthColor.value,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Password must contain at least 8 characters, uppercase, lowercase, numbers, and special characters',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: LightThemeColors.bodySmallTextColor,
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              }),

              SizedBox(height: 20.h),

              // Confirm New Password field
              Text(
                'Confirm New Password',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: LightThemeColors.bodyTextColor,
                ),
              ),
              SizedBox(height: 8.h),
              Obx(
                () => TextField(
                  controller: controller.confirmPasswordController,
                  obscureText: controller.obscureConfirmPassword.value,
                  decoration: InputDecoration(
                    hintText: 'Confirm your new password',
                    prefixIcon: Icon(Icons.lock_outline, size: 20.sp),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscureConfirmPassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20.sp,
                      ),
                      onPressed: controller.toggleConfirmPasswordVisibility,
                    ),
                    errorText: controller.confirmPasswordError.value.isEmpty
                        ? null
                        : controller.confirmPasswordError.value,
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
                    if (controller.confirmPasswordError.value.isNotEmpty) {
                      controller.confirmPasswordError.value = '';
                    }
                  },
                ),
              ),

              SizedBox(height: 32.h),

              // Change Password Button
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: controller.changePassword,
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
                    'Change Password',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Cancel Button
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: OutlinedButton(
                  onPressed: controller.cancel,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: LightThemeColors.bodyTextColor,
                    side: const BorderSide(
                      color: LightThemeColors.dividerColor,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
