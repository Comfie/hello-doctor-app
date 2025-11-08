import 'package:get/get.dart';
import '../controllers/beneficiary_controller.dart';

class BeneficiaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BeneficiaryController>(
      () => BeneficiaryController(),
    );
  }
}
