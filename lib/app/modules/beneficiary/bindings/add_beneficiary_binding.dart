import 'package:get/get.dart';
import '../controllers/add_beneficiary_controller.dart';

class AddBeneficiaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddBeneficiaryController>(
      () => AddBeneficiaryController(),
    );
  }
}
