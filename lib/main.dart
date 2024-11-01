// File: lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
