import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterController extends GetxController {
  final logger = Logger();
  var registerButtonScale = 1.0.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var username = ''.obs;
  var email = ''.obs;
  var address = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;

  // Go back to the previous screen
  void goBack() => Get.back();

  // Register user
  Future<void> register() async {
    logger.i("Register button clicked");
    if (password.value != confirmPassword.value) {
      Get.snackbar('Error', 'Password dan Konfirmasi Password tidak cocok',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      logger.i("Starting Firebase Auth...");
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      logger.i("Firebase Auth Success!");

      String uid = userCredential.user!.uid;
      logger.i("Saving user to Firestore: $uid");

      await _firestore.collection('users').doc(uid).set({
        'username': username.value,
        'email': email.value,
        'address': address.value,
      });

      logger.i("User saved to Firestore.");
      Get.toNamed('/login');
    } catch (e) {
      logger.e("Error during registration: $e");
      Get.snackbar('Error', 'Failed to register: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Register using Google
  Future<void> registerWithGoogle() async {
    logger.i("Register with Google button clicked");
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the login
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create new credentials
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      String uid = userCredential.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'username': userCredential.user?.displayName ?? 'Anonymous',
        'email': userCredential.user?.email,
        'address': '',
      });

      logger.i("User registered with Google and saved to Firestore: $uid");
      Get.toNamed('/mainMenu');
    } catch (e) {
      logger.e("Failed to register with Google: $e");
      Get.snackbar('Error', 'Failed to register with Google: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Navigate to login screen
  void navigateToLogin() => Get.toNamed('/login');
}
