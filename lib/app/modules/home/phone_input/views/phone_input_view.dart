import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/phone_input_controller.dart';

class PhoneInputView extends GetView<PhoneInputController> {
  const PhoneInputView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Your Phone Number',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'We will send an OTP to verify your phone number',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),
            TextField(
              onChanged: (value) => controller.phoneNumber.value = value,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                prefixText: '+62 ',
                hintText: 'Enter phone number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTapDown: (_) => controller.buttonScale.value = 0.95,
                onTapUp: (_) => controller.buttonScale.value = 1.0,
                onTap: controller.onSendOtp,
                child: Obx(() => Transform.scale(
                      scale: controller.buttonScale.value,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Send OTP',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    )),
              ),
            ),
            const Spacer(),
            Center(
              child: GestureDetector(
                onTap: controller.backToLogin,
                child: const Text(
                  "Remember Password? Login",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
