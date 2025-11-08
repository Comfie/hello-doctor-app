import 'package:get/get.dart' hide Response;
import '../data/models/beneficiary_model.dart';
import '../../utils/constants.dart';
import 'base_client.dart';
import 'auth_service.dart';

class BeneficiaryService extends GetxService {
  static final BeneficiaryService _instance = BeneficiaryService._internal();
  factory BeneficiaryService() => _instance;
  BeneficiaryService._internal();

  final _authService = AuthService();

  // Get all beneficiaries
  Future<List<Beneficiary>> getAllBeneficiaries({
    Function()? onLoading,
    Function(List<Beneficiary>)? onSuccess,
    Function(String)? onError,
  }) async {
    List<Beneficiary> beneficiaries = [];

    await BaseClient.safeApiCall(
      Constants.getAllBeneficiariesUrl,
      RequestType.get,
      headers: _authService.authHeaders,
      onLoading: onLoading,
      onSuccess: (response) {
        // Check if response is wrapped format
        if (response.data is Map && response.data['isSuccess'] == true && response.data['value'] != null) {
          final List<dynamic> data = response.data['value'];
          beneficiaries = data.map((json) => Beneficiary.fromJson(json)).toList();
          onSuccess?.call(beneficiaries);
        }
        // Handle direct array format (your API's actual format)
        else if (response.data is List) {
          final List<dynamic> data = response.data;
          beneficiaries = data.map((json) => Beneficiary.fromJson(json)).toList();
          onSuccess?.call(beneficiaries);
        }
      },
      onError: (error) {
        onError?.call(error.message);
      },
    );

    return beneficiaries;
  }

  // Get beneficiary by ID
  Future<Beneficiary?> getBeneficiary(int id) async {
    Beneficiary? beneficiary;

    await BaseClient.safeApiCall(
      Constants.getBeneficiaryUrl(id),
      RequestType.get,
      headers: _authService.authHeaders,
      onSuccess: (response) {
        if (response.data['isSuccess'] == true && response.data['value'] != null) {
          beneficiary = Beneficiary.fromJson(response.data['value']);
        }
      },
      onError: (error) {
        beneficiary = null;
      },
    );

    return beneficiary;
  }

  // Create beneficiary
  Future<int?> createBeneficiary({
    required String firstName,
    required String lastName,
    required String idNumber,
    required DateTime dateOfBirth,
    required String gender,
    required String relationship,
    String? email,
    String? phoneNumber,
    required Function(int) onSuccess,
    Function(String)? onError,
  }) async {
    int? beneficiaryId;

    await BaseClient.safeApiCall(
      Constants.createBeneficiaryUrl,
      RequestType.post,
      headers: _authService.authHeaders,
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'idNumber': idNumber,
        'dateOfBirth': dateOfBirth.toIso8601String(),
        'gender': gender,
        'relationship': relationship,
        if (email != null) 'email': email,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
      },
      onSuccess: (response) {
        if (response.data['isSuccess'] == true) {
          beneficiaryId = response.data['value'];
          onSuccess(beneficiaryId!);
        }
      },
      onError: (error) {
        onError?.call(error.message);
      },
    );

    return beneficiaryId;
  }

  // Update beneficiary
  Future<bool> updateBeneficiary({
    required int id,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    String? email,
    required Function() onSuccess,
    Function(String)? onError,
  }) async {
    bool success = false;

    await BaseClient.safeApiCall(
      Constants.updateBeneficiaryUrl,
      RequestType.put,
      headers: _authService.authHeaders,
      data: {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
        if (email != null) 'email': email,
      },
      onSuccess: (response) {
        if (response.data['isSuccess'] == true) {
          onSuccess();
          success = true;
        }
      },
      onError: (error) {
        onError?.call(error.message);
        success = false;
      },
    );

    return success;
  }

  // Delete beneficiary
  Future<bool> deleteBeneficiary({
    required int id,
    required Function() onSuccess,
    Function(String)? onError,
  }) async {
    bool success = false;

    await BaseClient.safeApiCall(
      Constants.deleteBeneficiaryUrl(id),
      RequestType.delete,
      headers: _authService.authHeaders,
      onSuccess: (response) {
        if (response.data['isSuccess'] == true) {
          onSuccess();
          success = true;
        }
      },
      onError: (error) {
        onError?.call(error.message);
        success = false;
      },
    );

    return success;
  }
}
