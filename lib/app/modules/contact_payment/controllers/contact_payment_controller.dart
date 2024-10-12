// lib/app/modules/contact_payment/controllers/contact_payment_controller.dart
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class ContactPaymentController extends GetxController {
  void navigateToMainMenu() {
    Get.offAllNamed(Routes.mainMenu);
  }
}
