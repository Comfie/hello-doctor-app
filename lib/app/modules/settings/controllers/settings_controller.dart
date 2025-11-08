import 'package:get/get.dart';
import '../../../../config/theme/my_theme.dart';
import '../../../../config/translations/localization_service.dart';
import '../../../data/local/my_shared_pref.dart';

class SettingsController extends GetxController {
  // Theme state
  final isDarkMode = false.obs;

  // Language state
  final currentLanguage = 'en'.obs;

  // App version
  final String appVersion = '1.0.0';
  final String buildNumber = '1';

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  // Load current settings from storage
  void _loadSettings() {
    isDarkMode.value = !MySharedPref.getThemeIsLight();
    currentLanguage.value = MySharedPref.getCurrentLocal().languageCode;
  }

  // Toggle theme
  void toggleTheme() {
    MyTheme.changeTheme();
    isDarkMode.value = !MySharedPref.getThemeIsLight();
  }

  // Change language
  Future<void> changeLanguage(String languageCode) async {
    if (currentLanguage.value != languageCode) {
      await LocalizationService.updateLanguage(languageCode);
      currentLanguage.value = languageCode;

      // Show success message
      Get.snackbar(
        'Success',
        'Language changed successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  // Get language display name
  String getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'ar':
        return 'العربية';
      default:
        return 'English';
    }
  }

  // Navigate to Edit Profile
  void navigateToEditProfile() {
    Get.toNamed('/edit-profile');
  }

  // Navigate to Change Password
  void navigateToChangePassword() {
    Get.toNamed('/change-password');
  }

  // Navigate to About
  void navigateToAbout() {
    Get.toNamed('/about');
  }

  // Navigate to Terms of Service
  void navigateToTerms() {
    Get.toNamed('/terms');
  }

  // Navigate to Privacy Policy
  void navigateToPrivacy() {
    Get.toNamed('/privacy');
  }
}
