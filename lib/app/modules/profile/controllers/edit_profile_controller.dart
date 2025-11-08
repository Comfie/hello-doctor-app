import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/auth_service.dart';
import '../../../components/custom_snackbar.dart';
import '../../../components/custom_loading_overlay.dart';

class EditProfileController extends GetxController {
  final AuthService _authService = AuthService();

  // Form controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();

  // Observables
  final RxBool isLoading = false.obs;
  final RxString firstNameError = ''.obs;
  final RxString lastNameError = ''.obs;
  final RxString phoneNumberError = ''.obs;
  final RxString addressError = ''.obs;

  // Form key
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    super.onClose();
  }

  void loadUserData() {
    final user = _authService.currentUser.value;
    if (user != null) {
      firstNameController.text = user.firstName;
      lastNameController.text = user.lastName;
      phoneNumberController.text = user.phoneNumber ?? '';
      addressController.text = user.address ?? '';
    }
  }

  bool _validateForm() {
    bool isValid = true;
    firstNameError.value = '';
    lastNameError.value = '';
    phoneNumberError.value = '';
    addressError.value = '';

    // First name validation
    final firstName = firstNameController.text.trim();
    if (firstName.isEmpty) {
      firstNameError.value = 'First name is required';
      isValid = false;
    } else if (firstName.length < 2) {
      firstNameError.value = 'First name must be at least 2 characters';
      isValid = false;
    }

    // Last name validation
    final lastName = lastNameController.text.trim();
    if (lastName.isEmpty) {
      lastNameError.value = 'Last name is required';
      isValid = false;
    } else if (lastName.length < 2) {
      lastNameError.value = 'Last name must be at least 2 characters';
      isValid = false;
    }

    // Phone number validation
    final phoneNumber = phoneNumberController.text.trim();
    if (phoneNumber.isNotEmpty && phoneNumber.length < 10) {
      phoneNumberError.value = 'Please enter a valid phone number';
      isValid = false;
    }

    // Address validation
    final address = addressController.text.trim();
    if (address.isEmpty) {
      addressError.value = 'Address is required';
      isValid = false;
    }

    return isValid;
  }

  Future<void> updateProfile() async {
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
        final success = await _authService.updateUserProfile(
          id: user.id,
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          phoneNumber: phoneNumberController.text.trim(),
          address: addressController.text.trim(),
          onSuccess: () {
            CustomSnackBar.showCustomSnackBar(
              title: 'Success',
              message: 'Profile updated successfully',
            );
            Get.back(); // Return to profile screen
          },
          onError: (error) {
            CustomSnackBar.showCustomErrorSnackBar(
              title: 'Update Failed',
              message: error,
            );
          },
        );
      },
      msg: 'Updating profile...',
    );
  }

  void cancel() {
    Get.back();
  }
}
