import 'package:get/get.dart';
import 'package:logger/logger.dart';

class RegisterController extends GetxController {
  final logger = Logger();

  // Fungsi untuk kembali ke layar sebelumnya
  void goBack() {
    Get.back();
  }

  // Fungsi untuk registrasi
  void register() {
    logger.i("Register button clicked");
    // Tambahkan logika registrasi di sini
    // Setelah berhasil registrasi, navigasi ke halaman login
    Get.toNamed('/login');
  }

  // Fungsi untuk navigasi ke halaman login
  void navigateToLogin() {
    Get.toNamed('/login');
  }
}
