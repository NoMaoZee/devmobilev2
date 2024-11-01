import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.put(RegisterController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button with Alignment
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: controller.goBack,
                  ),
                ),
                const SizedBox(height: 40),

                // Welcome Text
                const Text(
                  'Hello! Register to get started',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),

                // Username Input
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.black), // Label color
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Email Input
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black), // Label color
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Address Input
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                    labelStyle: TextStyle(color: Colors.black), // Label color
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Password Input
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black), // Label color
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Confirm Password Input
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm password',
                    labelStyle: TextStyle(color: Colors.black), // Label color
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),

                // Register Button with Scale Animation
                Obx(
                  () => Transform.scale(
                    scale: controller.registerButtonScale.value,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          controller.registerButtonScale.value = 0.95;
                          Future.delayed(const Duration(milliseconds: 100), () {
                            controller.registerButtonScale.value = 1.0;
                            controller.register();
                          });
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Register with Google Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: controller.registerWithGoogle,
                    icon: Image.asset(
                      'assets/google.png',
                      width: 24,
                      height: 24,
                    ),
                    label: const Text(
                      'Register with Google',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 0, 0, 0), // Text color
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side:
                          const BorderSide(color: Colors.black), // Border color
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Login Navigation
                Center(
                  child: GestureDetector(
                    onTap: controller.navigateToLogin,
                    child: const Text(
                      'Have an account? Login',
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
        ),
      ),
    );
  }
}
