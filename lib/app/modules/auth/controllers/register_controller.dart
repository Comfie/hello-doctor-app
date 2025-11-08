import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/auth_service.dart';
import '../../../components/custom_snackbar.dart';
import '../../../components/custom_loading_overlay.dart';
import '../../../routes/app_routes.dart';

class RegisterController extends GetxController {
  final AuthService _authService = AuthService();

  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final idNumberController = TextEditingController();
  final addressController = TextEditingController();

  // Observables
  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;
  final Rx<DateTime?> dateOfBirth = Rx<DateTime?>(null);
  final RxString selectedGender = ''.obs;

  // Error messages
  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;
  final RxString confirmPasswordError = ''.obs;
  final RxString firstNameError = ''.obs;
  final RxString lastNameError = ''.obs;
  final RxString phoneNumberError = ''.obs;
  final RxString idNumberError = ''.obs;
  final RxString dateOfBirthError = ''.obs;
  final RxString genderError = ''.obs;
  final RxString addressError = ''.obs;

  // Form key
  final formKey = GlobalKey<FormState>();

  // Gender options
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    idNumberController.dispose();
    addressController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  void setGender(String? gender) {
    if (gender != null) {
      selectedGender.value = gender;
      genderError.value = '';
    }
  }

  Future<void> selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: LightThemeColors.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != dateOfBirth.value) {
      dateOfBirth.value = picked;
      dateOfBirthError.value = '';
    }
  }

  bool _validateForm() {
    bool isValid = true;

    // Clear all errors
    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
    firstNameError.value = '';
    lastNameError.value = '';
    phoneNumberError.value = '';
    idNumberError.value = '';
    dateOfBirthError.value = '';
    genderError.value = '';
    addressError.value = '';

    // First Name validation
    if (firstNameController.text.trim().isEmpty) {
      firstNameError.value = 'First name is required';
      isValid = false;
    }

    // Last Name validation
    if (lastNameController.text.trim().isEmpty) {
      lastNameError.value = 'Last name is required';
      isValid = false;
    }

    // Email validation
    final email = emailController.text.trim();
    if (email.isEmpty) {
      emailError.value = 'Email is required';
      isValid = false;
    } else if (!GetUtils.isEmail(email)) {
      emailError.value = 'Please enter a valid email';
      isValid = false;
    }

    // Phone Number validation
    final phone = phoneNumberController.text.trim();
    if (phone.isEmpty) {
      phoneNumberError.value = 'Phone number is required';
      isValid = false;
    } else if (!GetUtils.isPhoneNumber(phone)) {
      phoneNumberError.value = 'Please enter a valid phone number';
      isValid = false;
    }

    // ID Number validation
    if (idNumberController.text.trim().isEmpty) {
      idNumberError.value = 'ID number is required';
      isValid = false;
    }

    // Date of Birth validation
    if (dateOfBirth.value == null) {
      dateOfBirthError.value = 'Date of birth is required';
      isValid = false;
    }

    // Gender validation
    if (selectedGender.value.isEmpty) {
      genderError.value = 'Gender is required';
      isValid = false;
    }

    // Address validation
    if (addressController.text.trim().isEmpty) {
      addressError.value = 'Address is required';
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

    // Confirm Password validation
    final confirmPassword = confirmPasswordController.text;
    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = 'Please confirm your password';
      isValid = false;
    } else if (password != confirmPassword) {
      confirmPasswordError.value = 'Passwords do not match';
      isValid = false;
    }

    return isValid;
  }

  Future<void> register() async {
    if (!_validateForm()) {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Validation Error',
        message: 'Please fill in all required fields correctly',
      );
      return;
    }

    await showLoadingOverLay(
      asyncFunction: () async {
        await _authService.register(
          email: emailController.text.trim(),
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          phoneNumber: phoneNumberController.text.trim(),
          idNumber: idNumberController.text.trim(),
          dateOfBirth: dateOfBirth.value!,
          gender: selectedGender.value,
          address: addressController.text.trim(),
          onSuccess: () {
            CustomSnackBar.showCustomSnackBar(
              title: 'Success',
              message: 'Registration successful! Please login to continue.',
            );
            // Navigate back to login
            Get.back();
          },
          onError: (error) {
            CustomSnackBar.showCustomErrorSnackBar(
              title: 'Registration Failed',
              message: error,
            );
          },
        );
      },
      msg: 'Creating your account...',
    );
  }

  void navigateToLogin() {
    Get.back();
  }
}
