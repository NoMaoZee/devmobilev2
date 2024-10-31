import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Pengaturan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Akun'),
            _buildSettingsItem(Icons.person, 'Edit Profil', () {
              // Aksi untuk mengedit profil
            }),
            _buildSettingsItem(Icons.security, 'Keamanan', () {
              // Aksi untuk keamanan
            }),
            _buildSettingsItem(Icons.notifications, 'Notifikasi', () {
              // Aksi untuk notifikasi
            }),
            _buildSettingsItem(Icons.lock, 'Privasi', () {
              // Aksi untuk privasi
            }),
            const SizedBox(height: 16),
            _buildSectionTitle('Langganan'),
            _buildSettingsItem(Icons.help, 'Bantuan & Dukungan', () {
              // Aksi untuk bantuan
            }),
            _buildSettingsItem(Icons.info, 'Syarat dan Kebijakan', () {
              // Aksi untuk kebijakan
            }),
            const SizedBox(height: 16),
            _buildSectionTitle('Actions'),
            _buildSettingsItem(Icons.report, 'Laporkan Masalah', () {
              // Aksi untuk melaporkan masalah
            }),
            _buildSettingsItem(Icons.person_add, 'Tambah Akun', () {
              // Aksi untuk menambah akun
            }),
            _buildSettingsItem(Icons.logout, 'Log out', () {
              controller.logout();
            }),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: onTap,
    );
  }
}
