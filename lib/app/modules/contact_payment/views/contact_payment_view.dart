// lib/app/modules/contact_payment/views/contact_payment_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/contact_payment_controller.dart';

class ContactPaymentView extends GetView<ContactPaymentController> {
  const ContactPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/whatsapp.png',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              '08xxxxxxxxxx',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
              onPressed: controller.navigateToMainMenu,
              child: const Text('Selesai'),
            )
          ],
        ),
      ),
    );
  }
}
