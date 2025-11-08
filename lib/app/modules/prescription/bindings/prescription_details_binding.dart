import 'package:get/get.dart';
import '../controllers/prescription_details_controller.dart';

class PrescriptionDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrescriptionDetailsController>(
      () => PrescriptionDetailsController(),
    );
  }
}
