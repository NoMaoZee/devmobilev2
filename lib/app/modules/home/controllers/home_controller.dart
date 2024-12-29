// 3. Update HomeController untuk menambahkan navigasi
// lib/app/modules/home/controllers/home_controller.dart
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  final count = 0.obs;

  void increment() => count.value++;

  void navigateToPhoneInput() {
    Get.toNamed(Routes.login);
  }
}
