import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_menu_controller.dart';

class MainMenuView extends GetView<MainMenuController> {
  const MainMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hello there! 👋',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => Get.toNamed('/profile'), // Navigasi ke ProfileView
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Field
            TextField(
              onChanged: (query) => controller.searchServices(query),
              decoration: InputDecoration(
                hintText: 'Cari layanan...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 243, 243, 243),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Layanan kami',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Grid layanan dinamis
            Expanded(child: Obx(() {
              print(
                  controller.filteredServices); // Cek apakah data sudah dimuat
              return controller.filteredServices.isEmpty
                  ? const Center(child: Text('Layanan tidak ditemukan'))
                  : GridView.builder(
                      itemCount: controller.filteredServices.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        final service = controller.filteredServices[index];
                        return buildServiceOption(
                          service['title']!,
                          service['description']!,
                          service['image']!,
                        );
                      },
                    );
            })),
          ],
        ),
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
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
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
