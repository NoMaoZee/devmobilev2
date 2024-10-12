// lib/app/modules/profile/bindings/profile_binding.dart

import 'package:get/get.dart';
import 'package:devmobilev2/app/modules/profile/controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
