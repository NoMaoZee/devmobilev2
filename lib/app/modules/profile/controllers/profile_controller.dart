// lib/app/modules/profile/controllers/profile_controller.dart

import 'package:get/get.dart';
import 'package:devmobilev2/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  // Method untuk navigasi ke halaman login saat logout
  void logout() {
    Get.offAllNamed(Routes.login); // Navigasi ke login screen
  }

  // Method untuk navigasi ke main menu saat menekan tombol 'Selesai' atau arrow back
  void navigateToMainMenu() {
    Get.toNamed('/mainMenu'); // Navigasi ke main menu
  }
}
