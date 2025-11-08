import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, MultipartFile, FormData;
import '../data/models/prescription_model.dart';
import '../../utils/constants.dart';
import 'base_client.dart';
import 'auth_service.dart';

class PrescriptionService extends GetxService {
  static final PrescriptionService _instance = PrescriptionService._internal();
  factory PrescriptionService() => _instance;
  PrescriptionService._internal();

  final _authService = AuthService();

  // Upload prescription with files
  Future<int?> uploadPrescription({
    required int beneficiaryId,
    required DateTime issuedDate,
    required DateTime expiryDate,
    String? notes,
    required List<File> files,
    Function(int, int)? onUploadProgress,
    required Function(int) onSuccess,
    Function(String)? onError,
  }) async {
    int? prescriptionId;

    try {
      // Create multipart files
      final List<MultipartFile> multipartFiles = [];
      for (final file in files) {
        multipartFiles.add(
          await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          ),
        );
      }

      // Create form data
      final formData = FormData.fromMap({
        'BeneficiaryId': beneficiaryId,
        'IssuedDate': issuedDate.toIso8601String(),
        'ExpiryDate': expiryDate.toIso8601String(),
        if (notes != null && notes.isNotEmpty) 'Notes': notes,
        'Files': multipartFiles,
      });

      // Make request
      final response = await BaseClient.dio.post(
        Constants.uploadPrescriptionUrl,
        data: formData,
        options: Options(
          headers: _authService.authHeaders,
        ),
        onSendProgress: onUploadProgress,
      );

      if (response.data['isSuccess'] == true) {
        prescriptionId = response.data['value'];
        onSuccess(prescriptionId!);
      } else {
        onError?.call('Failed to upload prescription');
      }
    } catch (e) {
      onError?.call(e.toString());
    }

    return prescriptionId;
  }

  // Get prescription details
  Future<Prescription?> getPrescription({
    required int prescriptionId,
    Function(Prescription)? onSuccess,
    Function(String)? onError,
  }) async {
    Prescription? prescription;

    await BaseClient.safeApiCall(
      Constants.getPrescriptionUrl(prescriptionId),
      RequestType.get,
      headers: _authService.authHeaders,
      onSuccess: (response) {
        if (response.data['isSuccess'] == true && response.data['value'] != null) {
          prescription = Prescription.fromJson(response.data['value']);
          onSuccess?.call(prescription!);
        }
      },
      onError: (error) {
        onError?.call(error.message);
      },
    );

    return prescription;
  }

  // Get all prescriptions (if endpoint exists)
  Future<List<Prescription>> getAllPrescriptions({
    Function()? onLoading,
    Function(List<Prescription>)? onSuccess,
    Function(String)? onError,
  }) async {
    List<Prescription> prescriptions = [];

    await BaseClient.safeApiCall(
      Constants.getAllPrescriptionsUrl,
      RequestType.get,
      headers: _authService.authHeaders,
      onLoading: onLoading,
      onSuccess: (response) {
        if (response.data['isSuccess'] == true && response.data['value'] != null) {
          final List<dynamic> data = response.data['value'];
          prescriptions = data.map((json) => Prescription.fromJson(json)).toList();
          onSuccess?.call(prescriptions);
        }
      },
      onError: (error) {
        onError?.call(error.message);
      },
    );

    return prescriptions;
  }
}
