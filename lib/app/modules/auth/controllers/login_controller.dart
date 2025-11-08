import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/auth_service.dart';
import '../../../components/custom_snackbar.dart';
import '../../../components/custom_loading_overlay.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();

  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observables
  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;

  // Form key
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  bool _validateForm() {
    bool isValid = true;
    emailError.value = '';
    passwordError.value = '';

    // Email validation
    final email = emailController.text.trim();
    if (email.isEmpty) {
      emailError.value = 'Email is required';
      isValid = false;
    } else if (!GetUtils.isEmail(email)) {
      emailError.value = 'Please enter a valid email';
      isValid = false;
    }

    // Password validation
    final password = passwordController.text;
    if (password.isEmpty) {
      passwordError.value = 'Password is required';
      isValid = false;
    } else if (password.length < 8) {
      passwordError.value = 'Password must be at least 8 characters';
      isValid = false;
    }

    return isValid;
  }

  Future<void> login() async {
    if (!_validateForm()) {
      return;
    }

    await showLoadingOverLay(
      asyncFunction: () async {
        await _authService.login(
          email: emailController.text.trim(),
          password: passwordController.text,
          onSuccess: (response) {
            CustomSnackBar.showCustomSnackBar(
              title: 'Success',
              message: 'Welcome back, ${response.user?.firstName}!',
            );
            // Navigate to dashboard
            Get.offAllNamed(Routes.HOME);
          },
          onError: (error) {
            CustomSnackBar.showCustomErrorSnackBar(
              title: 'Login Failed',
              message: error,
            );
          },
        );
      },
      msg: 'Logging in...',
    );
  }

  void navigateToRegister() {
    Get.toNamed(Routes.REGISTER);
  }

  void navigateToForgotPassword() {
    // TODO: Implement forgot password navigation
    CustomSnackBar.showCustomToast(
      message: 'Forgot password feature coming soon',
    );
  }
}
