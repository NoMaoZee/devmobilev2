// lib/app/modules/profile/views/profile_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:devmobilev2/app/routes/app_pages.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.toNamed('/mainMenu'); // Navigate back to main menu
          },
        ),
        title: const Text('Profile'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile image and user info
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 10),
            const Text(
              'Admin',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text('+62 876256592617'),
            const Text('Jl. Kapal Laut, No.23'),
            const SizedBox(height: 20),

            // User detail fields
            _profileOption('Nama Pengguna'),
            _profileOption('No. Telepon'),
            _profileOption('Alamat'),
            _profileOption('Management'),

            const SizedBox(height: 20),

            // Sign out button
            ElevatedButton.icon(
              onPressed: () {
                Get.offAllNamed(Routes.login); // Navigate to login page
              },
              icon: const Icon(Icons.logout),
              label: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileOption(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          const Icon(Icons.edit, size: 20),
        ],
      ),
    );
  }
}
