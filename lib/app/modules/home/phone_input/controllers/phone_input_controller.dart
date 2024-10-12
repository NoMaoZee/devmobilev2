import 'package:get/get.dart';
import 'package:devmobilev2/app/routes/app_pages.dart';

class PhoneInputController extends GetxController {
  var phoneNumber = ''.obs;

  void onSendOtp() {
    if (phoneNumber.value.isNotEmpty) {
      // Navigasi ke halaman verifikasi OTP
      Get.toNamed(Routes.verifikasiOtp);
    } else {
      Get.snackbar(
        'Error',
        'Please enter a valid phone number',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
