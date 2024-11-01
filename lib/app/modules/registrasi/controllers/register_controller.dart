import 'package:get/get.dart';
import 'package:logger/logger.dart';

class RegisterController extends GetxController {
  final logger = Logger();
  var registerButtonScale = 1.0.obs; // Variabel untuk animasi skala tombol

  // Fungsi untuk kembali ke layar sebelumnya
  void goBack() {
    Get.back();
  }

  // Fungsi untuk registrasi
  void register() {
    logger.i("Register button clicked");
    // Tambahkan logika registrasi di sini
    // Misalnya, validasi input dan kirim data ke backend
    // Setelah berhasil registrasi, navigasi ke halaman login
    Get.toNamed('/login');
  }

  // Fungsi untuk registrasi menggunakan Google
  void registerWithGoogle() {
    logger.i("Register with Google button clicked");
    // Tambahkan logika registrasi dengan Google di sini
    // Anda bisa menggunakan Firebase Auth atau SDK lain untuk login dengan Google
  }

  // Fungsi untuk navigasi ke halaman login
  void navigateToLogin() {
    Get.toNamed('/login');
  }
}
