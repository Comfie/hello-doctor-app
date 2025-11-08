import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../data/local/my_shared_pref.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Wait for 2 seconds to show splash screen
    await Future.delayed(const Duration(seconds: 2));

    // Simple check: is there user data in SharedPreferences?
    final userData = MySharedPref.getUserData();
    final userId = MySharedPref.getUserId();

    if (userData != null && userId != null) {
      // User has logged in before, navigate to dashboard
      Get.offAllNamed(Routes.DASHBOARD);
    } else {
      // User is not logged in, navigate to login
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
