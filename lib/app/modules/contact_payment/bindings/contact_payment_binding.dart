import 'package:get/get.dart';
import '../controllers/contact_payment_controller.dart';

class ContactPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactPaymentController>(() => ContactPaymentController());
  }
}
