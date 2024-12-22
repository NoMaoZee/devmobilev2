// File: lib/main.dart
import 'package:devmobilev2/app/modules/main_menu/controllers/main_menu_controller.dart';
import 'package:devmobilev2/app/modules/order_menu/controllers/order_menu_controller.dart';
import 'package:devmobilev2/app/modules/payment/controllers/payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Mendaftarkan controller yang dibutuhkan secara global
  Get.put(MainMenuController());
  Get.put(OrderMenuController());
  Get.put(PaymentController()); // Mendaftarkan PaymentController di sini

  // Cek status login pengguna
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user == null) {
      // User belum login
      Get.offAllNamed('/home');
    } else {
      // User sudah login
      Get.offAllNamed(AppPages.initial);
    }
  });

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Laundry App",
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? '/home'
          : AppPages.initial,
      getPages: AppPages.routes,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
    ),
  );
}
