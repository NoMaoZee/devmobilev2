// lib/app/modules/main_menu/views/main_menu_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_menu_controller.dart';

class MainMenuView extends GetView<MainMenuController> {
  const MainMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Hello there! 👋',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => _buildNotificationOverlay(context),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () =>
                Get.toNamed('/profile'), // Tambahkan navigasi ke ProfileView
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari layanan...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 243, 243, 243),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Layanan kami',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  buildServiceOption(
                    'Cuci Aja',
                    'Cuci bersih wangi, tapi ga disetrika',
                    'assets/cuciaja.png',
                  ),
                  buildServiceOption(
                    'Cuci Setrika',
                    'Cuci bersih wangi, dan di setrika',
                    'assets/cucisetrika.png',
                  ),
                  buildServiceOption(
                    'Dry Cleaning',
                    'Jas, Gaun, dan semacamnya bersih!',
                    'assets/drycleaning.png',
                  ),
                  buildServiceOption(
                    'Karpet',
                    'Biar nyaman lesehan santai-santai',
                    'assets/karpet.png',
                  ),
                  buildServiceOption(
                    'Custom',
                    'Sesuikan dengan baju yang kamu laundry',
                    'assets/custom.png',
                  ),
                  buildServiceOption(
                    'Sepatu & Tas',
                    'Biar tambah kece dan bersih',
                    'assets/sepatudantas.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF393E46),
        selectedItemColor: const Color.fromARGB(255, 57, 57, 57),
        unselectedItemColor: const Color.fromARGB(255, 82, 82, 82),
        currentIndex:
            controller.selectedIndex.value, // Pastikan ini menggunakan state
        onTap: (index) {
          controller.updateIndex(index); // Update nilai selectedIndex
          if (index == 0) {
            // Home
            Get.offAllNamed('/mainMenu');
          } else if (index == 1) {
            // Payment
            Get.toNamed('/payment'); // Navigasi ke halaman Payment
          } else if (index == 2) {
            // History
            Get.toNamed('/history');
          } else if (index == 3) {
            // Settings
            Get.toNamed('/settings');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationOverlay(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Positioned(
          top: 0,
          right: 16.0,
          child: Container(
            constraints: BoxConstraints(
              minWidth: 200,
              maxWidth: MediaQuery.of(context).size.width - 32,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildNotificationCard(
                  icon: Icons.payment,
                  text: 'Sedang menunggu pembayaran',
                  color: const Color(0xFFFFC107),
                ),
                const SizedBox(height: 10),
                _buildNotificationCard(
                  icon: Icons.refresh,
                  text: 'Pesanan anda sedang dalam proses!',
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                _buildNotificationCard(
                  icon: Icons.check_circle,
                  text: 'Pesanan anda selesai!',
                  color: const Color(0xFF00E676),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildServiceOption(
      String title, String description, String imagePath) {
    return GestureDetector(
      onTap: () => controller.navigateToOrderMenu(title),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromARGB(255, 250, 250, 250),
        ),
        child: Column(
          children: [
            Image.asset(imagePath, height: 50),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
