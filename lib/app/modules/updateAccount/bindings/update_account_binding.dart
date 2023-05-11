import 'package:get/get.dart';

import '../controllers/update_account_controller.dart';

class UpdateAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateAccountController>(
      () => UpdateAccountController(),
    );
  }
}
