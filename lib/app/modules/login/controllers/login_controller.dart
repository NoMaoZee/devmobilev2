import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final Logger _logger = Logger();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var isLoading = false.obs; // Observable loading state

  // Login dengan email/password atau metode lain
  Future<void> login() async {
    try {
      isLoading.value = true; // Start loading
      _logger.i("Attempting standard login...");

      // TODO: tambahkan logika login dengan email/password jika dibutuhkan
      await Future.delayed(const Duration(seconds: 1)); // Simulasi proses login

      _logger.i("Standard login successful");
      Get.offAllNamed('/navbar'); // Navigate to navbar
    } catch (e) {
      _logger.e("Standard login failed: $e");
      Get.snackbar('Error', 'Login failed: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  // Login dengan Google
  Future<void> loginWithGoogle() async {
    _logger.i("Login with Google button clicked");
    isLoading.value = true; // Start loading

    try {
      // Proses login Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _logger.w("Google sign-in canceled");
        isLoading.value = false; // Stop loading
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential); // Firebase login
      _logger
          .i("Google sign-in successful for user: ${googleUser.displayName}");

      // Navigate to navbar after successful login
      Get.offAllNamed('/navbar');
    } catch (e) {
      _logger.e("Failed to login with Google: $e");
      Get.snackbar(
        'Error',
        'Failed to login with Google. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  // Navigasi ke halaman Forgot Password
  void navigateToForgotPassword() {
    _logger.i("Navigating to Forgot Password");
    Get.toNamed('/forgot_password');
  }

  // Navigasi ke halaman Register
  void navigateToRegister() {
    _logger.i("Navigating to Register");
    Get.toNamed('/register');
  }
}
