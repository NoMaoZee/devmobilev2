import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class MainMenuController extends GetxController {
  // Menyimpan indeks yang terpilih
  var selectedIndex = 0.obs;

  // Data layanan
  final services = [
    {
      'title': 'Cuci Aja',
      'description': 'Cuci bersih wangi, tapi ga disetrika',
      'image': 'assets/cuciaja.png'
    },
    {
      'title': 'Cuci Setrika',
      'description': 'Cuci bersih wangi, dan di setrika',
      'image': 'assets/cucisetrika.png'
    },
    {
      'title': 'Dry Cleaning',
      'description': 'Jas, Gaun, dan semacamnya bersih!',
      'image': 'assets/drycleaning.png'
    },
    {
      'title': 'Karpet',
      'description': 'Biar nyaman lesehan santai-santai',
      'image': 'assets/karpet.png'
    },
    {
      'title': 'Custom',
      'description': 'Sesuikan dengan baju yang kamu laundry',
      'image': 'assets/custom.png'
    },
    {
      'title': 'Sepatu & Tas',
      'description': 'Biar tambah kece dan bersih',
      'image': 'assets/sepatudantas.png'
    },
  ];

  // Data layanan yang difilter
  var filteredServices = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredServices.addAll(services); // Awalnya tampil semua
  }

  // Fungsi pencarian layanan
  void searchServices(String query) {
    if (query.isEmpty) {
      filteredServices.assignAll(services);
    } else {
      filteredServices.assignAll(
        services
            .where((service) =>
                service['title']!.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  // Fungsi navigasi
  void navigateToOrderMenu(String serviceType) {
    Get.toNamed(
      Routes.orderMenu,
      arguments: {'serviceType': serviceType},
    );
  }

  // Perbarui indeks navbar
  void updateIndex(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        Get.offAllNamed(Routes.mainMenu);
        break;
      case 1:
        Get.toNamed(Routes.payment);
        break;
      case 2:
        Get.toNamed(Routes.history);
        break;
      case 3:
        Get.toNamed(Routes.settings);
        break;
    }
  }
}
