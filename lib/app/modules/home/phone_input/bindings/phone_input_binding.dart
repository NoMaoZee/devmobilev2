// lib/app/modules/phone_input/bindings/phone_input_binding.dart
import 'package:get/get.dart';
import '../controllers/phone_input_controller.dart';

class PhoneInputBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhoneInputController>(
      () => PhoneInputController(),
    );
  }
}
