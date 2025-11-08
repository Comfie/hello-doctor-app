import 'package:get/get.dart';
import '../../../../config/theme/my_theme.dart';
import '../../../../config/translations/localization_service.dart';
import '../../../data/local/my_shared_pref.dart';

class SettingsController extends GetxController {
  // Theme state - now supports system/light/dark
  final currentThemeMode = 'system'.obs;

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
    currentThemeMode.value = MySharedPref.getThemeMode();
    currentLanguage.value = MySharedPref.getCurrentLocal().languageCode;
  }

  // Change theme mode
  Future<void> changeThemeMode(String mode) async {
    await MyTheme.setThemeMode(mode);
    currentThemeMode.value = mode;

    // Show feedback
    String themeName = mode == 'system' ? 'System Default' : (mode == 'light' ? 'Light Mode' : 'Dark Mode');
    Get.snackbar(
      'Theme Changed',
      'Switched to $themeName',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  // Get theme mode display name
  String getThemeModeName(String mode) {
    switch (mode) {
      case 'system':
        return 'System Default';
      case 'light':
        return 'Light Mode';
      case 'dark':
        return 'Dark Mode';
      default:
        return 'System Default';
    }
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
