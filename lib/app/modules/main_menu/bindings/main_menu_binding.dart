// File: lib/app/modules/main_menu/bindings/main_menu_binding.dart
import 'package:get/get.dart';
import '../controllers/main_menu_controller.dart';

class MainMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainMenuController>(
      () => MainMenuController(),
    );
  }
}
