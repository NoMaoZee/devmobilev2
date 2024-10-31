import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:devmobilev2/app/routes/app_pages.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.toNamed('/mainMenu'); // Navigate back to main menu
          },
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed('/mainMenu'); // Navigate back to main menu
            },
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
              // Profile image and user info
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.shade300,
                child:
                    const Icon(Icons.person, size: 60, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              const Text(
                'Admin',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Text(
                '+62 876256592617',
                style: TextStyle(color: Colors.black54),
              ),
              const Text(
                'Jl. Kapal Laut, No.23',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 30),

              // User detail fields
              _profileOption('Nama Pengguna'),
              _profileOption('No. Telepon'),
              _profileOption('Alamat'),
              _profileOption('Management'),

              const SizedBox(height: 30),

              // Sign out button
              ElevatedButton.icon(
                onPressed: () {
                  Get.offAllNamed(Routes.login); // Navigate to login page
                },
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

  Widget _profileOption(String title) {
    return Container(
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
    );
  }
}
