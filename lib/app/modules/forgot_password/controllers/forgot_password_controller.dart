// lib/app/modules/forgot_password/controllers/forgot_password_controller.dart
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ForgotPasswordController extends GetxController {
  final Logger _logger = Logger();

  var phoneNumber = ''.obs;
  var otp = ''.obs;
  var newPassword = ''.obs;
  var confirmPassword = ''.obs;

  void sendOTP() {
    _logger.i("Sending OTP to: ${phoneNumber.value}");
    if (phoneNumber.isNotEmpty) {
      Get.toNamed('/enter_otp');
    }
  }

  void verifyOTP() {
    _logger.i("Verifying OTP: ${otp.value}");
    if (otp.value.length == 4) {
      Get.toNamed('/create_password');
    }
  }

  void resetPassword() {
    _logger.i("Resetting password");
    if (newPassword.value == confirmPassword.value) {
      Get.toNamed('/password_changed');
    }
  }

  void backToLogin() {
    Get.offAllNamed('/login');
  }
}
