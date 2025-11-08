import 'package:get/get.dart';
import '../../../services/auth_service.dart';
import '../../../data/models/auth_model.dart';
import '../../../routes/app_pages.dart';
import '../../../components/custom_snackbar.dart';

class ProfileController extends GetxController {
  final AuthService _authService = AuthService();

  // Observables
  final Rx<AuthUser?> user = Rx<AuthUser?>(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    user.value = _authService.currentUser.value;
    // Listen to auth service user changes
    _authService.currentUser.listen((updatedUser) {
      user.value = updatedUser;
    });
  }

  void navigateToEditProfile() {
    Get.toNamed(Routes.EDIT_PROFILE);
  }

  void navigateToChangePassword() {
    Get.toNamed(Routes.CHANGE_PASSWORD);
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      await _authService.logout();

      CustomSnackBar.showCustomSnackBar(
        title: 'Success',
        message: 'Logged out successfully',
      );

      // Navigate to login and clear all previous routes
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Error',
        message: 'Failed to logout. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  void confirmLogout() {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure you want to logout?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Get.theme.colorScheme.onPrimary,
      onConfirm: () {
        Get.back(); // Close dialog
        logout();
      },
    );
  }
}
