import 'package:devmobilev2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 20, 6, 211)),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Pengaturan',
          style: TextStyle(
            color: Color.fromARGB(255, 20, 6, 211),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAnimatedSection('Akun', [
                _buildSettingsItem(Icons.person, 'Edit Profil', () {
                  Get.toNamed(Routes.profile);
                }),
                _buildSettingsItem(Icons.security, 'Keamanan', () {}),
                _buildSettingsItem(Icons.notifications, 'Notifikasi', () {}),
                _buildSettingsItem(Icons.lock, 'Privasi', () {}),
              ]),
              _buildAnimatedSection('Langganan', [
                _buildSettingsItem(Icons.help, 'Bantuan & Dukungan', () {}),
                _buildSettingsItem(Icons.info, 'Syarat dan Kebijakan', () {}),
              ]),
              _buildAnimatedSection('Actions', [
                _buildSettingsItem(Icons.report, 'Laporkan Masalah', () {}),
                _buildSettingsItem(Icons.person_add, 'Tambah Akun', () {}),
                _buildSettingsItem(
                  Icons.logout,
                  'Log out',
                  () => controller.logout(),
                  isLogout: true,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedSection(String title, List<Widget> items) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 500),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(50 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 20, 6, 211),
              ),
            ),
          ),
          ...items,
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String label, VoidCallback onTap,
      {bool isLogout = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Icon(
          icon,
          color: isLogout ? Colors.red : Color.fromARGB(255, 20, 6, 211),
        ),
        title: Text(
          label,
          style: TextStyle(
            color: isLogout ? Colors.red : Colors.black,
            fontWeight: isLogout ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: isLogout ? Colors.red : Color.fromARGB(255, 20, 6, 211),
        ),
        onTap: onTap,
      ),
    );
  }
}
