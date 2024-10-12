import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SettingsController extends GetxController {
  void logout() {
    // Logika untuk proses logout, misalnya menghapus token pengguna
    // dan navigasi ke halaman login
    Get.offAllNamed(Routes.login);
  }
}
