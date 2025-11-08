import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/auth_service.dart';
import '../../../services/base_client.dart';
import '../../../components/custom_snackbar.dart';
import '../../../components/custom_loading_overlay.dart';
import '../../../../utils/constants.dart';

class ChangePasswordController extends GetxController {
  final AuthService _authService = AuthService();

  // Form controllers
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observables
  final RxBool isLoading = false.obs;
  final RxBool obscureCurrentPassword = true.obs;
  final RxBool obscureNewPassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;
  final RxString currentPasswordError = ''.obs;
  final RxString newPasswordError = ''.obs;
  final RxString confirmPasswordError = ''.obs;
  final RxDouble passwordStrength = 0.0.obs;
  final RxString passwordStrengthText = ''.obs;
  final Rx<Color> passwordStrengthColor = const Color(0xFFEF5350).obs;

  // Form key
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void toggleCurrentPasswordVisibility() {
    obscureCurrentPassword.value = !obscureCurrentPassword.value;
  }

  void toggleNewPasswordVisibility() {
    obscureNewPassword.value = !obscureNewPassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  void onNewPasswordChanged(String password) {
    _calculatePasswordStrength(password);
    if (newPasswordError.value.isNotEmpty) {
      newPasswordError.value = '';
    }
  }

  void _calculatePasswordStrength(String password) {
    if (password.isEmpty) {
      passwordStrength.value = 0.0;
      passwordStrengthText.value = '';
      passwordStrengthColor.value = const Color(0xFFEF5350);
      return;
    }

    double strength = 0.0;

    // Length check
    if (password.length >= 8) strength += 0.2;
    if (password.length >= 12) strength += 0.1;

    // Contains lowercase
    if (password.contains(RegExp(r'[a-z]'))) strength += 0.2;

    // Contains uppercase
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.2;

    // Contains numbers
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.2;

    // Contains special characters
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.1;

    passwordStrength.value = strength;

    if (strength <= 0.3) {
      passwordStrengthText.value = 'Weak';
      passwordStrengthColor.value = const Color(0xFFEF5350); // Red
    } else if (strength <= 0.6) {
      passwordStrengthText.value = 'Medium';
      passwordStrengthColor.value = const Color(0xFFFFA726); // Orange
    } else if (strength <= 0.8) {
      passwordStrengthText.value = 'Strong';
      passwordStrengthColor.value = const Color(0xFF66BB6A); // Light Green
    } else {
      passwordStrengthText.value = 'Very Strong';
      passwordStrengthColor.value = const Color(0xFF4CAF50); // Green
    }
  }

  bool _validateForm() {
    bool isValid = true;
    currentPasswordError.value = '';
    newPasswordError.value = '';
    confirmPasswordError.value = '';

    // Current password validation
    final currentPassword = currentPasswordController.text;
    if (currentPassword.isEmpty) {
      currentPasswordError.value = 'Current password is required';
      isValid = false;
    }

    // New password validation
    final newPassword = newPasswordController.text;
    if (newPassword.isEmpty) {
      newPasswordError.value = 'New password is required';
      isValid = false;
    } else if (newPassword.length < Constants.minPasswordLength) {
      newPasswordError.value = 'Password must be at least ${Constants.minPasswordLength} characters';
      isValid = false;
    } else if (newPassword == currentPassword) {
      newPasswordError.value = 'New password must be different from current password';
      isValid = false;
    } else if (passwordStrength.value < 0.4) {
      newPasswordError.value = 'Password is too weak. Use a stronger password';
      isValid = false;
    }

    // Confirm password validation
    final confirmPassword = confirmPasswordController.text;
    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = 'Please confirm your new password';
      isValid = false;
    } else if (confirmPassword != newPassword) {
      confirmPasswordError.value = 'Passwords do not match';
      isValid = false;
    }

    return isValid;
  }

  Future<void> changePassword() async {
    if (!_validateForm()) {
      return;
    }

    final user = _authService.currentUser.value;
    if (user == null) {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Error',
        message: 'User not found. Please login again.',
      );
      return;
    }

    await showLoadingOverLay(
      asyncFunction: () async {
        await BaseClient.safeApiCall(
          '${Constants.baseUrl}/authentication/change-password',
          RequestType.post,
          headers: _authService.authHeaders,
          data: {
            'userId': user.id,
            'currentPassword': currentPasswordController.text,
            'newPassword': newPasswordController.text,
          },
          onSuccess: (response) {
            if (response.data['isSuccess'] == true) {
              CustomSnackBar.showCustomSnackBar(
                title: 'Success',
                message: 'Password changed successfully',
              );
              Get.back(); // Return to profile screen
            } else {
              CustomSnackBar.showCustomErrorSnackBar(
                title: 'Change Password Failed',
                message: response.data['message'] ?? 'Failed to change password',
              );
            }
          },
          onError: (error) {
            CustomSnackBar.showCustomErrorSnackBar(
              title: 'Change Password Failed',
              message: error.message,
            );
          },
        );
      },
      msg: 'Changing password...',
    );
  }

  void cancel() {
    Get.back();
  }
}
