// lib/app/modules/main_menu/controllers/main_menu_controller.dart
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class MainMenuController extends GetxController {
  // Menyimpan indeks yang terpilih
  var selectedIndex = 0.obs;

  // Fungsi untuk menavigasi ke menu pemesanan
  void navigateToOrderMenu(String serviceType) {
    Get.toNamed(
      Routes.orderMenu,
      arguments: {'serviceType': serviceType},
    );
  }

  // Fungsi untuk memperbarui indeks yang terpilih
  void updateIndex(int index) {
    selectedIndex.value = index;
    // Menambahkan logika navigasi sesuai indeks
    switch (index) {
      case 0:
        Get.offAllNamed(Routes.mainMenu);
        break;
      case 1:
        Get.toNamed(Routes.payment); // Navigasi ke halaman Payment
        break;
      case 2:
        Get.toNamed(Routes.history); // Navigasi ke halaman Payment
        break;
      case 3:
        Get.toNamed(Routes.settings); // Navigasi ke halaman Payment
        break;
      default:
        break;
    }
  }
}
