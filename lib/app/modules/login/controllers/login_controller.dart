import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:google_sign_in/google_sign_in.dart'; // Import Google Sign In

class LoginController extends GetxController {
  final Logger _logger = Logger();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void login() {
    // Logika login biasa
    Get.offAllNamed('/mainMenu');
  }

  void loginWithGoogle() async {
    _logger.i("Login with Google button clicked");

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google [UserCredential]
      await _auth.signInWithCredential(credential);
      _logger.i("User signed in: ${googleUser.displayName}");
      Get.offAllNamed('/mainMenu'); // Arahkan ke main menu
    } catch (e) {
      _logger.e("Failed to login with Google: $e");
      // Tampilkan pesan error jika login gagal
      Get.snackbar('Error', 'Failed to login with Google: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void navigateToForgotPassword() {
    Get.toNamed('/forgot_password');
  }

  void navigateToRegister() {
    Get.toNamed('/register');
  }
}
