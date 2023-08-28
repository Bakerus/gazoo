import 'package:get/get.dart';

import '../controllers/brand_controller.dart';

class BrandBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrandController>(
      () => BrandController(),
    );
  }
}
