import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';

class SplashController extends GetxController {
  final AuthService _authService = AuthService();

  @override
  void onInit() {
    super.onInit();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Wait for 2 seconds to show splash screen
    await Future.delayed(const Duration(seconds: 2));

    // Initialize auth service
    await _authService.init();

    // Check if user is authenticated
    if (_authService.isAuthenticated.value && _authService.hasValidToken) {
      // User is logged in, navigate to dashboard
      Get.offAllNamed(Routes.HOME);
    } else {
      // User is not logged in, navigate to login
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
