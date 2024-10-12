import 'package:get/get.dart';
import 'package:logger/logger.dart';

class LoginController extends GetxController {
  final Logger _logger = Logger();

  void login() {
    // Tambahkan logika login di sini
    Get.offAllNamed('/mainMenu');
    // Contoh: autentikasi, validasi, dll.
  }

  void loginWithGoogle() {
    // Logika untuk login dengan Google
    _logger.i("Login with Google button clicked");
  }

  void navigateToForgotPassword() {
    // Navigasi ke halaman lupa password
    Get.toNamed('/forgot_password');
  }

  void navigateToRegister() {
    // Navigasi ke halaman register
    Get.toNamed('/register');
  }
}
