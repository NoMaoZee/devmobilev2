// lib/app/modules/payment/controllers/payment_controller.dart
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class PaymentController extends GetxController {
  void navigateToContactPayment() {
    Get.toNamed(Routes.payment); // Use Routes.payment
  }

  void navigateToMainMenu() {
    Get.offAllNamed(Routes.mainMenu);
  }
}
