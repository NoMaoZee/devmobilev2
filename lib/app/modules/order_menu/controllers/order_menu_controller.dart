// lib/app/modules/order_menu/controllers/order_menu_controller.dart
import 'package:get/get.dart';

class OrderMenuController extends GetxController {
  final selectedPackage = 'regular'.obs;
  final selectedDelivery = 'antar_jemput'.obs;
  final notes = ''.obs;
  final serviceType = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments['serviceType'] != null) {
      serviceType.value = Get.arguments['serviceType'];
    }
  }

  void setPackage(String package) => selectedPackage.value = package;
  void setDelivery(String delivery) => selectedDelivery.value = delivery;
  void setNotes(String value) => notes.value = value;

  void payNow() {
    // Implementasi pembayaran sekarang
    Get.toNamed('/payment');
  }

  void payLater() {
    // Implementasi pembayaran nanti
    Get.back();
  }
}
