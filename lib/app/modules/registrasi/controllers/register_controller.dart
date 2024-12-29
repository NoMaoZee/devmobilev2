import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  // Register function
  void validateAndRegister() {
    if (validateForm()) {
      register();
    } else {
      Get.snackbar("Error", "Please fix all errors before proceeding");
    }
  }

  // Validate form inputs
  bool validateForm() {
    if (username.value.isEmpty ||
        email.value.isEmpty ||
        address.value.isEmpty ||
        password.value.isEmpty ||
        confirmPassword.value.isEmpty) {
      return false;
    }
    if (!email.value.contains('@')) {
      return false;
    }
    if (password.value.length < 6) {
      return false;
    }
    if (password.value != confirmPassword.value) {
      return false;
    }
    return true;
  }

  // Register user
  Future<void> register() async {
    logger.i("Register button clicked");

    // Validating input
    if (!validateForm()) {
      logger.w("Validation failed: All fields must be filled correctly");
      Get.snackbar('Error', 'Please fill all fields correctly',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      logger.i("Starting Firebase Auth...");

      // Register with Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      logger.i("Firebase Auth success: UID = ${userCredential.user?.uid}");

      String uid = userCredential.user!.uid;

      // Save to Firestore
      await _firestore.collection('users').doc(uid).set({
        'username': username.value.isEmpty ? 'User' : username.value,
        'email': email.value,
        'address': address.value.isEmpty ? 'Unknown' : address.value,
        'createdAt': FieldValue.serverTimestamp(),
      });

      logger.i("User saved to Firestore successfully.");

      // Navigate to login
      Get.snackbar('Success', 'Registration successful!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF4CAF50));
      Get.toNamed('/login');
    } on FirebaseAuthException catch (e) {
      logger.e("Firebase Auth Exception: ${e.code}, ${e.message}");
      handleFirebaseAuthError(e.code);
    } catch (e) {
      logger.e("Unknown Error during registration: $e");
      Get.snackbar('Error', 'An unknown error occurred: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Firebase Auth Error Handling
  void handleFirebaseAuthError(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        Get.snackbar('Error', 'Email is already in use',
            snackPosition: SnackPosition.BOTTOM);
        break;
      case 'invalid-email':
        Get.snackbar('Error', 'Invalid email format',
            snackPosition: SnackPosition.BOTTOM);
        break;
      case 'weak-password':
        Get.snackbar('Error', 'Password is too weak',
            snackPosition: SnackPosition.BOTTOM);
        break;
      default:
        Get.snackbar('Error', 'Registration failed: $errorCode',
            snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Register using Google
  Future<void> registerWithGoogle() async {
    logger.i("Register with Google button clicked");
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        logger.w("Google sign-in canceled by user");
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

      logger.i("Google Auth success: UID = ${userCredential.user?.uid}");

      String uid = userCredential.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'username': userCredential.user?.displayName ?? 'Anonymous',
        'email': userCredential.user?.email,
        'address': '',
      });

      logger
          .i("User registered with Google and saved to Firestore: UID = $uid");

      Get.snackbar('Success', 'Google login successful!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF4CAF50));
      Get.toNamed('/navbar');
    } catch (e) {
      logger.e("Failed to register with Google: $e");
      Get.snackbar('Error', 'Google login failed: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Navigate to login screen
  void navigateToLogin() => Get.toNamed('/login');
}
