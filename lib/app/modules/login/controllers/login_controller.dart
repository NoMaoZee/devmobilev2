import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final Logger _logger = Logger();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var isLoading = false.obs; // Observable loading state
  var email = ''.obs; // Observable for email input
  var password = ''.obs; // Observable for password input

  // Login dengan email/password
  Future<void> loginWithEmailAndPassword() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      _logger.w("Email or password is empty");
      Get.snackbar('Error', 'Email and password cannot be empty.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      isLoading.value = true; // Start loading
      _logger.i("Attempting login with email and password...");

      // Firebase Authentication login
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.value.trim(),
        password: password.value.trim(),
      );

      // Jika login berhasil
      _logger.i(
          "Login successful for user: ${userCredential.user?.email ?? 'Unknown'}");
      Get.offAllNamed('/navbar'); // Navigate to navbar
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth errors
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else {
        errorMessage = 'Login failed: ${e.message}';
      }
      _logger.e("Login failed: $errorMessage");
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      // Handle other errors
      _logger.e("Unexpected error: $e");
      Get.snackbar('Error', 'An unexpected error occurred. Please try again.',
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
