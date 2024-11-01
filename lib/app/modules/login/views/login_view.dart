import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Get.back(),
                  ),
                ),
                const SizedBox(height: 40),

                // Welcome Text
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Laundry Clean and Wash. Again!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),

                // Email / Phone Number Input
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Enter your email/phone number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                // Password Input
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Enter your password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {}, // Tambahkan logika visibilitas
                    ),
                  ),
                ),

                // Forgot Password Button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: controller.navigateToForgotPassword,
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Divider Text
                Row(
                  children: const [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Or Login with'),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                const SizedBox(height: 20),

// Google Login Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: controller.loginWithGoogle,
                    icon: Image.asset(
                      'assets/google.png', // Pastikan file ini ada
                      width: 24,
                      height: 24,
                    ),
                    label: const Text(
                      'Login with Google',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // Set color to white
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.black, // Add background color
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side:
                          const BorderSide(color: Colors.black), // Border color
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Register Navigation
                Center(
                  child: GestureDetector(
                    onTap: controller.navigateToRegister,
                    child: const Text(
                      "Don't have an account? Register Now",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
