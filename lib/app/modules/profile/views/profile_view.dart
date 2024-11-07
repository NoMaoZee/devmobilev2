import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: controller.navigateToMainMenu,
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: controller.navigateToMainMenu,
            child: const Text(
              'Selesai',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: const Color.fromARGB(210, 224, 224, 224),
                backgroundImage: const AssetImage('assets/profile.png'),
              ),
              const SizedBox(height: 20),
              Obx(() => Text(
                    controller.userName.value,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  )),
              const SizedBox(height: 5),
              Obx(() => Text(
                    controller.address.value,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(height: 5),
              Obx(() => Text(
                    controller.phoneNumber.value,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  )),
              const SizedBox(height: 30),

              // User detail fields with edit option
              _profileOption('Nama Pengguna', controller, 'name'),
              _profileOption('No. Telepon', controller, 'phone'),
              _profileOption('Alamat', controller, 'address'),

              const SizedBox(height: 30),

              // Sign out button
              ElevatedButton.icon(
                onPressed: controller.logout,
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileOption(
      String title, ProfileController controller, String field) {
    return InkWell(
      onTap: () {
        _showEditDialog(controller, field, title);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const Icon(Icons.edit, size: 20, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(
      ProfileController controller, String field, String title) {
    final TextEditingController textController = TextEditingController();
    String currentValue;

    if (field == 'name') {
      currentValue = controller.userName.value;
    } else if (field == 'phone') {
      currentValue = controller.phoneNumber.value;
    } else {
      currentValue = controller.address.value;
    }
    textController.text = currentValue;

    Get.defaultDialog(
      title: 'Edit $title',
      content: TextField(
        controller: textController,
        decoration: InputDecoration(hintText: 'Masukkan $title baru'),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          controller.updateUserData(field, textController.text);
          Get.back(); // Close the dialog
        },
        child: const Text('Simpan'),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: const Text('Batal'),
      ),
    );
  }
}
