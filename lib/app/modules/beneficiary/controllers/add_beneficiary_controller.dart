import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/beneficiary_service.dart';
import '../../../components/custom_snackbar.dart';

class AddBeneficiaryController extends GetxController {
  final _beneficiaryService = BeneficiaryService();

  // Form key
  final formKey = GlobalKey<FormState>();

  // Text editing controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final idNumberController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  // Form fields
  final dateOfBirth = Rx<DateTime?>(null);
  final selectedGender = 'Male'.obs;
  final selectedRelationship = 'Spouse'.obs;

  // Loading state
  final isLoading = false.obs;

  // Gender options
  final genderOptions = ['Male', 'Female', 'Other'];

  // Relationship options
  final relationshipOptions = [
    'Spouse',
    'Child',
    'Parent',
    'Sibling',
    'Other',
  ];

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    idNumberController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }

  // Select date of birth
  Future<void> selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateOfBirth.value ?? DateTime.now().subtract(const Duration(days: 365 * 20)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Select Date of Birth',
    );

    if (picked != null) {
      dateOfBirth.value = picked;
    }
  }

  // Validate and submit form
  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (dateOfBirth.value == null) {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Validation Error',
        message: 'Please select date of birth',
      );
      return;
    }

    isLoading.value = true;

    await _beneficiaryService.createBeneficiary(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      idNumber: idNumberController.text.trim(),
      dateOfBirth: dateOfBirth.value!,
      gender: selectedGender.value,
      relationship: selectedRelationship.value,
      email: emailController.text.trim().isEmpty ? null : emailController.text.trim(),
      phoneNumber: phoneNumberController.text.trim().isEmpty ? null : phoneNumberController.text.trim(),
      onSuccess: (beneficiaryId) {
        isLoading.value = false;
        CustomSnackBar.showCustomSnackBar(
          title: 'Success',
          message: 'Beneficiary added successfully',
        );
        // Return to previous screen with success result
        Get.back(result: true);
      },
      onError: (error) {
        isLoading.value = false;
        CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message: error,
        );
      },
    );
  }

  // Validators
  String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? validateIdNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'ID Number is required';
    }
    if (value.trim().length < 5) {
      return 'ID Number must be at least 5 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Email is optional
    }
    if (!GetUtils.isEmail(value.trim())) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Phone number is optional
    }
    if (value.trim().length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}
