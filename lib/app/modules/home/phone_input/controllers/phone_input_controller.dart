import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../../routes/app_pages.dart';

class PhoneInputController extends GetxController {
  final Logger _logger = Logger();

  var phoneNumber = ''.obs;

  void onSendOtp() {
    if (phoneNumber.value.isNotEmpty) {
      _logger.i(
          'Navigating to verifikasi_otp with phoneNumber: ${phoneNumber.value}');
      Get.toNamed(Routes.verifikasiOtp,
          arguments: {'phoneNumber': phoneNumber.value});
    } else {
      _logger.e('Invalid phone number: ${phoneNumber.value}');
      Get.snackbar(
        'Error',
        'Please enter a valid phone number',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void backToLogin() {
    Get.offAllNamed('/login'); // Sama seperti di ForgotPasswordController
  }
}
