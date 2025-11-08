import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/models/beneficiary_model.dart';
import '../../../services/beneficiary_service.dart';
import '../../../services/prescription_service.dart';
import '../../../components/custom_snackbar.dart';

class UploadPrescriptionController extends GetxController {
  final _beneficiaryService = BeneficiaryService();
  final _prescriptionService = PrescriptionService();
  final _imagePicker = ImagePicker();

  // Form key
  final formKey = GlobalKey<FormState>();

  // Text editing controllers
  final notesController = TextEditingController();

  // Form fields
  final beneficiaries = <Beneficiary>[].obs;
  final selectedBeneficiary = Rx<Beneficiary?>(null);
  final issuedDate = Rx<DateTime?>(null);
  final expiryDate = Rx<DateTime?>(null);
  final selectedImages = <File>[].obs;

  // Loading states
  final isLoadingBeneficiaries = true.obs;
  final isUploading = false.obs;
  final uploadProgress = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadBeneficiaries();
  }

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }

  // Load beneficiaries
  Future<void> loadBeneficiaries() async {
    isLoadingBeneficiaries.value = true;

    await _beneficiaryService.getAllBeneficiaries(
      onSuccess: (data) {
        beneficiaries.value = data;
        if (data.isNotEmpty) {
          selectedBeneficiary.value = data.first;
        }
        isLoadingBeneficiaries.value = false;
      },
      onError: (error) {
        isLoadingBeneficiaries.value = false;
        CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message: error,
        );
      },
    );
  }

  // Select issued date
  Future<void> selectIssuedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: issuedDate.value ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
      helpText: 'Select Issued Date',
    );

    if (picked != null) {
      issuedDate.value = picked;
      // Auto-set expiry date to 6 months from issued date if not set
      if (expiryDate.value == null) {
        expiryDate.value = picked.add(const Duration(days: 180));
      }
    }
  }

  // Select expiry date
  Future<void> selectExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: expiryDate.value ?? DateTime.now().add(const Duration(days: 180)),
      firstDate: issuedDate.value ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      helpText: 'Select Expiry Date',
    );

    if (picked != null) {
      expiryDate.value = picked;
    }
  }

  // Pick images from camera
  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image != null) {
        selectedImages.add(File(image.path));
        CustomSnackBar.showCustomSnackBar(
          title: 'Success',
          message: 'Image added successfully',
        );
      }
    } catch (e) {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Error',
        message: 'Failed to capture image: ${e.toString()}',
      );
    }
  }

  // Pick images from gallery
  Future<void> pickImagesFromGallery() async {
    try {
      final List<XFile> images = await _imagePicker.pickMultiImage(
        imageQuality: 85,
      );

      if (images.isNotEmpty) {
        selectedImages.addAll(images.map((xFile) => File(xFile.path)));
        CustomSnackBar.showCustomSnackBar(
          title: 'Success',
          message: '${images.length} image(s) added',
        );
      }
    } catch (e) {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Error',
        message: 'Failed to pick images: ${e.toString()}',
      );
    }
  }

  // Show image picker options
  void showImagePickerOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text('Camera'),
                onTap: () {
                  Get.back();
                  pickImageFromCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: const Text('Gallery'),
                onTap: () {
                  Get.back();
                  pickImagesFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel, color: Colors.red),
                title: const Text('Cancel'),
                onTap: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Remove image
  void removeImage(int index) {
    selectedImages.removeAt(index);
    CustomSnackBar.showCustomSnackBar(
      title: 'Removed',
      message: 'Image removed',
    );
  }

  // Validate and upload prescription
  Future<void> uploadPrescription() async {
    // Validation
    if (selectedBeneficiary.value == null) {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Validation Error',
        message: 'Please select a beneficiary',
      );
      return;
    }

    if (issuedDate.value == null) {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Validation Error',
        message: 'Please select issued date',
      );
      return;
    }

    if (expiryDate.value == null) {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Validation Error',
        message: 'Please select expiry date',
      );
      return;
    }

    if (selectedImages.isEmpty) {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Validation Error',
        message: 'Please add at least one prescription image',
      );
      return;
    }

    if (expiryDate.value!.isBefore(issuedDate.value!)) {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Validation Error',
        message: 'Expiry date must be after issued date',
      );
      return;
    }

    // Start upload
    isUploading.value = true;
    uploadProgress.value = 0.0;

    await _prescriptionService.uploadPrescription(
      beneficiaryId: selectedBeneficiary.value!.id,
      issuedDate: issuedDate.value!,
      expiryDate: expiryDate.value!,
      notes: notesController.text.trim().isEmpty ? null : notesController.text.trim(),
      files: selectedImages,
      onUploadProgress: (sent, total) {
        uploadProgress.value = sent / total;
      },
      onSuccess: (prescriptionId) {
        isUploading.value = false;
        uploadProgress.value = 0.0;
        CustomSnackBar.showCustomSnackBar(
          title: 'Success',
          message: 'Prescription uploaded successfully',
        );
        // Return to previous screen with success result
        Get.back(result: true);
      },
      onError: (error) {
        isUploading.value = false;
        uploadProgress.value = 0.0;
        CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message: error,
        );
      },
    );
  }
}
