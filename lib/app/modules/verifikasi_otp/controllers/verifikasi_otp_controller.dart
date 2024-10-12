import 'package:get/get.dart';
import 'package:devmobilev2/app/routes/app_pages.dart';

class VerifikasiOtpController extends GetxController {
  var otpCode = ['', '', '', ''].obs;

  void setOtpCode(int index, String value) {
    if (value.isNotEmpty) {
      otpCode[index] = value;
    } else {
      otpCode[index] = '';
    }
  }

  void confirmOtp() {
    String otp = otpCode.join();
    if (otp.length == 4) {
      Get.snackbar(
        'Success',
        'OTP Confirmed: $otp',
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.toNamed(Routes.register); // Navigasi ke halaman register
    } else {
      Get.snackbar(
        'Error',
        'Please enter all 4 digits of the OTP',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void resendOtp() {
    Get.snackbar(
      'Resent',
      'OTP has been resent to your number',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}